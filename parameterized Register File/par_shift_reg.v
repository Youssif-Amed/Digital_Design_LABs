module par_shift_reg #(
    parameter LOAD_AVALUE = 8'b0000_0001, /*  Default load asyn_value   */
    parameter LOAD_SVALUE = 8'b0000_0001, /*  Default load syn_value    */
    parameter SHIFT_DIRECTION = "LEFT", /*Default shift direction*/
    parameter SHIFT_WIDTH = 8     /*  Default data width  */
) (
    sclr,sset,shiftin,load,data,clock,enable,aclr,aset,shiftout,q
);
 input  [SHIFT_WIDTH-1:0]data;
 input  sclr,sset,shiftin,load,clock,enable,aclr,aset;
 output reg [SHIFT_WIDTH-1:0]q;
 output reg shiftout;

 always @(posedge clock or posedge aclr or posedge aset) begin
    if(aclr)
        q<=0;
    else if (aset)
        q<=LOAD_AVALUE;
    else if (enable)begin
        if(sclr)
            q<=0;
        else if (sset)
            q<=LOAD_SVALUE;
        else if(load)
            q<=data;
        else begin
            if(SHIFT_DIRECTION == "LEFT")begin
                q<={q[SHIFT_WIDTH-2:0],shiftin};
                shiftout<=q[SHIFT_WIDTH-1];
            end
            else if (SHIFT_DIRECTION == "RIGHT")begin
                q<={shiftin,q[SHIFT_WIDTH-1:1]};
                shiftout<=q[0];
            end
        end
    end
 end
endmodule