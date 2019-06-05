`timescale 1ns / 1ps

module SPI_slave_tb;
  reg clk;
  reg sck;
  reg mosi;
  wire miso;
  reg ssel;
  wire byteReceived;
  wire[7:0] receivedData;
  reg[7:0] expectedData;
  wire dataNeeded;
  reg[7:0] dataToSend;
  reg[7:0] expectedDataToSend;
  reg[7:0] misoData;
  
  SPI_slave spi_slave(clk, sck, mosi, miso, ssel, byteReceived, receivedData, dataNeeded, dataToSend);
  
  initial
  begin
    sck = 1'b0;
    mosi = 1'b0;
    ssel = 1'b1;
    misoData = 8'h00;
  
    #10 ssel = 1'b0;

    expectedData = 8'b11111111;
    expectedDataToSend = 8'hff;
    #10 mosi = 1'b1; #10 sck = 1'b0; #10 sck = 1'b1; #10 misoData <= { misoData[6:0], miso }; // bit 0
    #10 mosi = 1'b1; #10 sck = 1'b0; #10 sck = 1'b1; #10 misoData <= { misoData[6:0], miso }; // bit 1
    #10 mosi = 1'b1; #10 sck = 1'b0; #10 sck = 1'b1; #10 misoData <= { misoData[6:0], miso }; // bit 2
    #10 mosi = 1'b1; #10 sck = 1'b0; #10 sck = 1'b1; #10 misoData <= { misoData[6:0], miso }; // bit 3
    #10 mosi = 1'b1; #10 sck = 1'b0; #10 sck = 1'b1; #10 misoData <= { misoData[6:0], miso }; // bit 4
    #10 mosi = 1'b1; #10 sck = 1'b0; #10 sck = 1'b1; #10 misoData <= { misoData[6:0], miso }; // bit 5
    #10 mosi = 1'b1; #10 sck = 1'b0; #10 sck = 1'b1; #10 misoData <= { misoData[6:0], miso }; // bit 6
    #10 mosi = 1'b1; #10 sck = 1'b0; #10 sck = 1'b1; #10 misoData <= { misoData[6:0], miso }; // bit 7
    #10
    $display("assertEquals(misoData,0x%h,0x%h)", expectedDataToSend, misoData);

    expectedData = 8'b00000000;
    expectedDataToSend = 8'h00;
    #10 mosi = 1'b0; #10 sck = 1'b0; #10 sck = 1'b1; #10 misoData <= { misoData[6:0], miso }; // bit 0
    #10 mosi = 1'b0; #10 sck = 1'b0; #10 sck = 1'b1; #10 misoData <= { misoData[6:0], miso }; // bit 1
    #10 mosi = 1'b0; #10 sck = 1'b0; #10 sck = 1'b1; #10 misoData <= { misoData[6:0], miso }; // bit 2
    #10 mosi = 1'b0; #10 sck = 1'b0; #10 sck = 1'b1; #10 misoData <= { misoData[6:0], miso }; // bit 3
    #10 mosi = 1'b0; #10 sck = 1'b0; #10 sck = 1'b1; #10 misoData <= { misoData[6:0], miso }; // bit 4
    #10 mosi = 1'b0; #10 sck = 1'b0; #10 sck = 1'b1; #10 misoData <= { misoData[6:0], miso }; // bit 5
    #10 mosi = 1'b0; #10 sck = 1'b0; #10 sck = 1'b1; #10 misoData <= { misoData[6:0], miso }; // bit 6
    #10 mosi = 1'b0; #10 sck = 1'b0; #10 sck = 1'b1; #10 misoData <= { misoData[6:0], miso }; // bit 7
    #10
    $display("assertEquals(misoData,0x%h,0x%h)", expectedDataToSend, misoData);
    
    #100 $finish;
  end

  always @(*) begin
    if(byteReceived)
      $display("assertEquals(receivedData,%b,%b)", receivedData, expectedData);
  end

  always @(*) begin
    if(dataNeeded)
      dataToSend = expectedDataToSend;
  end
  
  always
  begin
    clk = 1'b0;
    forever
      #1 clk = ~clk; 
  end
endmodule
