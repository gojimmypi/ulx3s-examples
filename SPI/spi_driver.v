`timescale 1ns / 1ps

`include "spi.v"

module SPI_driver(clk_25mhz, sck, mosi, miso, ssel, led);
  input wire clk_25mhz;
  input wire sck;
  input wire mosi;
  output wire miso;
  input wire ssel;
  output wire[7:0] led;
  
  wire byteReceived;
  wire[7:0] receivedData;
  wire dataNeeded;
  reg[7:0] dataToSend;
  reg[7:0] receivedDataBuffer;
  
  SPI_slave spi_slave(clk_25mhz, sck, mosi, miso, ssel, byteReceived, receivedData, dataNeeded, dataToSend);

  always @(posedge clk_25mhz) begin
    if(byteReceived)
      receivedDataBuffer <= receivedData;
  end
  
  always @(posedge clk_25mhz) begin
    if(dataNeeded)
      dataToSend <= receivedDataBuffer;
  end
  
  assign led = receivedDataBuffer;
    
endmodule