module Decoder2_4 (A1,A0,D3,D2,D1,D0);
input  A1,A0;
output D3,D2,D1,D0;

assign D0=((A1==0)&&(A0==0))?1 : 0;
assign D1=((A1==0)&&(A0==1))?1 : 0;
assign D2=((A1==1)&&(A0==0))?1 : 0;
assign D3=((A1==1)&&(A0==1))?1 : 0;
/*
assign D3 = A1 & A0;
assign D2 = A1 & (~A0);
assign D1 = (~A1) & A0;
assign D0 = (~A1) & (~A0);
*/
/*
//---Another Design Type---
reg D3,D2,D1,D0;
always @(*) begin
    //---DefaultCase---
    D0 = 0;
    D1 = 0;
    D2 = 0;
    D3 = 0;
    case ({A1, A0})
        2'b00: D0 = 1;
        2'b01: D1 = 1;
        2'b10: D2 = 1;
        2'b11: D3 = 1;
    endcase
end*/
endmodule