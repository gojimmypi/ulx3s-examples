
This is a simple SPI slave device for FPGAs. The project file is for a Lattice iCEblink40 development board.
The STM32 test driver is for an STM32F103 ARM microcontroller.


Add fpga-spi.ys, ulx3s_v20.lpf and Makefile

include "spi.v" in spi_driver.v

https://courses.cs.washington.edu/courses/cse466/11au/calendar/07-comms-posted2.pdf

Forthe ULX3S
```
LOCATE COMP "sck" SITE "B9";  # J1_11+ GP3
LOCATE COMP "mosi" SITE "C10"; # J1_11- GN3
LOCATE COMP "miso" SITE "A7";  # J1_13+ GP4
LOCATE COMP "ssel" SITE "A8";  # J1_13- GN4
```