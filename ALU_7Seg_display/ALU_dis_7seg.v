module ALU_dis_7seg (A,B,OP,enable,a,b,c,d,e,f,g);
 parameter N = 4 ;
 input  [N-1:0]A,B;
 input  [1:0]OP;
 input  enable;
 output reg a,b,c,d,e,f,g;
 wire [N-1:0]result;

 //ALU_INSTANTIATION
 Nbit_ALU #(.N(N)) ALU_4BIT (.A(A),.B(B),.OP(OP),.result(result));
 
 //RESULT TO DISPLAY ON 7-SEGMENT
 always @(*) begin
    a=0;    b=0;    c=0;    d=0;    e=0;    f=0;    g=0;
    if(enable==1)
    case ({result})
        0 : begin
            a=1;    b=1;    c=1;    d=1;    e=1;    f=1;     
        end
        1 : begin 
            b=1;    c=1; 
        end
        2 : begin 
            a=1;    b=1;    d=1;    e=1;
        end
        3 : begin
            a=1;    b=1;    c=1;    d=1;    g=1;  
        end
        'h4 : begin
            b=1;    c=1;    f=1;    g=1;
        end
        'h5 : begin
            a=1;    c=1;    d=1;    f=1;    g=1;
        end
        'h6 : begin
            a=1;    c=1;    d=1;    e=1;    f=1;    g=1; 
        end
        'h7 : begin
            a=1;    b=1;    c=1;
        end
        'h8 : begin
            a=1;    b=1;    c=1;    d=1;    e=1;    f=1;    g=1;
        end
        'h9 : begin
            a=1;    b=1;    c=1;    d=1;    f=1;    g=1;
        end
        'hA : begin
            a=1;    b=1;    c=1;    e=1;    f=1;    g=1;
        end
        'hB : begin
            c=1;    d=1;    e=1;    f=1;    g=1;
        end
        'hC : begin
            a=1;    d=1;    e=1;    f=1;  
        end
        'hD : begin
            b=1;    c=1;    e=1;    g=1;
        end
        'hE : begin
            a=1;    d=1;    e=1;    f=1;    g=1;
        end
        'hF : begin
            a=1;    e=1;    f=1;    g=1;
        end      
    endcase
    else begin
    a=0;    b=0;    c=0;    d=0;    e=0;    f=0;    g=0;   
    end
 end
endmodule