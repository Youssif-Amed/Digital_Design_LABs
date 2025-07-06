module Design5_SLE (D,CLK,EN,ALn,ADn,SLn,SD,LAT,Q);
 input D,CLK,EN,ALn,ADn,SLn,SD,LAT;
 output reg Q;
 reg Q_FF, Q_LAT;

 always @(posedge CLK or negedge ALn or ADn ) begin
    if (~ALn)
        Q_FF<=~ADn;
    else begin
        if(EN) begin
            if(SLn)
                Q_FF<=D;
            else
                Q_FF<=SD;
        end
    end
 end
  always @(*) begin
    if (~ALn)
        Q_LAT<=~ADn;
    else begin
        if(EN) begin
            if(SLn)
                Q_LAT<=D;
            else
                Q_LAT<=SD;
        end
    end
 end

 assign Q = (LAT)? Q_LAT : Q_FF;
 
endmodule
