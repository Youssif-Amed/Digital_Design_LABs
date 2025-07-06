module Even_parity_generator (A,out_with_parity);
 input  [7:0]A;
 output [8:0]out_with_parity;
 wire   even_Parity_bit;
 
 assign even_Parity_bit = ~^(A);
 assign out_with_parity = {A,even_Parity_bit};

endmodule //Design_4