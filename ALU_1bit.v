module ALU_1bit (
    a,b,Ainvert,Binvert,CarryIn,operation,resrult,CarryOut
);
 input  a,b,Ainvert,Binvert,CarryIn;
 input  [1:0]operation;
 output resrult,CarryOut;
 wire   OUTMUX_a,OUTMUX_b,OROUT,ANDOUT;
 wire   [1:0]OUTADDER;

 assign OUTMUX_a =(Ainvert==0)?a : (~a);
 assign OUTMUX_b =(Binvert==0)?b : (~b);

 and ANDOP (ANDOUT,OUTMUX_a,OUTMUX_b);
 or  OROP  (OROUT,OUTMUX_a,OUTMUX_b);
 assign OUTADDER= OUTMUX_a + OUTMUX_b + CarryIn;
/*OP=00->ADDITION__OP=01->ANDOPERATION__OP=10->OROPERATION*/
 assign resrult=(operation==2'b00)? OUTADDER[0] :
                (operation==2'b01)? ANDOUT :
                (operation==2'b10)? OROUT  : 1'b0 ;
 assign CarryOut = OUTADDER[1];
 
endmodule 