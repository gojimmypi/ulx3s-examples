Using VisualMicro to program the ULX3S SSD1331 Display from ESP32

# Passthru needed

As noted in other projects such as the [Getting Started with Visual Micro](../VisualMicro/README.md), the ESP32 sits behind the FPGA chip:

![ESP32_on_ULX3S](../images/ESP32_on_ULX3S.png)

Although this allows for maximum flexibility, it also results in some additional complexity in that the FPGA chip needs to be configured
to "allow" the ESP32 to control the SSD1331 SPI display (as opposed to say, the FPGA using thg display). The [passthru](../passthru/README.md) 


See supplements (TODO - wich are actually needed?)
```
cd C:\Users\gojimmypi\Documents\Arduino\libraries
git clone https://github.com/me-no-dev/ESPAsyncTCP.git
git clone https://github.com/me-no-dev/AsyncTCP.git
git clone https://github.com/me-no-dev/ESPAsyncWebServer.git
git clone https://github.com/emard/LibXSVF

```

## See also
* https://github.com/mgo-tec/ESP32_SD_SSD1331_Gadgets
* https://github.com/emard/LibXSVF-ESP/blob/master/examples/websvf_sd/websvf_sd.ino
* https://gojimmypi.blogspot.com/2019/02/
