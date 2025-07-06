module Generate_gray_onehot (A,B);
 parameter USE_GRAY = 1;  //Default value of USE_GRAY
 input  [2:0]A;
 output reg [6:0]B;

 always @(*) begin
    if(USE_GRAY==1)begin
      B[0]  = A[0]^A[1];
      B[1]  = A[1]^A[2];
      B[2]  = A[2];
      B[6:3]= 0;
    end
    else begin
      B[6:0]=0;  //Default equals zero
      case (A)
        0 : B[0]=0;
        1 : B[0]=1;
        2 : B[1]=1;
        3 : B[2]=1;
        4 : B[3]=1;
        5 : B[4]=1;
        6 : B[5]=1;
        7 : B[6]=1;
      endcase 
    end
 end

endmodule //Generate_gray_onehot