
#include <stm32f10x_gpio.h>
#include <stm32f10x_rcc.h>
#include <stm32f10x_spi.h>
#include "debug.h"
#include "time.h"
#include "delay.h"
#include "platform_config.h"

void setup();
void loop();
void spi_setup();
void spi_ss_active();
void spi_ss_inactive();

uint8_t i;

int main(void) {
  setup();
  while (1) {
    loop();
  }
  return 0;
}

void setup() {
  debug_setup();
  time_setup();
  spi_setup();

  i = 0;

  debug_write_line("?END setup");
}

void loop() {
  uint8_t data;
  
  debug_write("?loop ");
  debug_write_i32(i, 16);

  debug_led_set(1);
  delay_ms(500);
  debug_led_set(0);
  delay_ms(500);

  spi_ss_active();
  SPI_I2S_SendData(SPIy, i);
  //while (SPI_I2S_GetFlagStatus(SPIy, SPI_I2S_FLAG_TXE) == RESET);
  while (SPI_I2S_GetFlagStatus(SPIy, SPI_I2S_FLAG_RXNE) == RESET);
  data = SPI_I2S_ReceiveData(SPIy);
  debug_write(" ");
  debug_write_i32(data, 16);
  spi_ss_inactive();

  i++;
  debug_write_line("");
}

void assert_failed(uint8_t* file, uint32_t line) {
  debug_write("-assert_failed: file ");
  debug_write((const char*) file);
  debug_write(" on line ");
  debug_write_u32(line, 10);
  debug_write_line("");

  /* Infinite loop */
  while (1) {
  }
}

void spi_setup() {
  SPI_InitTypeDef spiInit;
  GPIO_InitTypeDef gpioInit;

  RCC_APB2PeriphClockCmd(SPIy_GPIO_CLK | SPIy_CLK, ENABLE);

  GPIO_StructInit(&gpioInit);
  gpioInit.GPIO_Pin = SPIy_PIN_SCK | SPIy_PIN_MOSI;
  gpioInit.GPIO_Speed = GPIO_Speed_50MHz;
  gpioInit.GPIO_Mode = GPIO_Mode_AF_PP;
  GPIO_Init(SPIy_GPIO, &gpioInit);

  gpioInit.GPIO_Pin = SPIy_PIN_SS;
  gpioInit.GPIO_Mode = GPIO_Mode_Out_PP;
  GPIO_Init(SPIy_GPIO, &gpioInit);

  gpioInit.GPIO_Pin = SPIy_PIN_MISO;
  gpioInit.GPIO_Mode = GPIO_Mode_IN_FLOATING;
  GPIO_Init(SPIy_GPIO, &gpioInit);

  SPI_StructInit(&spiInit);
  spiInit.SPI_Direction = SPI_Direction_2Lines_FullDuplex;
  spiInit.SPI_Mode = SPI_Mode_Master;
  spiInit.SPI_DataSize = SPI_DataSize_8b;
  spiInit.SPI_CPOL = SPI_CPOL_Low;
  spiInit.SPI_CPHA = SPI_CPHA_1Edge;
  spiInit.SPI_NSS = SPI_NSS_Soft;
  spiInit.SPI_BaudRatePrescaler = SPI_BaudRatePrescaler_256;
  spiInit.SPI_FirstBit = SPI_FirstBit_MSB;
  SPI_Init(SPIy, &spiInit);

  spi_ss_inactive();

  SPI_Cmd(SPIy, ENABLE);
}

void spi_ss_active() {
  GPIO_ResetBits(SPIy_GPIO, SPIy_PIN_SS);
}

void spi_ss_inactive() {
  GPIO_SetBits(SPIy_GPIO, SPIy_PIN_SS);
}
