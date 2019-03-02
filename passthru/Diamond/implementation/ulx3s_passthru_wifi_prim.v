// Verilog netlist produced by program LSE :  version Diamond (64-bit) 3.10.3.144
// Netlist written on Fri Mar 01 12:58:00 2019
//
// Verilog Description of module ulx3s_passthru_wifi
//

module ulx3s_passthru_wifi (clk_25mhz, ftdi_rxd, ftdi_txd, ftdi_ndtr, 
            ftdi_ndsr, ftdi_nrts, ftdi_txden, wifi_rxd, wifi_txd, 
            wifi_en, wifi_gpio0, wifi_gpio2, wifi_gpio16, wifi_gpio17, 
            led, btn, sw, oled_csn, oled_clk, oled_mosi, oled_dc, 
            oled_resn, gp, gn, shutdown, audio_l, audio_r, audio_v, 
            flash_holdn, flash_wpn, sd_d, sd_cmd, sd_clk, sd_cdn, 
            sd_wp);   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(15[8:27])
    input clk_25mhz;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(22[3:12])
    output ftdi_rxd;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(25[3:11])
    input ftdi_txd;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(26[3:11])
    input ftdi_ndtr /* synthesis .original_dir=IN_OUT */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(28[3:12])
    input ftdi_ndsr /* synthesis .original_dir=IN_OUT */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(29[3:12])
    input ftdi_nrts /* synthesis .original_dir=IN_OUT */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(30[3:12])
    input ftdi_txden /* synthesis .original_dir=IN_OUT */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(31[3:13])
    output wifi_rxd;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(34[3:11])
    input wifi_txd;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(35[3:11])
    output wifi_en /* synthesis .original_dir=IN_OUT */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(37[3:10])
    output wifi_gpio0 /* synthesis .original_dir=IN_OUT */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(37[12:22])
    input wifi_gpio2 /* synthesis .original_dir=IN_OUT */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(37[24:34])
    input wifi_gpio16 /* synthesis .original_dir=IN_OUT */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(37[36:47])
    input wifi_gpio17 /* synthesis .original_dir=IN_OUT */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(37[49:60])
    output [7:0]led;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(40[3:6])
    input [6:0]btn;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(41[3:6])
    input [1:4]sw;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(42[3:5])
    output oled_csn;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(43[3:11])
    output oled_clk;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(43[13:21])
    output oled_mosi;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(43[23:32])
    output oled_dc;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(43[34:41])
    output oled_resn;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(43[43:52])
    input [27:0]gp;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(46[3:5])
    input [27:0]gn;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(46[7:9])
    output shutdown;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(49[3:11])
    input [3:0]audio_l;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(52[3:10])
    input [3:0]audio_r;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(52[12:19])
    input [3:0]audio_v;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(52[21:28])
    output flash_holdn;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(63[3:14])
    output flash_wpn;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(63[16:25])
    input [3:0]sd_d;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(66[3:7])
    input sd_cmd;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(67[3:9])
    input sd_clk;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(68[3:9])
    input sd_cdn;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(69[3:9])
    input sd_wp;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(69[11:16])
    
    wire clk_25mhz_c /* synthesis is_clock=1, SET_AS_NETWORK=clk_25mhz_c */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(22[3:12])
    wire oled_clk_c_c /* synthesis is_clock=1, SET_AS_NETWORK=oled_clk_c_c */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(43[13:21])
    
    wire GND_net, VCC_net, ftdi_rxd_c_c, wifi_rxd_c_c, ftdi_ndtr_c, 
        ftdi_nrts_c, led_c, wifi_gpio0_c, oled_dc_c_c, oled_csn_c_c, 
        n243, n278, n277, n242, btn_c_6, btn_c_5, btn_c_4, btn_c_3, 
        btn_c_2, btn_c_1, btn_c_0, oled_mosi_c_c, oled_resn_c_c, n450, 
        n226, n227;
    wire [1:0]R_prog_in;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(74[21:30])
    wire [7:0]R_spi_miso;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(75[10:20])
    wire [17:0]R_prog_release;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(78[10:24])
    
    wire n407, wifi_gpio17_N_23, sd_d_0__N_20, n276, R_prog_release_17__N_74, 
        n459, clk_25mhz_c_enable_18, n406, n275, n282, n281, n280, 
        n415, n405, n259, n456, n274, n414, n413, n412, n411, 
        n410, n447, n409, n408, n444, n239, n238, n235, n234, 
        n453, n231, n230, n404, n247, n40, n403, n43, n441, 
        n46, n250, n49, n251, n52, n55, n402, n58, n61, n312, 
        n64, n401, n67, n70, n73, n76, n79, n82, n85, n279, 
        n88, n91, n246;
    
    VHI i2 (.Z(VCC_net));
    LUT4 i198_4_lut_4_lut_3_lut (.A(oled_csn_c_c), .B(btn_c_2), .C(n450), 
         .Z(n450)) /* synthesis lut_function=(A (B)+!A (C)) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam i198_4_lut_4_lut_3_lut.init = 16'hd8d8;
    CCU2C _add_1_add_4_9 (.A0(R_prog_release[7]), .B0(GND_net), .C0(GND_net), 
          .D0(VCC_net), .A1(R_prog_release[8]), .B1(GND_net), .C1(GND_net), 
          .D1(VCC_net), .CIN(n277), .COUT(n278), .S0(n70), .S1(n67));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam _add_1_add_4_9.INIT0 = 16'haaa0;
    defparam _add_1_add_4_9.INIT1 = 16'haaa0;
    defparam _add_1_add_4_9.INJECT1_0 = "NO";
    defparam _add_1_add_4_9.INJECT1_1 = "NO";
    CCU2C _add_1_add_4_7 (.A0(R_prog_release[5]), .B0(GND_net), .C0(GND_net), 
          .D0(VCC_net), .A1(R_prog_release[6]), .B1(GND_net), .C1(GND_net), 
          .D1(VCC_net), .CIN(n276), .COUT(n277), .S0(n76), .S1(n73));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam _add_1_add_4_7.INIT0 = 16'haaa0;
    defparam _add_1_add_4_7.INIT1 = 16'haaa0;
    defparam _add_1_add_4_7.INJECT1_0 = "NO";
    defparam _add_1_add_4_7.INJECT1_1 = "NO";
    FD1S3AX R_prog_in_i0 (.D(ftdi_nrts_c), .CK(clk_25mhz_c), .Q(R_prog_in[0]));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(134[7] 143[14])
    defparam R_prog_in_i0.GSR = "DISABLED";
    CCU2C _add_1_add_4_5 (.A0(R_prog_release[3]), .B0(GND_net), .C0(GND_net), 
          .D0(VCC_net), .A1(R_prog_release[4]), .B1(GND_net), .C1(GND_net), 
          .D1(VCC_net), .CIN(n275), .COUT(n276), .S0(n82), .S1(n79));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam _add_1_add_4_5.INIT0 = 16'haaa0;
    defparam _add_1_add_4_5.INIT1 = 16'haaa0;
    defparam _add_1_add_4_5.INJECT1_0 = "NO";
    defparam _add_1_add_4_5.INJECT1_1 = "NO";
    LUT4 wifi_gpio17_I_0_70_2_lut_rep_19 (.A(oled_csn_c_c), .B(btn_c_6), 
         .Z(n413)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam wifi_gpio17_I_0_70_2_lut_rep_19.init = 16'h2222;
    IB oled_dc_c_pad (.I(wifi_gpio16), .O(oled_dc_c_c));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(37[36:47])
    FD1S3DX R_spi_miso_i0_104_105_reset (.D(R_spi_miso[7]), .CK(oled_clk_c_c), 
            .CD(n404), .Q(n227));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam R_spi_miso_i0_104_105_reset.GSR = "DISABLED";
    CCU2C _add_1_add_4_3 (.A0(R_prog_release[1]), .B0(GND_net), .C0(GND_net), 
          .D0(VCC_net), .A1(R_prog_release[2]), .B1(GND_net), .C1(GND_net), 
          .D1(VCC_net), .CIN(n274), .COUT(n275), .S0(n88), .S1(n85));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam _add_1_add_4_3.INIT0 = 16'haaa0;
    defparam _add_1_add_4_3.INIT1 = 16'haaa0;
    defparam _add_1_add_4_3.INJECT1_0 = "NO";
    defparam _add_1_add_4_3.INJECT1_1 = "NO";
    FD1S3BX R_spi_miso_i0_104_105_set (.D(R_spi_miso[7]), .CK(oled_clk_c_c), 
            .PD(n401), .Q(n226));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam R_spi_miso_i0_104_105_set.GSR = "DISABLED";
    OB wifi_en_pad (.I(led_c), .O(wifi_en));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(37[3:10])
    IB ftdi_ndtr_pad (.I(ftdi_ndtr), .O(ftdi_ndtr_c));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(28[3:12])
    IB ftdi_rxd_c_pad (.I(wifi_txd), .O(ftdi_rxd_c_c));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(35[3:11])
    IB ftdi_nrts_pad (.I(ftdi_nrts), .O(ftdi_nrts_c));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(30[3:12])
    OB wifi_rxd_pad (.I(wifi_rxd_c_c), .O(wifi_rxd));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(34[3:11])
    CCU2C _add_1_add_4_1 (.A0(GND_net), .B0(GND_net), .C0(GND_net), .D0(GND_net), 
          .A1(R_prog_release[0]), .B1(GND_net), .C1(GND_net), .D1(VCC_net), 
          .COUT(n274), .S1(n91));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam _add_1_add_4_1.INIT0 = 16'h0000;
    defparam _add_1_add_4_1.INIT1 = 16'h555f;
    defparam _add_1_add_4_1.INJECT1_0 = "NO";
    defparam _add_1_add_4_1.INJECT1_1 = "NO";
    LUT4 i188_4_lut_4_lut_3_lut (.A(oled_csn_c_c), .B(btn_c_1), .C(n447), 
         .Z(n447)) /* synthesis lut_function=(A (B)+!A (C)) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam i188_4_lut_4_lut_3_lut.init = 16'hd8d8;
    IB clk_25mhz_pad (.I(clk_25mhz), .O(clk_25mhz_c));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(22[3:12])
    LUT4 i126_3_lut (.A(n247), .B(n246), .C(n459), .Z(R_spi_miso[5])) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam i126_3_lut.init = 16'hcaca;
    OB ftdi_rxd_pad (.I(ftdi_rxd_c_c), .O(ftdi_rxd));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(25[3:11])
    IB wifi_rxd_c_pad (.I(ftdi_txd), .O(wifi_rxd_c_c));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(26[3:11])
    OB led_pad_7 (.I(n405), .O(led[7]));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(40[3:6])
    OB wifi_gpio0_pad (.I(wifi_gpio0_c), .O(wifi_gpio0));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(37[12:22])
    CCU2C _add_1_add_4_11 (.A0(R_prog_release[9]), .B0(GND_net), .C0(GND_net), 
          .D0(VCC_net), .A1(R_prog_release[10]), .B1(GND_net), .C1(GND_net), 
          .D1(VCC_net), .CIN(n278), .COUT(n279), .S0(n64), .S1(n61));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam _add_1_add_4_11.INIT0 = 16'haaa0;
    defparam _add_1_add_4_11.INIT1 = 16'haaa0;
    defparam _add_1_add_4_11.INJECT1_0 = "NO";
    defparam _add_1_add_4_11.INJECT1_1 = "NO";
    OBZ sd_d_pad_0 (.I(sd_d_0__N_20), .T(n259), .O(sd_d[0]));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(66[3:7])
    OB flash_wpn_pad (.I(GND_net), .O(flash_wpn));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(63[16:25])
    OB flash_holdn_pad (.I(GND_net), .O(flash_holdn));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(63[3:14])
    OB shutdown_pad (.I(GND_net), .O(shutdown));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(49[3:11])
    OB oled_resn_pad (.I(oled_resn_c_c), .O(oled_resn));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(43[43:52])
    OB oled_dc_pad (.I(oled_dc_c_c), .O(oled_dc));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(43[34:41])
    OB oled_mosi_pad (.I(oled_mosi_c_c), .O(oled_mosi));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(43[23:32])
    OB oled_clk_pad (.I(oled_clk_c_c), .O(oled_clk));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(43[13:21])
    OB oled_csn_pad (.I(oled_csn_c_c), .O(oled_csn));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(43[3:11])
    OB led_pad_0 (.I(GND_net), .O(led[0]));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(40[3:6])
    OB led_pad_1 (.I(GND_net), .O(led[1]));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(40[3:6])
    OB led_pad_2 (.I(GND_net), .O(led[2]));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(40[3:6])
    OB led_pad_3 (.I(GND_net), .O(led[3]));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(40[3:6])
    OB led_pad_4 (.I(GND_net), .O(led[4]));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(40[3:6])
    OB led_pad_5 (.I(GND_net), .O(led[5]));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(40[3:6])
    OB led_pad_6 (.I(led_c), .O(led[6]));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(40[3:6])
    IB oled_csn_c_pad (.I(wifi_gpio17), .O(oled_csn_c_c));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(37[49:60])
    IB btn_pad_6 (.I(btn[6]), .O(btn_c_6));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(41[3:6])
    IB btn_pad_5 (.I(btn[5]), .O(btn_c_5));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(41[3:6])
    IB btn_pad_4 (.I(btn[4]), .O(btn_c_4));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(41[3:6])
    IB btn_pad_3 (.I(btn[3]), .O(btn_c_3));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(41[3:6])
    IB btn_pad_2 (.I(btn[2]), .O(btn_c_2));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(41[3:6])
    IB btn_pad_1 (.I(btn[1]), .O(btn_c_1));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(41[3:6])
    IB btn_pad_0 (.I(btn[0]), .O(btn_c_0));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(41[3:6])
    IB oled_resn_c_pad (.I(gp[11]), .O(oled_resn_c_c));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(46[3:5])
    IB oled_mosi_c_pad (.I(sd_cmd), .O(oled_mosi_c_c));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(67[3:9])
    IB oled_clk_c_pad (.I(sd_clk), .O(oled_clk_c_c));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(68[3:9])
    FD1P3IX R_prog_release__i1 (.D(n88), .SP(clk_25mhz_c_enable_18), .CD(R_prog_release_17__N_74), 
            .CK(clk_25mhz_c), .Q(R_prog_release[1])) /* synthesis lse_init_val=1 */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(134[7] 143[14])
    defparam R_prog_release__i1.GSR = "DISABLED";
    FD1P3IX R_prog_release__i2 (.D(n85), .SP(clk_25mhz_c_enable_18), .CD(R_prog_release_17__N_74), 
            .CK(clk_25mhz_c), .Q(R_prog_release[2])) /* synthesis lse_init_val=1 */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(134[7] 143[14])
    defparam R_prog_release__i2.GSR = "DISABLED";
    FD1P3IX R_prog_release__i3 (.D(n82), .SP(clk_25mhz_c_enable_18), .CD(R_prog_release_17__N_74), 
            .CK(clk_25mhz_c), .Q(R_prog_release[3])) /* synthesis lse_init_val=1 */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(134[7] 143[14])
    defparam R_prog_release__i3.GSR = "DISABLED";
    FD1P3IX R_prog_release__i4 (.D(n79), .SP(clk_25mhz_c_enable_18), .CD(R_prog_release_17__N_74), 
            .CK(clk_25mhz_c), .Q(R_prog_release[4])) /* synthesis lse_init_val=1 */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(134[7] 143[14])
    defparam R_prog_release__i4.GSR = "DISABLED";
    FD1P3IX R_prog_release__i5 (.D(n76), .SP(clk_25mhz_c_enable_18), .CD(R_prog_release_17__N_74), 
            .CK(clk_25mhz_c), .Q(R_prog_release[5])) /* synthesis lse_init_val=1 */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(134[7] 143[14])
    defparam R_prog_release__i5.GSR = "DISABLED";
    FD1P3IX R_prog_release__i6 (.D(n73), .SP(clk_25mhz_c_enable_18), .CD(R_prog_release_17__N_74), 
            .CK(clk_25mhz_c), .Q(R_prog_release[6])) /* synthesis lse_init_val=1 */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(134[7] 143[14])
    defparam R_prog_release__i6.GSR = "DISABLED";
    FD1P3IX R_prog_release__i7 (.D(n70), .SP(clk_25mhz_c_enable_18), .CD(R_prog_release_17__N_74), 
            .CK(clk_25mhz_c), .Q(R_prog_release[7])) /* synthesis lse_init_val=1 */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(134[7] 143[14])
    defparam R_prog_release__i7.GSR = "DISABLED";
    FD1P3IX R_prog_release__i8 (.D(n67), .SP(clk_25mhz_c_enable_18), .CD(R_prog_release_17__N_74), 
            .CK(clk_25mhz_c), .Q(R_prog_release[8])) /* synthesis lse_init_val=1 */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(134[7] 143[14])
    defparam R_prog_release__i8.GSR = "DISABLED";
    FD1P3IX R_prog_release__i9 (.D(n64), .SP(clk_25mhz_c_enable_18), .CD(R_prog_release_17__N_74), 
            .CK(clk_25mhz_c), .Q(R_prog_release[9])) /* synthesis lse_init_val=1 */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(134[7] 143[14])
    defparam R_prog_release__i9.GSR = "DISABLED";
    FD1P3IX R_prog_release__i10 (.D(n61), .SP(clk_25mhz_c_enable_18), .CD(R_prog_release_17__N_74), 
            .CK(clk_25mhz_c), .Q(R_prog_release[10])) /* synthesis lse_init_val=1 */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(134[7] 143[14])
    defparam R_prog_release__i10.GSR = "DISABLED";
    FD1P3IX R_prog_release__i11 (.D(n58), .SP(clk_25mhz_c_enable_18), .CD(R_prog_release_17__N_74), 
            .CK(clk_25mhz_c), .Q(R_prog_release[11])) /* synthesis lse_init_val=1 */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(134[7] 143[14])
    defparam R_prog_release__i11.GSR = "DISABLED";
    FD1P3IX R_prog_release__i12 (.D(n55), .SP(clk_25mhz_c_enable_18), .CD(R_prog_release_17__N_74), 
            .CK(clk_25mhz_c), .Q(R_prog_release[12])) /* synthesis lse_init_val=1 */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(134[7] 143[14])
    defparam R_prog_release__i12.GSR = "DISABLED";
    FD1P3IX R_prog_release__i13 (.D(n52), .SP(clk_25mhz_c_enable_18), .CD(R_prog_release_17__N_74), 
            .CK(clk_25mhz_c), .Q(R_prog_release[13])) /* synthesis lse_init_val=1 */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(134[7] 143[14])
    defparam R_prog_release__i13.GSR = "DISABLED";
    FD1P3IX R_prog_release__i14 (.D(n49), .SP(clk_25mhz_c_enable_18), .CD(R_prog_release_17__N_74), 
            .CK(clk_25mhz_c), .Q(R_prog_release[14])) /* synthesis lse_init_val=1 */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(134[7] 143[14])
    defparam R_prog_release__i14.GSR = "DISABLED";
    FD1P3IX R_prog_release__i15 (.D(n46), .SP(clk_25mhz_c_enable_18), .CD(R_prog_release_17__N_74), 
            .CK(clk_25mhz_c), .Q(R_prog_release[15])) /* synthesis lse_init_val=1 */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(134[7] 143[14])
    defparam R_prog_release__i15.GSR = "DISABLED";
    FD1P3IX R_prog_release__i16 (.D(n43), .SP(clk_25mhz_c_enable_18), .CD(R_prog_release_17__N_74), 
            .CK(clk_25mhz_c), .Q(R_prog_release[16])) /* synthesis lse_init_val=1 */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(134[7] 143[14])
    defparam R_prog_release__i16.GSR = "DISABLED";
    FD1P3IX R_prog_release__i17 (.D(n40), .SP(clk_25mhz_c_enable_18), .CD(R_prog_release_17__N_74), 
            .CK(clk_25mhz_c), .Q(R_prog_release[17])) /* synthesis lse_init_val=1 */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(134[7] 143[14])
    defparam R_prog_release__i17.GSR = "DISABLED";
    FD1S3AX R_prog_in_i1 (.D(ftdi_ndtr_c), .CK(clk_25mhz_c), .Q(R_prog_in[1]));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(134[7] 143[14])
    defparam R_prog_in_i1.GSR = "DISABLED";
    LUT4 i122_3_lut (.A(n243), .B(n242), .C(n456), .Z(R_spi_miso[4])) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam i122_3_lut.init = 16'hcaca;
    LUT4 i118_3_lut (.A(n239), .B(n238), .C(n453), .Z(R_spi_miso[3])) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam i118_3_lut.init = 16'hcaca;
    LUT4 i114_3_lut (.A(n235), .B(n234), .C(n450), .Z(R_spi_miso[2])) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam i114_3_lut.init = 16'hcaca;
    LUT4 i110_3_lut (.A(n231), .B(n230), .C(n447), .Z(R_spi_miso[1])) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam i110_3_lut.init = 16'hcaca;
    CCU2C _add_1_add_4_19 (.A0(R_prog_release[17]), .B0(GND_net), .C0(GND_net), 
          .D0(VCC_net), .A1(GND_net), .B1(GND_net), .C1(GND_net), .D1(GND_net), 
          .CIN(n282), .S0(n40));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam _add_1_add_4_19.INIT0 = 16'haaa0;
    defparam _add_1_add_4_19.INIT1 = 16'h0000;
    defparam _add_1_add_4_19.INJECT1_0 = "NO";
    defparam _add_1_add_4_19.INJECT1_1 = "NO";
    CCU2C _add_1_add_4_17 (.A0(R_prog_release[15]), .B0(GND_net), .C0(GND_net), 
          .D0(VCC_net), .A1(R_prog_release[16]), .B1(GND_net), .C1(GND_net), 
          .D1(VCC_net), .CIN(n281), .COUT(n282), .S0(n46), .S1(n43));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam _add_1_add_4_17.INIT0 = 16'haaa0;
    defparam _add_1_add_4_17.INIT1 = 16'haaa0;
    defparam _add_1_add_4_17.INJECT1_0 = "NO";
    defparam _add_1_add_4_17.INJECT1_1 = "NO";
    CCU2C _add_1_add_4_15 (.A0(R_prog_release[13]), .B0(GND_net), .C0(GND_net), 
          .D0(VCC_net), .A1(R_prog_release[14]), .B1(GND_net), .C1(GND_net), 
          .D1(VCC_net), .CIN(n280), .COUT(n281), .S0(n52), .S1(n49));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam _add_1_add_4_15.INIT0 = 16'haaa0;
    defparam _add_1_add_4_15.INIT1 = 16'haaa0;
    defparam _add_1_add_4_15.INJECT1_0 = "NO";
    defparam _add_1_add_4_15.INJECT1_1 = "NO";
    CCU2C _add_1_add_4_13 (.A0(R_prog_release[11]), .B0(GND_net), .C0(GND_net), 
          .D0(VCC_net), .A1(R_prog_release[12]), .B1(GND_net), .C1(GND_net), 
          .D1(VCC_net), .CIN(n279), .COUT(n280), .S0(n58), .S1(n55));   // C:/lscc/diamond/3.10_x64/ispfpga/vhdl_packages/syn_unsi.vhd(118[20:31])
    defparam _add_1_add_4_13.INIT0 = 16'haaa0;
    defparam _add_1_add_4_13.INIT1 = 16'haaa0;
    defparam _add_1_add_4_13.INJECT1_0 = "NO";
    defparam _add_1_add_4_13.INJECT1_1 = "NO";
    LUT4 wifi_gpio17_I_0_62_1_lut (.A(oled_csn_c_c), .Z(wifi_gpio17_N_23)) /* synthesis lut_function=(!(A)) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(103[33:49])
    defparam wifi_gpio17_I_0_62_1_lut.init = 16'h5555;
    LUT4 i130_3_lut (.A(n251), .B(n250), .C(n444), .Z(R_spi_miso[6])) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam i130_3_lut.init = 16'hcaca;
    LUT4 i218_4_lut_4_lut_3_lut (.A(oled_csn_c_c), .B(btn_c_6), .C(n444), 
         .Z(n444)) /* synthesis lut_function=(A (B)+!A (C)) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam i218_4_lut_4_lut_3_lut.init = 16'hd8d8;
    LUT4 i1_4_lut (.A(R_prog_in[0]), .B(R_prog_in[1]), .C(ftdi_ndtr_c), 
         .D(ftdi_nrts_c), .Z(n312)) /* synthesis lut_function=(!((((D)+!C)+!B)+!A)) */ ;
    defparam i1_4_lut.init = 16'h0080;
    FD1S3AX R_spi_miso_i7 (.D(R_spi_miso[6]), .CK(oled_clk_c_c), .Q(R_spi_miso[7]));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam R_spi_miso_i7.GSR = "ENABLED";
    GSR GSR_INST (.GSR(wifi_gpio17_N_23));
    FD1S3BX R_spi_miso_i1_108_109_set (.D(R_spi_miso[0]), .CK(oled_clk_c_c), 
            .PD(n403), .Q(n230));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam R_spi_miso_i1_108_109_set.GSR = "DISABLED";
    FD1S3DX R_spi_miso_i1_108_109_reset (.D(R_spi_miso[0]), .CK(oled_clk_c_c), 
            .CD(n402), .Q(n231));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam R_spi_miso_i1_108_109_reset.GSR = "DISABLED";
    FD1S3BX R_spi_miso_i2_112_113_set (.D(R_spi_miso[1]), .CK(oled_clk_c_c), 
            .PD(n414), .Q(n234));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam R_spi_miso_i2_112_113_set.GSR = "DISABLED";
    FD1S3DX R_spi_miso_i2_112_113_reset (.D(R_spi_miso[1]), .CK(oled_clk_c_c), 
            .CD(n415), .Q(n235));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam R_spi_miso_i2_112_113_reset.GSR = "DISABLED";
    FD1S3BX R_spi_miso_i3_116_117_set (.D(R_spi_miso[2]), .CK(oled_clk_c_c), 
            .PD(n410), .Q(n238));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam R_spi_miso_i3_116_117_set.GSR = "DISABLED";
    FD1S3DX R_spi_miso_i3_116_117_reset (.D(R_spi_miso[2]), .CK(oled_clk_c_c), 
            .CD(n411), .Q(n239));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam R_spi_miso_i3_116_117_reset.GSR = "DISABLED";
    FD1S3BX R_spi_miso_i4_120_121_set (.D(R_spi_miso[3]), .CK(oled_clk_c_c), 
            .PD(n408), .Q(n242));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam R_spi_miso_i4_120_121_set.GSR = "DISABLED";
    FD1S3DX R_spi_miso_i4_120_121_reset (.D(R_spi_miso[3]), .CK(oled_clk_c_c), 
            .CD(n409), .Q(n243));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam R_spi_miso_i4_120_121_reset.GSR = "DISABLED";
    FD1S3BX R_spi_miso_i5_124_125_set (.D(R_spi_miso[4]), .CK(oled_clk_c_c), 
            .PD(n406), .Q(n246));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam R_spi_miso_i5_124_125_set.GSR = "DISABLED";
    FD1S3DX R_spi_miso_i5_124_125_reset (.D(R_spi_miso[4]), .CK(oled_clk_c_c), 
            .CD(n407), .Q(n247));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam R_spi_miso_i5_124_125_reset.GSR = "DISABLED";
    FD1S3BX R_spi_miso_i6_128_129_set (.D(R_spi_miso[5]), .CK(oled_clk_c_c), 
            .PD(n412), .Q(n250));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam R_spi_miso_i6_128_129_set.GSR = "DISABLED";
    FD1S3DX R_spi_miso_i6_128_129_reset (.D(R_spi_miso[5]), .CK(oled_clk_c_c), 
            .CD(n413), .Q(n251));   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam R_spi_miso_i6_128_129_reset.GSR = "DISABLED";
    FD1P3IX R_prog_release__i0 (.D(n91), .SP(clk_25mhz_c_enable_18), .CD(R_prog_release_17__N_74), 
            .CK(clk_25mhz_c), .Q(R_prog_release[0])) /* synthesis lse_init_val=1 */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(134[7] 143[14])
    defparam R_prog_release__i0.GSR = "DISABLED";
    LUT4 i3_4_lut (.A(ftdi_ndtr_c), .B(ftdi_nrts_c), .C(R_prog_in[0]), 
         .D(R_prog_in[1]), .Z(R_prog_release_17__N_74)) /* synthesis lut_function=(!((B+!(C (D)))+!A)) */ ;
    defparam i3_4_lut.init = 16'h2000;
    LUT4 wifi_gpio17_I_0_72_2_lut_rep_15 (.A(oled_csn_c_c), .B(btn_c_4), 
         .Z(n409)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam wifi_gpio17_I_0_72_2_lut_rep_15.init = 16'h2222;
    LUT4 i186_rep_2_2_lut (.A(R_prog_release[17]), .B(n312), .Z(clk_25mhz_c_enable_18)) /* synthesis lut_function=((B)+!A) */ ;
    defparam i186_rep_2_2_lut.init = 16'hdddd;
    LUT4 wifi_gpio17_I_0_67_2_lut_rep_20 (.A(oled_csn_c_c), .B(btn_c_2), 
         .Z(n414)) /* synthesis lut_function=(A (B)) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam wifi_gpio17_I_0_67_2_lut_rep_20.init = 16'h8888;
    LUT4 wifi_gpio17_I_0_69_2_lut_rep_7 (.A(oled_csn_c_c), .B(btn_c_0), 
         .Z(n401)) /* synthesis lut_function=(A (B)) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam wifi_gpio17_I_0_69_2_lut_rep_7.init = 16'h8888;
    LUT4 i106_3_lut (.A(n227), .B(n226), .C(n441), .Z(R_spi_miso[0])) /* synthesis lut_function=(A (B+!(C))+!A (B (C))) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam i106_3_lut.init = 16'hcaca;
    LUT4 i208_4_lut_4_lut_3_lut (.A(oled_csn_c_c), .B(btn_c_4), .C(n456), 
         .Z(n456)) /* synthesis lut_function=(A (B)+!A (C)) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam i208_4_lut_4_lut_3_lut.init = 16'hd8d8;
    LUT4 i137_2_lut (.A(R_prog_release[17]), .B(oled_csn_c_c), .Z(n259)) /* synthesis lut_function=(A (B)) */ ;
    defparam i137_2_lut.init = 16'h8888;
    LUT4 wifi_gpio17_I_0_75_2_lut_rep_8 (.A(oled_csn_c_c), .B(btn_c_1), 
         .Z(n402)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam wifi_gpio17_I_0_75_2_lut_rep_8.init = 16'h2222;
    LUT4 ftdi_ndtr_I_0_76_i3_2_lut (.A(ftdi_nrts_c), .B(ftdi_ndtr_c), .Z(led_c)) /* synthesis lut_function=(A+!(B)) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(94[27:43])
    defparam ftdi_ndtr_I_0_76_i3_2_lut.init = 16'hbbbb;
    LUT4 wifi_gpio17_I_0_2_lut_rep_10 (.A(oled_csn_c_c), .B(btn_c_0), .Z(n404)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam wifi_gpio17_I_0_2_lut_rep_10.init = 16'h2222;
    LUT4 wifi_gpio17_I_0_66_2_lut_rep_16 (.A(oled_csn_c_c), .B(btn_c_3), 
         .Z(n410)) /* synthesis lut_function=(A (B)) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam wifi_gpio17_I_0_66_2_lut_rep_16.init = 16'h8888;
    LUT4 i193_4_lut_4_lut_3_lut (.A(oled_csn_c_c), .B(btn_c_0), .C(n441), 
         .Z(n441)) /* synthesis lut_function=(A (B)+!A (C)) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam i193_4_lut_4_lut_3_lut.init = 16'hd8d8;
    LUT4 R_prog_release_17__I_0_1_lut_rep_11 (.A(R_prog_release[17]), .Z(n405)) /* synthesis lut_function=(!(A)) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(124[13:52])
    defparam R_prog_release_17__I_0_1_lut_rep_11.init = 16'h5555;
    LUT4 R_spi_miso_0__I_0_3_lut_3_lut_4_lut (.A(ftdi_nrts_c), .B(ftdi_ndtr_c), 
         .C(R_spi_miso[0]), .D(R_prog_release[17]), .Z(sd_d_0__N_20)) /* synthesis lut_function=(A (B (C+!(D))+!B (C (D)))+!A (C+!(D))) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(94[17] 96[21])
    defparam R_spi_miso_0__I_0_3_lut_3_lut_4_lut.init = 16'hf0dd;
    LUT4 S_prog_out_0__I_0_2_lut_3_lut (.A(ftdi_nrts_c), .B(ftdi_ndtr_c), 
         .C(btn_c_0), .Z(wifi_gpio0_c)) /* synthesis lut_function=(A (B (C))+!A (C)) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(94[17] 96[21])
    defparam S_prog_out_0__I_0_2_lut_3_lut.init = 16'hd0d0;
    LUT4 wifi_gpio17_I_0_64_2_lut_rep_12 (.A(oled_csn_c_c), .B(btn_c_5), 
         .Z(n406)) /* synthesis lut_function=(A (B)) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam wifi_gpio17_I_0_64_2_lut_rep_12.init = 16'h8888;
    LUT4 wifi_gpio17_I_0_71_2_lut_rep_13 (.A(oled_csn_c_c), .B(btn_c_5), 
         .Z(n407)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam wifi_gpio17_I_0_71_2_lut_rep_13.init = 16'h2222;
    LUT4 wifi_gpio17_I_0_68_2_lut_rep_9 (.A(oled_csn_c_c), .B(btn_c_1), 
         .Z(n403)) /* synthesis lut_function=(A (B)) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam wifi_gpio17_I_0_68_2_lut_rep_9.init = 16'h8888;
    LUT4 i213_4_lut_4_lut_3_lut (.A(oled_csn_c_c), .B(btn_c_5), .C(n459), 
         .Z(n459)) /* synthesis lut_function=(A (B)+!A (C)) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam i213_4_lut_4_lut_3_lut.init = 16'hd8d8;
    LUT4 wifi_gpio17_I_0_65_2_lut_rep_14 (.A(oled_csn_c_c), .B(btn_c_4), 
         .Z(n408)) /* synthesis lut_function=(A (B)) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam wifi_gpio17_I_0_65_2_lut_rep_14.init = 16'h8888;
    LUT4 wifi_gpio17_I_0_74_2_lut_rep_21 (.A(oled_csn_c_c), .B(btn_c_2), 
         .Z(n415)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam wifi_gpio17_I_0_74_2_lut_rep_21.init = 16'h2222;
    VLO i1 (.Z(GND_net));
    LUT4 wifi_gpio17_I_0_73_2_lut_rep_17 (.A(oled_csn_c_c), .B(btn_c_3), 
         .Z(n411)) /* synthesis lut_function=(!((B)+!A)) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam wifi_gpio17_I_0_73_2_lut_rep_17.init = 16'h2222;
    PUR PUR_INST (.PUR(VCC_net));
    defparam PUR_INST.RST_PULSE = 1;
    LUT4 i203_4_lut_4_lut_3_lut (.A(oled_csn_c_c), .B(btn_c_3), .C(n453), 
         .Z(n453)) /* synthesis lut_function=(A (B)+!A (C)) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam i203_4_lut_4_lut_3_lut.init = 16'hd8d8;
    LUT4 wifi_gpio17_I_0_63_2_lut_rep_18 (.A(oled_csn_c_c), .B(btn_c_6), 
         .Z(n412)) /* synthesis lut_function=(A (B)) */ ;   // c:/workspace/ulx3s/examples/passthru/diamond/passthru.vhd(151[7] 153[14])
    defparam wifi_gpio17_I_0_63_2_lut_rep_18.init = 16'h8888;
    
endmodule
//
// Verilog Description of module PUR
// module not written out since it is a black-box. 
//

