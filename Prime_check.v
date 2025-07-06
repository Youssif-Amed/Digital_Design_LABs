module Prime_check (A, out);
 input [2:0]A; 
 output out;
 /*All possible numbers can be implemented in 3-bit
  000---001---010---011---100---101---110---111
  prime numbers are 010---011---101---111
 */
 assign out= (A[0]&A[2])|((~A[2])&A[1]); 
 /*
 wire z1,z2;
 nand NAND1   (z1,A[0],A[2]);
 nand NAND2   (z2,A[1],(~A[2]));
 nand NANDOUT (out,z1,z2);
 */
 //And we can also do the functionality with Case statement
endmodule 