module ALSU #(
    parameter INPUT_PROIRITY = "A", /* Given priority to this port when there is a confilct */
    parameter FULL_ADDER = "ON"  /* When it is ON, cin input must be considered in addition*/
) (
    input  clk,       /* input clock */
    input  rst,       /* Active high asynchronous reset */
    input  [2:0]A,B,
    input  cin,       /* carry in bit, only valid if FULL_ADDER = "ON" */
    input  serial_in, /* Serial in bit used in shift operations only */
    input  red_op_A,  /* HIGH -> reduction would be executed on A rather than bitwise between A and B */
    input  red_op_B,  /* HIGH -> reduction would be executed on B rather than bitwise between A and B */
    input  [2:0]opcode, /* opcode describes the different operations executed */
    input  bypass_A,  /* HIGH -> A registered to the output ignoring the opcode */
    input  bypass_B,  /* HIGH -> B registered to the output ignoring the opcode */
    input  direction, /* the direction of the shift ot rotation operation is left when this input is HIGH */
    output reg [15:0]leds,/* when an invalid oper. occurs, these leds blink"BLINKING IS A WARNING". if a valid all set LOW */
    output reg [3:0]anode,   /* Output to drive the anodes of the seven segment display */
    output reg [6:0]cathode   /* Output to drive the cathodes of the seven segment display */
);
    /* create registers "D-FF" for all inputs except clk and rst */
    reg [2:0]A_r,B_r,opcode_r;
    reg cin_r,serial_in_r,red_op_A_r,red_op_B_r;
    reg bypass_A_r,bypass_B_r,direction_r;
    /* ALSU out is registered and is available at the rising edge of the clock */
    reg [5:0]out_r;

    /* check the INPUT_PRIORITY parameter once,
     * and store it in the internal signal "first priority" 
     */
    wire [2:0]First_priority ;
    assign First_priority=(INPUT_PROIRITY == "A")? A_r :
                          (INPUT_PROIRITY == "B")? B_r : 3'b000;

    wire [3:0]adder_out;
    wire [5:0]multiplier_out;
    /* Adder IP Instantiotion */
    generate
        if(FULL_ADDER == "ON")
           c_addsub_0 adder_mod (
             .A(A_r),             // input wire [2 : 0] A
             .B(B_r),             // input wire [2 : 0] B
             .C_IN(cin_r),        // input wire C_IN
             .S(adder_out)        // output wire [3 : 0] S
            ); 
        else if(FULL_ADDER == "OFF")
           c_addsub_0 adder_mod (
             .A(A_r),             // input wire [2 : 0] A
             .B(B_r),             // input wire [2 : 0] B
             .C_IN(cin_r),        // input wire C_IN
             .S(adder_out)        // output wire [3 : 0] S
            ); 
    endgenerate

    /* Multiplication IP Instantiotion */
    mult_gen_0 mult_mod (
        .A(A_r),  // input wire [2 : 0] A
        .B(B_r),  // input wire [2 : 0] B
        .P(multiplier_out)  // output wire [5 : 0] P
    );

    /* always block for storing the inputs value to D-FF with rising edge of clock if rst is LOW */
    always @(posedge clk or posedge rst) begin : INPUTS_REGISTERATION
        if(rst)begin
            A_r <= 0;
            B_r <= 0;
            opcode_r <=0;
            cin_r    <= 0;
            serial_in_r <= 0;
            red_op_A_r  <= 0;
            red_op_B_r  <= 0;
            bypass_A_r  <= 0;
            bypass_B_r  <= 0;
            direction_r <= 0;
            out_r <= 0;
        end
        else begin
            A_r <= A;
            B_r <= B;
            opcode_r <= opcode;
            cin_r    <= cin;
            serial_in_r <= serial_in;
            red_op_A_r  <= red_op_A;
            red_op_B_r  <= red_op_B;
            bypass_A_r  <= bypass_A;
            bypass_B_r  <= bypass_B;
            direction_r <= direction;

        if(bypass_A_r && bypass_B_r)
            out_r <= First_priority;
        else if (bypass_A_r)
            out_r <= A_r;
        else if (bypass_B_r)
            out_r <= B_r;
        else if(~invalid_case)begin
        case (opcode_r)
            3'b000 : begin
                /* AND operation */
                if(red_op_A_r && red_op_B_r)    out_r <= &First_priority;
                else if(red_op_A_r)     out_r <= & A_r;
                else if(red_op_B_r)     out_r <= & B_r;
                else    out_r <= A_r & B_r;
            end
            3'b001 : begin
                /* XOR operation */
                if(red_op_A_r && red_op_B_r)    out_r <= ^First_priority;
                else if(red_op_A_r)     out_r <= ^A_r;
                else if(red_op_B_r)     out_r <= ^B_r;
                else out_r <= A_r ^ B_r;
            end
            3'b010 :begin
                /* addition */
                 out_r <= adder_out;       
            end
            3'b011 : begin
                /* multiplication */
                out_r <= multiplier_out;
            end
            3'b100 : begin
                /* shift output by 1 */
                if(direction_r) begin
                    /* left shift */ 
                    out_r <= {out_r[4:0],serial_in_r};
                end
                else begin
                        /* right shift */
                    out_r <= {serial_in_r,out_r[5:1]};
                end
            end
            3'b101 :
                /* Rotate output by one */
                if(direction_r) begin
                    /* left rotation */
                    out_r <= {out_r[4:0],out_r[5]};
                end
                else begin
                    /* right rotation */
                    out_r <= {out_r[0],out_r[5:1]};
                end
        endcase
        end
        end 
    
    end

    reg invalid_case; /* HIGH if the invalid case occurs */
    reg blink_state;  /* leds are high or low */
    reg [32:0] blink_counter; // 33-bit wide counter sensitive to clock edge

    /* always block for leds toggle during invalid cases */
    always @(posedge clk or posedge rst) begin : INVALID_CASES_CHECKING
    /* There is an invalid case */
            /* 
             * IMPORTANT NOTE!!!
             * If the leds blinking began, you should press the reset button to disable it
             * and make sure you changed the invalid case conditions to valid ones
             */
        if (rst) begin
            invalid_case <= 0;
            blink_state <= 0;
            blink_counter <= 0;
            leds <= 0;
        end else begin
            if ((opcode_r == 3'b110) || (opcode_r == 3'b111))
                invalid_case <= 1;
            else if (((red_op_A_r) || (red_op_B_r)) && ((opcode_r != 3'b000) && (opcode_r != 3'b001)))
                invalid_case <= 1;
            else
                invalid_case <= 0;

            /* leds blinking */
            if (invalid_case) begin
                blink_counter <= blink_counter + 1;
                /* clock freq =100MHZ (10 ns periof)
                 * I need a delay (5 seconds) , as we know delay time = counter value * clock period
                 * counter value = 5s / 10ns = 1000_000_000 */
                if (blink_counter == 30'd1000_000_000) begin
                    blink_counter <= 0;
                    blink_state <= ~blink_state;
                    leds <= {16{blink_state}};
                end
            end else begin
                blink_counter <= 0;
                blink_state <= 0;
                leds <= 0;
            end
        end
    end
    
 reg [3:0]  nibble1, nibble0; // divid the out_r[5:0] into two internal signal
 reg [1:0]  digit_select;     // first segment or second or ...
 reg [18:0] refresh_counter; // 19-bit counter for refreshing the display

 // Clock divider for refreshing the display at ~1kHz (assuming 100MHz input clock)
 always @(posedge clk or posedge rst) begin
    if (rst) begin
        refresh_counter <= 0;
        digit_select <= 0;

    end else begin
        refresh_counter <= refresh_counter + 1;
        digit_select <= refresh_counter[18:17]; // Digit select based on the refresh counter 
    end
 end

 always @(*) begin : Seven_Segment
    nibble0 =out_r[3:0];
    nibble1 ={2'b00,out_r[5:4]};
    if(invalid_case)begin
        case(digit_select)
            2'b00: begin
                anode = 4'b1110; 
                // activate LED1 and Deactivate LED2, LED3, LED4
                cathode = 7'b1001100; // "4" 
            end
            2'b01: begin
                anode = 4'b1101; 
                // activate LED2 and Deactivate LED1, LED3, LED4
                cathode = 7'b0000001; // "0"  
            end   
            2'b10: begin
                anode = 4'b1011; 
                // activate LED3 and Deactivate LED2, LED1, LED4
                cathode = 7'b1001100; // "4" 
            end
            2'b11: begin
                anode = 4'b0111; 
                // activate LED4 and Deactivate LED2, LED3, LED1
                cathode = 7'b0110000; // "E"   
            end        
        endcase
    end else begin
        case(digit_select)
            2'b00:  begin
                anode = 4'b1110; 
                // activate LED1 and Deactivate LED2, LED3, LED4
                case(nibble0)
                    4'b0000: cathode = 7'b0000001; // "0"     
                    4'b0001: cathode = 7'b1001111; // "1" 
                    4'b0010: cathode = 7'b0010010; // "2" 
                    4'b0011: cathode = 7'b0000110; // "3" 
                    4'b0100: cathode = 7'b1001100; // "4" 
                    4'b0101: cathode = 7'b0100100; // "5" 
                    4'b0110: cathode = 7'b0100000; // "6" 
                    4'b0111: cathode = 7'b0001111; // "7" 
                    4'b1000: cathode = 7'b0000000; // "8"     
                    4'b1001: cathode = 7'b0000100; // "9" 
                    4'b1010: cathode = 7'b0001000; // "A" 
                    4'b1011: cathode = 7'b0000000; // "B" 
                    4'b1100: cathode = 7'b0110001; // "C" 
                    4'b1101: cathode = 7'b1000010; // "d" 
                    4'b1110: cathode = 7'b0110000; // "E" 
                    4'b1111: cathode = 7'b0111000; // "F" 
                    default: cathode = 7'b1111110; // "-"
                endcase
            end
            2'b01: begin
                anode = 4'b1101; 
                // activate LED2 and Deactivate LED1, LED3, LED4
                case(nibble1)
                    4'b0000: cathode = 7'b0000001; // "0"     
                    4'b0001: cathode = 7'b1001111; // "1" 
                    4'b0010: cathode = 7'b0010010; // "2" 
                    4'b0011: cathode = 7'b0000110; // "3" 
                    4'b0100: cathode = 7'b1001100; // "4" 
                    4'b0101: cathode = 7'b0100100; // "5" 
                    4'b0110: cathode = 7'b0100000; // "6" 
                    4'b0111: cathode = 7'b0001111; // "7" 
                    4'b1000: cathode = 7'b0000000; // "8"     
                    4'b1001: cathode = 7'b0000100; // "9" 
                    4'b1010: cathode = 7'b0001000; // "A" 
                    4'b1011: cathode = 7'b0000000; // "B" 
                    4'b1100: cathode = 7'b0110001; // "C" 
                    4'b1101: cathode = 7'b1000010; // "d" 
                    4'b1110: cathode = 7'b0110000; // "E" 
                    4'b1111: cathode = 7'b0111000; // "F" 
                    default: cathode = 7'b1111110; // "-"
                endcase
            end
            2'b10: begin
                anode = 4'b1011; 
                // activate LED3 and Deactivate LED2, LED1, LED4
                cathode = 7'b1111110; // "-"
            end
            2'b11: begin
                anode = 4'b0111; 
                // activate LED4 and Deactivate LED2, LED3, LED1
                cathode = 7'b1111110; // "-"   
            end
        endcase
    end
 end
endmodule