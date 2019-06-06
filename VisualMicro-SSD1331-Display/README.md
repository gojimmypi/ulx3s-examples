# Using VisualMicro to program the ULX3S SSD1331 Display from ESP32

## Quick Start

First, ensure the [FPGA passthru](../passthru/README.md) is enabled. 
Next, install [Visual Micro](../VisualMicro/README.md), 
the [Adafruit GFX](https://github.com/adafruit/Adafruit-GFX-Library) 
and [SSD1331](https://github.com/adafruit/Adafruit-SSD1331-OLED-Driver-Library-for-Arduino) libraries, 
then open the `VisualMicro-SSD1331-Display.sln` solution file in Visual Studio.
Select the COM port for your ULX3S and press F5.

## SSD1331 Display

The ULX3S board has a connector near the center of the board for an optional display:

![ulx3st-display-connector.jpg](../images/ulx3st-display-connector.jpg)

From the [schematic](../doc/schematics.pdf), these are the connector names defined for the display:

![SSD1331_connector.PNG](../images/SSD1331_connector.PNG)

If your ULX3S does not have a display, you can [buy one from Adafruit](https://www.adafruit.com/product/684).

See also the [pdf specification for the SSD-1331 Display](../docs/SSD1331_1.2.pdf) in the [docs](../docs/) folder.

## Passthru Needed

The ULX3S will typically ship with the passthru code already loaded. So this step may not always be needed.

As noted in other ULX3S ESP32 projects such as the [Getting Started with Visual Micro](../VisualMicro/README.md), 
the ESP32 sits behind the FPGA chip:

![ESP32_on_ULX3S](../images/ESP32_on_ULX3S.png)

Although this allows for maximum flexibility, it also results in some additional complexity in that the FPGA chip needs to be configured
to "allow" the ESP32 to control the SSD1331 SPI display (as opposed to say, the FPGA using thg display). The [passthru](../passthru/README.md) 
FPGA project connects not only some of ESP32 pins to the physical ULX3S external pins, but also connects the ESP32 to the SPI 
connector for the SSD1331 display.

Of particular interest, are these lines from the 
[WiFi passthrough](https://github.com/emard/ulx3s-passthru/blob/master/rtl/ulx3s_v20_passthru_wifi.vhd#L116) example:

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

## Arduino Libraries Needed

Two libraries can be used to vastly simplify the use display with Visual Micro or the Arduinio IDE for the ESP32:

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

To install libraries from the Arduino IDE, click `Sketch - Include Library - Manage Libraries`:

![ArduinoIDE-SelectLibraryManager.PNG](../images/ArduinoIDE-SelectLibraryManager.PNG)

Install [Adafruit_GFX](https://github.com/adafruit/Adafruit-GFX-Library) 

![ArduinoIDE-Adafruit-GFX-Library.png](../images/ArduinoIDE-Adafruit-GFX-Library.png)
                                                 
Install [Adafruit_SSD1331](https://github.com/adafruit/Adafruit-SSD1331-OLED-Driver-Library-for-Arduino)

![ArduinoIDE-Adafruit-SSD1331-Library.PNG](../images/ArduinoIDE-Adafruit-SSD1331-Library.png)
                                                     
## Arduino Implmentation Notes

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

See supplements (TODO - wich are actually needed?)
```
cd C:\Users\gojimmypi\Documents\Arduino\libraries
git clone https://github.com/me-no-dev/ESPAsyncTCP.git
git clone https://github.com/me-no-dev/AsyncTCP.git
git clone https://github.com/me-no-dev/ESPAsyncWebServer.git
git clone https://github.com/emard/LibXSVF

```

## See also
* [Adafruit 0.96" mini Color OLED technical details](https://learn.adafruit.com/096-mini-color-oled/downloads)
* https://github.com/mgo-tec/ESP32_SD_SSD1331_Gadgets
* https://github.com/emard/LibXSVF-ESP/blob/master/examples/websvf_sd/websvf_sd.ino
* https://gojimmypi.blogspot.com/2019/02/
