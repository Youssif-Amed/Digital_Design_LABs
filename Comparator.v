module Comparator (
     A,B,A_greaterthan_B,A_equals_B,A_lessthan_B
);
 input  [3:0]A;
 input  [3:0]B;
 output A_greaterthan_B,A_equals_B,A_lessthan_B;
 assign A_greaterthan_B =(A>B)?1 :0;
 assign A_equals_B =(A==B)?1 :0;
 assign A_lessthan_B =(A<B)?1 :0;
/*
  reg A_greaterthan_B,A_equals_B,A_lessthan_B;
  always@(*)begin
      //---intialCase---
    A_greaterthan_B = 0;
    A_equals_B      = 0;
    A_lessthan_B    = 0;
    if(A>B) 
        A_greaterthan_B =1;
    else if(A==B) 
        A_equals_B =1;
    else 
        A_lessthan_B =1; 
  end */

endmodule 