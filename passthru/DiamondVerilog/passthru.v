/*
** blinky.v from https://github.com/DoctorWkt/ULX3S-Blinky
*/
`ifdef VERILATOR
/* verilator lint_off UNUSED */		// Not all of btn gets used, sigh
module blinky(input i_clk, input [6:0] btn, output [7:0] o_led);
/* verilator lint_on UNUSED */
    wire i_clk;
    wire [6:0] btn;
    wire [7:0] o_led;
`else

module top(input clk_25mhz,
           input [6:0] btn,
		   input [1:0] S_prog_in,
		   output [1:0] S_prog_out,
           output [7:0] led,
           output wifi_gpio0);

    wire i_clk;

    // Tie GPIO0, keep board from rebooting
    assign wifi_gpio0 = 1'b1;
    assign i_clk= clk_25mhz;
    reg [7:0] o_led;
    assign led= o_led;
`endif

    localparam ctr_width = 32;
    reg [ctr_width-1:0] ctr = 0;


  // TX/RX passthru
  assign ftdi_rxd = wifi_txd;
  assign wifi_rxd = ftdi_txd;

  // Programming logic
  // SERIAL  ->  ESP32
  // DTR RTS -> EN IO0
  //  1   1     1   1
  //  0   0     1   1
  //  1   0     0   1
  //  0   1     1   0
  assign S_prog_in[1] = ftdi_ndtr;
  assign S_prog_in[0] = ftdi_nrts;
  
  if (S_prog_in == 2'b11) begin
	  assign S_prog_out = 2'b11;
	  end
   else if (S_prog_in == 2'b10) begin
	  assign S_prog_out = 2'b01;
	  end
   else if (S_prog_in == 2'b01) begin
	  assign S_prog_out = 2'b10;
	  end
   else begin
	  assign S_prog_out = 2'b11;
   end
   
	  
//  assign S_prog_out = "01" when S_prog_in = "10" else
//                "10" when S_prog_in = "01" else
//               "11";
  assign wifi_en = S_prog_out[1];
  assign wifi_gpio0 = (S_prog_out[0] && btn[0]); // holding BTN0 will hold gpio0 LOW, signal for ESP32 to take control
	  
    always @(posedge i_clk) 
		
		
        R_prog_in <= S_prog_in;
        if S_prog_out = "01" and R_prog_in = "11" then
          R_prog_release <= (others => '0');
        else
          if R_prog_release(R_prog_release'high) = '0' then
            R_prog_release <= R_prog_release + 1;
          end if;
        end if;

ctr <= ctr + 1;
          o_led[7] <= 1;
          o_led[6] <= btn[1];
        o_led[5:0] <= ctr[23:18];
    end

endmodule
