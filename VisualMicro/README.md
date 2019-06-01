# Using Visual Micro to program the ULX3S ESP32

Similar to the [Arduino Blinky for the ESP32](../blinky/ESP32), this example uses the Visual Micro IDE.

[Download the Arduino IDE for Visual Studio and Atmel Studio](https://www.visualmicro.com/page/Arduino-Visual-Studio-Downloads.aspx)

or install the [Arduino IDE from the Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=VisualMicro.ArduinoIDEforVisualStudio)

Ensure the [FPGA pass-thru](../passthru/) code is loaded onto the FPGA, as the ESP32 sits behind the iCE40:

![ESP32-on-ULX3S](./images/ESP32_on_ULX3S.png )

## Windows commandline / DOS prompt
```
if NOT EXIST c:\workspace mkdir c:\workspace
git clone https://github.com/gojimmypi/ulx3s-examples.git c:\workspace\ulx3s-examples
c:
cd \workspace\ulx3s-examples\VisualMicro\bin\
.\ujprog.exe passthru.bit
```

## WSL
There is still not native USB driver support in WSL, so we expect an error message such as:
```
ULX2S / ULX3S JTAG programmer v 3.0.92 (built Jun  1 2019 15:29:22)
Cannot find JTAG cable.
```
We can call the Windows version from the Linux prompt, Note that for some unknown reason, it needs to be called from the Windows file system and not the Linux one. (e.g. not `~/workspace/`). Symptoms of running the Windows executable from the WSL filesystem is that no output at all is returned.
```
mkdir -p /mnt/c/workspace/  # this is actually C:\workspace\ to Windows
git clone https://github.com/gojimmypi/ulx3s-examples.git /mnt/c/workspace/ulx3s-examples
cd /mnt/c/workspace/ulx3s-examples/VisualMicro/bin/
# ./ujprog.exe -j FLASH passthru.bit # optionally write to flash
./ujprog.exe passthru.bit
```
Here are some key settings in Visual Micro:

![ESP32-on-ULX3S-settings](./images/VisualMicro_ULX3S_settings.png )

See also: 
* [gojimmypi blog on Using Visual Micro to program the ULX3S ESP32]()
* [Windows ujprog command-line parameter issues](https://github.com/f32c/tools/issues/10)
* [Windows ujprog compile error: 'EOPNOTSUPP' undeclared](https://github.com/f32c/tools/issues/8)
