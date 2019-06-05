
#ifndef PLATFORM_CONFIG_H
#define	PLATFORM_CONFIG_H

#ifdef	__cplusplus
extern "C" {
#endif

#define DEBUG_LED_RCC          RCC_APB2Periph_GPIOA | RCC_APB2Periph_AFIO
#define DEBUG_LED_PORT         GPIOA
#define DEBUG_LED_PIN          GPIO_Pin_0

#define DEBUG_USART            USART1
#define DEBUG_USART_BAUD       57600
#define DEBUG_USART_IRQ        USART1_IRQn
#define DEBUG_USART_RCC        RCC_APB2Periph_GPIOA | RCC_APB2Periph_AFIO | RCC_APB2Periph_USART1
#define DEBUG_USART_TX         GPIOA
#define DEBUG_USART_TX_PIN     GPIO_Pin_9
#define DEBUG_USART_RX         GPIOA
#define DEBUG_USART_RX_PIN     GPIO_Pin_10

#define SPIy                   SPI1
#define SPIy_CLK               RCC_APB2Periph_SPI1
#define SPIy_GPIO              GPIOA
#define SPIy_GPIO_CLK          RCC_APB2Periph_GPIOA  
#define SPIy_PIN_SCK           GPIO_Pin_5
#define SPIy_PIN_MISO          GPIO_Pin_6
#define SPIy_PIN_MOSI          GPIO_Pin_7
#define SPIy_PIN_SS            GPIO_Pin_4

#ifdef	__cplusplus
}
#endif

#endif	/* PLATFORM_CONFIG_H */

