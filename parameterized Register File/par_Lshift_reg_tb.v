module par_shift_reg_tb ();
    parameter LOAD_AVALUE_tb = 8'b0000_0001;    
    parameter LOAD_SVALUE_tb = 8'b0000_0001;
    parameter SHIFT_DIRECTION_tb = "LEFT";
    parameter SHIFT_WIDTH_tb = 8 ;

    //inputs
    reg  [SHIFT_WIDTH_tb-1:0]data;
    reg  sclr,sset,shiftin,load,clock,enable,aclr,aset;
    //output
    wire [SHIFT_WIDTH_tb-1:0]q;
    wire shiftout;

    //DUT INSTANTIATION WITHOUT CHANGE OF PARAMETERS VALUES
    par_shift_reg   DUT (sclr,sset,shiftin,load,data,clock,enable,aclr,aset,shiftout,q);

    //clock generation
    initial begin
     clock=0;
     forever begin
         #5; clock=~clock;
     end
    end

    //Test Stimulus
    initial begin
      shiftin=1;
      /* check the Asynchronous clear */
      /* make the q equals zeroes */
      aclr=1;  
      @(negedge clock);
      /* check the Asynchronous set */
      /* make the q equals LOAD_AVALUE_tb = 1 */
      aclr=0;
      aset=1;
      @(negedge clock);
      /* check the enable of clock */
      aset=0;
      /* enable is LOW so the q keep the last value=1 */
      sset=0;
      enable =0;
      @(negedge clock);
      enable =1;    /* enable is HIGH */
      /* check the synchronous clear */
      /* make the q equals zeroes */
      sclr=1;  
      @(negedge clock);
      /* check the synchronous set */
      /* make the q equals LOAD_SVALUE_tb = 1 */
      sclr=0;
      sset=1;
      @(negedge clock);
      /* load is HIGH, we load q with data */
      sset=0;
      load=1;
      data=8'b0101_1101;
      @(negedge clock);
      /* wait 4 clock cycle to check shift functionality */
      load=0;
      repeat(5) @(negedge clock);
      $stop;
    end
endmodule