# Using VisualMicro to program the ULX3S SSD1331 Display from ESP32

## Quick Start

First, ensure the [FPGA passthru](../passthru/README.md) is enabled. 
Next, install [Visual Micro](../VisualMicro/README.md), 
the [Adafruit GFX](https://github.com/adafruit/Adafruit-GFX-Library) 
and [SSD1331](https://github.com/adafruit/Adafruit-SSD1331-OLED-Driver-Library-for-Arduino) libraries, 
then open the `VisualMicro-SSD1331-Display.sln` solution file in Visual Studio.
Select the COM port for your ULX3S and press F5.

```
cd %USERPROFILE%\Documents\Arduino\libraries\

# Adafruit_GFX
git clone https://github.com/adafruit/Adafruit-GFX-Library.git

# Adafruit_SSD1331
git clone https://github.com/adafruit/Adafruit-SSD1331-OLED-Driver-Library-for-Arduino.git

```

The pins used to control the ULX3S SSD-1331 display from the ESP32:

```
#define oled_csn  17 // aka cs - chip select
#define oled_dc   16 // aka ds aka a0 -  SPI data or command selector pin
#define oled_resn 25 // aka rst - reset
#define oled_mosi 15 // aka mosi - data
#define oled_clk  14 // aka sclk - clock
#define oled_miso -1 // 12 not used
```

## SSD1331 Display

The ULX3S board has a connector near the center of the board for an optional display:

![ulx3st-display-connector.jpg](../images/ulx3st-display-connector.jpg)

From the [schematic](../doc/schematics.pdf), these are the connector names defined for the display:

![SSD1331_connector.PNG](../images/SSD1331_connector.PNG)

If your ULX3S does not have a display [buy one from Amazon](https://www.amazon.com/dp/B0711RKXB5/). 
It is always good to support Adafruit, particularly given the amount of work put into their open source libraries, including ones used in this project.
Adafruit has a [OLED SSD-1331](https://www.adafruit.com/product/684) - but note that board appears to have a different size/pinout and includes a MicroSD card. 

See also the [pdf specification for the SSD-1331 Display](../doc/SSD1331_1.2.pdf) in the [doc](../doc/) folder.

## ULX3S ESP-32

The ULX3S on-boarad ESP32 is this [ESP-WROOM-32 from Mouser Electronics](https://hr.mouser.com/ProductDetail/Espressif-Systems/ESP-WROOM-32-16MB?qs=sGAEpiMZZMsRr7brxAGoXSSUPDSAjAiV1M6iRPUJ5tDjstOHDp9d7Q%3d%3d) 
See also the [ESP-WROOM-32 data sheet](../doc/esp32-wroom-32_datasheet_en-1510934.pdf) copy in the local [doc](../doc/) folder

## ESP32 SPI **

IOMUX pins for SPI controllers are as below:

| -------- | ---- | ---- |
| Pin Name | HSPI | VSPI |
|          | ---- | ---- |
|          | GPIO Number |
|==========|======|======|
| CS0*     | 15   | 5    |
| -------- | ---- | ---- |
| SCLK     | 14   | 18   |
| -------- | ---- | ---- |
| MISO     | 12   | 19   |
| -------- | ---- | ---- |
| MOSI     | 13   | 23   |
| -------- | ---- | ---- |
| QUADWP   | 2    | 22   |
| -------- | ---- | ---- |
| QUADHD   | 4    | 21   |
| -------- | ---- | ---- |

note * Only the first device attaching to the bus can use CS0 pin.

** from the [ESP-IDF Programming Guide: SPI Master driver](https://docs.espressif.com/projects/esp-idf/en/latest/api-reference/peripherals/spi_master.html#gpio-matrix-and-iomux)

## Passthru FPGA Needed

The FPGA sits between the display and the ESP32, allowing either the FPGA or ESP32 to control the SSD-1331 display. An FPGA design is needed to "wire" the
connection between the ESP32 to allow that device to control the display. Keep this in mind if also writing something in FPGA that also attempts to
control the display concurrently. 

The default for `ujprog` is to program to volatile SRAM (power cycle to revert). See the `-j` parameter to make FPGA changes persistent. 

### Quick Start Passthru

Windows
tip: you can open a command prompt by rick-clicking on the project om Visual Studio, select Open Folder in File Explorer, then type `cmd` in the path and press `enter`.
```
:: From this project directory (e.g. c:\workspace\ulx3s-examples\VisualMicro-SSD1331-Display )
cd ..\bin
ujprog.exe passthru_implementation_12F.bit
```

### SSD1331 to ESP32 Passthru via FPGA details

The ULX3S will typically ship with the passthru code already loaded on the FPGA. So this step may not always be needed.

As noted in other ULX3S ESP32 projects such as the [Getting Started with Visual Micro](../VisualMicro/README.md), 
the ESP32 sits behind the FPGA chip:

![ESP32_on_ULX3S](../images/ESP32_on_ULX3S.png)

Although this allows for maximum flexibility, it also results in some additional complexity in that the FPGA chip needs to be configured
to "allow" the ESP32 to control the SSD1331 SPI display (as opposed to say, the FPGA using thg display). The [passthru](../passthru/README.md) 
FPGA project connects not only some of ESP32 pins to the physical ULX3S external pins, but also connects the ESP32 to the SPI 
connector for the SSD1331 display.

Of particular interest, are these lines from the 
[WiFi passthrough](https://github.com/emard/ulx3s-passthru/blob/71ce18953f84ea8ee07bb42d42ddc5a2673623c3/rtl/ulx3s_v20_passthru_wifi.vhd#L116) example:

```
S_oled_csn <= wifi_gpio17;
oled_csn   <= S_oled_csn;
oled_clk   <= sd_clk; --wifi_gpio14
oled_mosi  <= sd_cmd; --wifi_gpio15 aka SDA
oled_dc    <= wifi_gpio16;
oled_resn  <= gp(11); --wifi_gpio25
```

And these FPGA pin definitions:
```
// see ULX3S Contraint File for SSD1331
// N2 - OLED_CS
// P1 - OLED_DC
// P2 - OLED_RES
// P3 - OLED_MOSI // Note sd_cmd which is hard wired to GPIO15 on WROOM32 pin 23
// P4 - OLED_CLK  // Note sd_clk which is hard wired to GPIO14 on WROOM32 pin 13
```

Specifically from the [constraint file](../doc/constraints/ulx3s_v20.lpf#L72) (listed in physical board-connection order):
```
LOCATE COMP "oled_csn"  SITE "N2";
LOCATE COMP "oled_dc"   SITE "P1";
LOCATE COMP "oled_resn" SITE "P2";
LOCATE COMP "oled_mosi" SITE "P3";
LOCATE COMP "oled_clk"  SITE "P4";

IOBUF PORT "oled_csn"  PULLMODE=UP IO_TYPE=LVCMOS33 DRIVE=4;
IOBUF PORT "oled_dc"   PULLMODE=UP IO_TYPE=LVCMOS33 DRIVE=4;
IOBUF PORT "oled_resn" PULLMODE=UP IO_TYPE=LVCMOS33 DRIVE=4;
IOBUF PORT "oled_mosi" PULLMODE=UP IO_TYPE=LVCMOS33 DRIVE=4;
IOBUF PORT "oled_clk"  PULLMODE=UP IO_TYPE=LVCMOS33 DRIVE=4;
```

the above FPGA connectioned need to be "wired" in FPGA to connect to these constraint items:
```
LOCATE COMP "wifi_gpio17" SITE "N3"; # Serial1 TX
LOCATE COMP "wifi_gpio16" SITE "L1"; # Serial1 RX
LOCATE COMP "gn[11]"      SITE "E3"; # J1_31- GN11 DIFF WIFI_GPIO25
LOCATE COMP "sd_cmd"      SITE "J1"; # sd_cmd_di (MOSI) WiFi GPIO15
LOCATE COMP "sd_clk"      SITE "H2"; # sd_clk WiFi_GPIO14
```

From the FPGA code, the intent of the passthru for the display is to connect these "wires":

* N2 to N3 for oled_csn /CS  to wifi_gpio17 (GPIO17)
* P1 to L1 for oled_dc  /DC  to wifi_gpio16 (GPIO16)
* P2 to E3 for oled_resn/RES to wifi_gpio25 (GPIO25) 
* P3 to J1 for oled_mosi/SDA to sd_cmd      (GPIO15) 
* P4 to H2 for oled_clk /SCL to sd_clk      (GPIO14)

## Pull-up needed

Note that although the contraint file seems to indicate that there's a built-in pull-up with the `PULLMODE=UP`, 
the code on the ESP32 still needs to explicitly assign the `pinMode` to each of the SPI connections with 
the `INPUT_PULLUP`, or the display will not work properly:

```
	// some C / Arduino code for display init
	#define oled_csn  17
	#define oled_dc   16
	#define oled_resn 25
	#define oled_mosi 15
	#define oled_clk  14

	// explicit pullup defintion is essential 
	pinMode(oled_csn,  INPUT_PULLUP); // pullup SPI
	pinMode(oled_dc,   INPUT_PULLUP); // pullup SPI
	pinMode(oled_resn, INPUT_PULLUP); // pullup SPI
	pinMode(oled_mosi, INPUT_PULLUP); // pullup SPI shared with SD
	pinMode(oled_clk,  INPUT_PULLUP); // pullup SPI shared with SD
```
TODO: is `INPUT_PULLUP` really needed for _output_ pins?

## Arduino Libraries Needed

Two libraries can be used to vastly simplify the use of the display with Visual Micro or the Arduinio IDE for the ESP32:

* [Adafruit_GFX](https://github.com/adafruit/Adafruit-GFX-Library) 
* [Adafruit_SSD1331](https://github.com/adafruit/Adafruit-SSD1331-OLED-Driver-Library-for-Arduino)

These can be either installed manually from GitHub, or from the Arduino IDE. Note that when updating libraries, if
any unexpected compile-time errors occur, ensure that the _latest_ libraries are _all_ updated. For Visual Micro
projects, click on `Extensions - vMicro - Visual Micro Explorer` and click `refresh`.

![VisualMicro-Explorer.PNG](../images/VisualMicro-Explorer.PNG)

### Windows Arduino Libraries from GitHub for the first time

```
c:
cd %USERPROFILE%\documents\Arduino\libraries
git clone https://github.com/adafruit/Adafruit-GFX-Library
git clone https://github.com/adafruit/Adafruit-SSD1331-OLED-Driver-Library-for-Arduino
```

### Windows Arduino Libraries on Windows from GitHub - updates

```
c:
cd %USERPROFILE%\documents\Arduino\libraries
cd Adafruit-GFX-Library
git fetch
fit pull

cd %USERPROFILE%\documents\Arduino\libraries
cd Adafruit-SSD1331-OLED-Driver-Library-for-Arduino
git fetch
fit pull
```

### Windows Arduino IDE Libraries 

Ensure the [ESP32 Board](https://github.com/espressif/arduino-esp32/blob/master/docs/arduino-ide/boards_manager.md) is installed. 
This line may need to be added to the _Additional Board Manager URLs_ field:

`https://dl.espressif.com/dl/package_esp32_index.json`

To install libraries from the Arduino IDE, click `Sketch - Include Library - Manage Libraries`:

![ArduinoIDE-SelectLibraryManager.PNG](../images/ArduinoIDE-SelectLibraryManager.PNG)

Install [Adafruit_GFX](https://github.com/adafruit/Adafruit-GFX-Library) 

![ArduinoIDE-Adafruit-GFX-Library.png](../images/ArduinoIDE-Adafruit-GFX-Library.png)
                                                 
Install [Adafruit_SSD1331](https://github.com/adafruit/Adafruit-SSD1331-OLED-Driver-Library-for-Arduino)

![ArduinoIDE-Adafruit-SSD1331-Library.PNG](../images/ArduinoIDE-Adafruit-SSD1331-Library.png)
            
## Some SPI Tips
(copied [from SSD_13XX library notes](https://github.com/sumotoy/SSD_13XX/blob/master/README.md) with thanks and credits to [@sumotoy](https://github.com/sumotoy) for this section)

> <b>Connections:</b><br>
> Of course some oled has just SPI exposed but some can be configured for parallel, I2C and so on. I'm using ONLY SPI here (so don't ask for any other protocol please).<br>
> - RST Connect to +3v3 using a 4k7->10k resistor.
> - scl, sclk -> SCLK
> - sda, sdin -> MOSI
> - DC,RS ->DC pin on MCU
> - some oled has WR, RD. Leave floating...
> - some oled has D0...D7. Most of the times D0 and D1 are used for SPI, connect D2...D7 to GND or will be unstable!
> - VIN. Most oled support 5v, internally they have regulators, but follow specifications of your particular oled!
> - 3v3. This is 99% of the times an OUT! So do not use it.<br>
> 
> <b>Some notes, please read this, will save your time:</b><br>
> - Even if your OLED can work at 5V, it cannot accept logic levels at 5V!!! All OLED accept logic levels at 3v3 so if you plan to use an AVR (like UNO) you need a level converted (like CD4050 or HCF4050 powered at 3v3, very cheap).
> - Do not use logic converters based on mosfet or similar or bidirectional ones (Adafruit and Sparkfun sell a lot of these), they are crap, waveforms are distorted and DO NOT USE PARTITION RESISTOR's for that, it's a bad idea, you can damage oled and cpu in the same time.
> - Most of you know already this but remember that Arduino UNO or similar can provide 3v3 but the logic levels are always at 5V!!!
> - The RST pin is not strictly necessary but if not used must pullup to 3v3, never leave float! When is necessary? When you develop a library for example but if you change libraries you may need a complete power cycle if you are not using this pin.
> - ESP8266 has very weak SPI, should be 3v3 but most of the times is much less so better avoid use any logic chip between it and oled, I spend days around a circuit before discovering this.
> - On ESP8266, from April 2016 the pin GPIO16 misteriously doesn't works as CS, don't ask me why. I'm currently using GPIO2 or GPIO4.
> - Since I'm using the fast SPI possible, keep wires short and remember to provide a decoupling capacitor for your oled.<br>
> - If you plan to use SPI for other devices as well it's a good idea pullup the CS with a 10K resistor to +3v3, this will keep oled disabled until your CPU access it for initialization and avoid interferences.
> - It's always a good idea provide a pullup for each CS if multiple SPI devices are used, when CPU start all devices are forced disabled and CPU is able to access one by one and initialize all of them correctly, keep in mind and you will happy in the future!<br>

## Hardware SPI can be slower on the ESP32
(copied from [espressif/arduino-esp32/issues/149](https://github.com/espressif/arduino-esp32/issues/149#issuecomment-275633601) with thanks and credit to [@me-no-dev](https://github.com/me-no-dev) )

> Here is the thing about SPI and all other drivers running on ESP32:
> 
> * We have 2 cores, so there is the possibility that hardware could be accessed from both cores at the same time
> * In order to prevent that, we use mutexes
> * Locking and unlocking mutexes takes time :(
> 
> Now the ESP32 on other hand can transfer lots of data with just one lock/unlock, but that is not something that Arduino has on lower platforms (AVR), so libraries use the byte-by-byte approach to communicate, which in turn means lock/unlock every byte. And that is what causes the slowdown you see.
> 
> There are generally two ways to speed things up:
> 
> * Update all libraries to use proper multi-byte api on ESP32 (Espressif is rolling out own ILI9341 driver based on Adafruit's API)
> * Disable hardware locking by adding `#define CONFIG_DISABLE_HAL_LOCKS 1` to [esp32-hal.h](https://github.com/espressif/arduino-esp32/blob/master/cores/esp32/esp32-hal.h)


## Arduino Implementation Notes

This an Arduino-style solution, suitable for use with either the [Ardunio IDE](https://www.arduino.cc/en/Main/Software), 
or [Visual Micro](https://www.visualmicro.com/). The display can be initialized either with this software SPI, which is 
perhaps more flexible but a little slower:

```
Adafruit_SSD1331 display = Adafruit_SSD1331(cs, dc, mosi, sclk, rst);
```

... or the alternative is this hardware SPI instantiation (untested / not working at this time):
```
Adafruit_SSD1331 display = Adafruit_SSD1331(&SPI, cs, dc, rst);
```
Note the [comments in the Adafruit code](https://github.com/adafruit/Adafruit-SSD1331-OLED-Driver-Library-for-Arduino/blob/master/examples/LCDGFXDemo/LCDGFXDemo.ino#L29):

> hwspi hardcodes those pins, no need to redefine them.

 **As the ULX3S appears to use different pins, is HWSPI even possible?** The `cs`, `dc`, `rst` pins do not seem to be otherwise defined without the macros. 

The `&SPI` is defined in `%USERPROFILE%\Documents\Arduino\hardware\espressif\esp32\libraries\SPI\src\SPI.cpp` of interest, is this initialization code:

```
    if(sck == -1 && miso == -1 && mosi == -1 && ss == -1) {
        _sck = (_spi_num == VSPI) ? SCK : 14;
        _miso = (_spi_num == VSPI) ? MISO : 12;
        _mosi = (_spi_num == VSPI) ? MOSI : 13;
        _ss = (_spi_num == VSPI) ? SS : 15;
    } else {
        _sck = sck;
        _miso = miso;
        _mosi = mosi;
        _ss = ss;
    }
```
We're looking for the defaults not explicitly stated in the declaration `Adafruit_SSD1331(&SPI, oled_csn, oled_dc, oled_resn);` specifically (`MOSI` and `SCLK`) - however here it appears `MISO` is pin 12 and `SCK` is 15 (we are expecting `MOSI`=15 and `SCK`=14) when `_spi_num != VSPI`. 

TODO: where is `_spi_num` defined?

The last line of file `SPI.cpp` 
```
SPIClass SPI(VSPI);
```

Note in `MAIN_ESP32_HAL_SPI_H_` (.\Arduino\hardware\espressif\esp32\cores\esp32\esp32-hal-spi.h)
```
#define VSPI  3 //SPI bus normally attached to pins 5, 18, 19 and 23, but can be matrixed to any pins
```

## Other Comments

See https://forums.adafruit.com/viewtopic.php?f=8&t=65785:

> "The color SSD1331 display does allow direct access to the display memory via SPI - which is a good thing. It would be impossible to fit a full-color frame-buffer into the available SRAM on many microcontrollers. With 16 bits per pixel, it needs 16 times as much memory as a similarly sized monochrome display."

> "If you use HWSpi, the adafruit library defaults to 40Mhz, you can make it twice as fast by going to the full 80Mhz speed if your hardware supports it (worked for me with ESP8266):
display.begin(80000000);"

## other stuff

See supplements (TODO - which are actually needed?)
```
cd C:\Users\gojimmypi\Documents\Arduino\libraries
git clone https://github.com/me-no-dev/ESPAsyncTCP.git
git clone https://github.com/me-no-dev/AsyncTCP.git
git clone https://github.com/me-no-dev/ESPAsyncWebServer.git
git clone https://github.com/emard/LibXSVF

```

## See also
* [espressif/arduino-esp32](https://github.com/espressif/arduino-esp32) - Arduino core for the ESP32
* [emard/ulx3s](https://github.com/emard/ulx3s) - PCB for ULX3S FPGA R&D board
* [ULX3S Schematics](https://github.com/emard/ulx3s/blob/master/doc/schematics.pdf) - 
* [Adafruit SPI Protocol](https://learn.adafruit.com/circuitpython-basics-i2c-and-spi/spi-devices) - CircuitPython Basics: I2C and SPI
* [emard/ulx3s/issues/8](https://github.com/emard/ulx3s/issues/8) ESP32 to SSD1331 HWSPI using correct default pin numbers?
* [espressif/arduino-esp32/issues/149](https://github.com/espressif/arduino-esp32/issues/149#issuecomment-275633601) - slow hardware SPI on ESP32
* [sumotoy/SSD_13XX](https://github.com/sumotoy/SSD_13XX) - See the README for some excellent SPI information.
* [emard/SSD_13XX](https://github.com/emard/SSD_13XX.git) - fork of [sumotoy/SSD_13XX](https://github.com/sumotoy/SSD_13XX) for the ULX3S
* [Adafruit 0.96" mini Color OLED technical details](https://learn.adafruit.com/096-mini-color-oled/downloads)
* [espressif/Adafruit-GFX-Library](https://github.com/espressif/Adafruit-GFX-Library) (fork from []())
* [mgo-tec/ESP32_SD_SSD1331_Gadgets](https://github.com/mgo-tec/ESP32_SD_SSD1331_Gadgets)
* [websvf_sd](https://github.com/emard/LibXSVF-ESP/blob/master/examples/websvf_sd/websvf_sd.ino) - the default as-shipped software on the ULX3S
* [olikraus/ucglib](https://github.com/olikraus/ucglib) - Color graphics library for embedded systems with focus on Arduino Environment.
* [ODRIOD-GO Getting started with Arduino](https://wiki.odroid.com/odroid_go/arduino/01_arduino_setup) and on [GitHub](https://github.com/hardkernel/ODROID-GO)
* [gojimmypi blog](https://gojimmypi.blogspot.com/2019/02/) - Notes on ulx3s FPGA
* [ESP-IDF Programming Guide](https://docs.espressif.com/projects/esp-idf/en/latest/) Specifically [SPI Master Driver](https://docs.espressif.com/projects/esp-idf/en/latest/api-reference/peripherals/spi_master.html)
* [NodeMCU SPI Documentation](https://nodemcu.readthedocs.io/en/dev-esp32/modules/spi/)