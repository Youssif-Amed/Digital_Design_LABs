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
    output reg [5:0]out   /* output of the ALSU */
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
            leds<=0;
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
        end
    end

    reg invalid_case; /*HGH if the invalid case occurs*/
    /* always block for leds toggle during invalid cases */
    always @(*) begin : INVALID_CASES_CHECKING
        if((opcode_r==3'b110)||(opcode_r==3'b111))
            invalid_case=1;
        else if(((red_op_A_r)||(red_op_B_r))&&((opcode_r!=3'b000)&&(opcode_r!=3'b001)))
            invalid_case=1;
        else begin
            invalid_case=0;
        end
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
    
    /* always block for ALSU functionality */
    always @(posedge clk) begin : ALSU_FUNCTIONALITY
        if(bypass_A_r && bypass_B_r)
            out_r <= First_priority;
        else if (bypass_A_r)
            out_r <= A_r;
        else if (bypass_B_r)
            out_r <= B_r;
        else if(invalid_case)
            out_r <=0;
        else begin
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
                if(FULL_ADDER == "ON")  out_r <= A_r+B_r+cin_r;
                else if(FULL_ADDER == "OFF") out_r <= A_r+B_r;        
            end
            3'b011 : begin
                /* multiplication */
                out_r <= A_r*B_r;
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
            3'b110 : 
                /* invalid case */
                out_r <= 0;
            3'b111 : 
                /* invalid case */
                out_r <= 0;
        endcase
        end
        out <= out_r;
    end
endmodule