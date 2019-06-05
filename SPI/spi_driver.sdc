#create_clock -period 10.000 -name clk1 [ get_nets CLK_3P3_MHZ ]
define_clock {CLK_3_33_MHZ} -name {CLK_3_33_MHZ} -freq 3.33 -clockgroup default_clkgroup_0
