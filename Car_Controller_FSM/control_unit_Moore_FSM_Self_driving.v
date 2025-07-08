module control_unit_Self_driving #(
    parameter  MIN_DISTANCE = 7'd40 /* Minimum distance between two vehicles, default = 40 meters - with speed limit= 80 km/hr*/
)(
    input  [7:0]speed_limit,      /* allowable speed limit of the highway */
    input  [7:0]car_speed,        /* current car speed */
    input  [6:0]leading_distance, /* Distance between the car and the vehicle/object in the front of it */
    input  clk,                   /* clock input */
    input  rst,                   /* Active high Asynchronous reset input */
    output reg unlock_doors,          /* signal that unlock the car doors when HIGH */
    output reg accelerate_car         /* signal that control the flow of the fuel to the engine to accelerate when HIGH */
);
parameter STOP = 2'b00;
parameter ACCELERATE = 2'b01;
parameter DECELERATE = 2'b10;

reg [1:0]CS,NS;     /* CS -> current state  NS -> next state */

// state memory
always @(posedge clk or posedge rst) begin
    if(rst)
        CS <= STOP;
    else
        CS <= NS;
end

//next state logic
always @(CS,speed_limit,car_speed,leading_distance) begin
    case(CS)
        STOP:begin
            if(leading_distance>=MIN_DISTANCE)
                NS=ACCELERATE;
            else    
                NS=STOP;
        end
        ACCELERATE:begin
            if((leading_distance<MIN_DISTANCE)||(car_speed>speed_limit))
                NS=DECELERATE;
            else 
                NS=ACCELERATE;
        end
        DECELERATE:begin
            if(car_speed==0)
                NS=STOP;
            else if((leading_distance >= MIN_DISTANCE)&&(car_speed<speed_limit))
                NS=ACCELERATE;
            else
                NS=DECELERATE;
        end
    endcase
end

// output logic
always @(CS) begin
    case(CS)
        STOP:begin
            unlock_doors=1;
            accelerate_car=0;
        end
        ACCELERATE:begin
            unlock_doors=0;
            accelerate_car=1;
        end
        DECELERATE:begin
            unlock_doors=0;
            accelerate_car=0;
        end
    endcase
end

endmodule //control_unit_Moore_FSM_Self_driving