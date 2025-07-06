module Design5_SLE_tb ();
 reg   D_tb,CLK_tb,EN_tb,ALn_tb,ADn_tb,SLn_tb,SD_tb,LAT_Tb;
 wire  Q_DUT;

 //DUT and REF INSTANTIATIONS
 Design5_SLE DUT (D_tb,CLK_tb,EN_tb,ALn_tb,ADn_tb,SLn_tb,SD_tb,LAT_Tb,Q_DUT);
 
 //Clock generation
 initial begin
    CLK_tb=0;
    forever begin
        #5; CLK_tb=~CLK_tb;
    end
 end

 //TEST STIMULUS
 initial begin
    $display("\n---START SIMULATION---\n");
    /*---directive---*/
    /* check LAT and EN cases */
    /* Latch enable is Low */
    ALn_tb=1;
    LAT_Tb=0;  /* Disable the Latch enable */
    EN_tb=0;   /* Expect the Q value will not change */
    @(negedge CLK_tb);
    /* chack if EN=1 and SLn=0 */
    EN_tb=1;
    SLn_tb=0;
    SD_tb=1;   /* intial value Of SD */
    @(negedge CLK_tb);
    SD_tb=0;
    @(negedge CLK_tb);
    /* chack if EN=1 and SLn=1 */
    SLn_tb=1;
    D_tb=1;   /* intial value Of D */
    @(negedge CLK_tb);
    D_tb=0;
    @(negedge CLK_tb);
    //--------------------------
    /* Latch enable is High */
    ALn_tb=1;
    LAT_Tb=1;  /* enable the Latch enable */
    EN_tb=0;   /* Expect the Q value will not change */
    @(negedge CLK_tb);
    /* chack if EN=1 and SLn=0 */
    EN_tb=1;
    SLn_tb=0;
    SD_tb=1;   /* intial value Of SD */
    @(negedge CLK_tb);
    SD_tb=0;
    @(negedge CLK_tb);
    /* chack if EN=1 and SLn=1 */
    SLn_tb=1;
    D_tb=1;   /* intial value Of D */
    @(negedge CLK_tb);
    D_tb=0;
    @(negedge CLK_tb);
    /* check if ALn is LOW with possible cases of ADn*/
    ALn_tb=0;
    ADn_tb=1; /* intial value of ADn */
    @(negedge CLK_tb);
    ADn_tb=0;
    @(negedge CLK_tb);

    $display("\n---END SIMULATION---");
    $stop;
 end

endmodule //Design5_SLE_tb