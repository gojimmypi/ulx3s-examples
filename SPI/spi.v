`timescale 1ns / 1ps

module SPI_slave(clk, sck, mosi, miso, ssel, byteReceived, receivedData, dataNeeded, dataToSend);
  input wire clk;
  input wire sck;
  input wire mosi;
  output wire miso;
  input wire ssel;
  output reg byteReceived = 1'b0;
  output reg[7:0] receivedData = 8'b00000000;
  output wire dataNeeded;
  input wire[7:0] dataToSend;

  reg[1:0] sckr;
  reg[1:0] mosir;
  reg[2:0] bitcnt; // SPI is 8-bits, so we need a 3 bits counter to count the bits as they come in
  reg[7:0] dataToSendBuffer;

  wire ssel_active = ~ssel;

  always @(posedge clk) begin
    if(~ssel_active)
      sckr <= 2'b00;
    else
      sckr <= { sckr[0], sck };
  end
  wire sck_risingEdge = (sckr == 2'b01);
  wire sck_fallingEdge = (sckr == 2'b10);
        
  always @(posedge clk) begin
    if(~ssel_active)
      mosir <= 2'b00;
    else
      mosir <= { mosir[0], mosi };
  end
  wire mosi_data = mosir[1];
  
  always @(posedge clk) begin
    if(~ssel_active) begin
      bitcnt <= 3'b000;
      receivedData <= 8'h00;
    end
    else if(sck_risingEdge) begin
      bitcnt <= bitcnt + 3'b001;
      receivedData <= { receivedData[6:0], mosi_data };
    end
  end
  
  always @(posedge clk)
    byteReceived <= ssel_active && sck_risingEdge && (bitcnt == 3'b111);

  always @(posedge clk) begin
    if(~ssel_active)
      dataToSendBuffer <= 8'h00;
    else if(bitcnt == 3'b000)
      dataToSendBuffer <= dataToSend;
    else if(sck_fallingEdge)
      dataToSendBuffer <= { dataToSendBuffer[6:0], 1'b0};
  end
    
  assign dataNeeded = ssel_active && (bitcnt == 3'b000);
  assign miso = dataToSendBuffer[7];
endmodule
