Using Visual Micro to program the ULX3S ESP32

[Download the Arduino IDE for Visual Studio and Atmel Studio](https://www.visualmicro.com/page/Arduino-Visual-Studio-Downloads.aspx)

or install the [Arduino IDE from the Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=VisualMicro.ArduinoIDEforVisualStudio)

Ensure the [FPGA pass-thru](../passthru/) code is loaded onto the FPGA.


# Windows commandline / DOS prompt
```
if NOT EXIST c:\workspace mkdir c:\workspace
git clone https://github.com/gojimmypi/ulx3s-examples.git c:\workspace\ulx3s-examples
c:
cd \workspace\ulx3s-examples\VisualMicro\bin\
.\ujprog.exe passthru.bit
```

# WSL
```
mkdir -p /mnt/c/workspace/
git clone https://github.com/gojimmypi/ulx3s-examples.git /mnt/c/workspace/ulx3s-examples
cd /mnt/c/workspace/ulx3s-examples/VisualMicro/bin/
./ujprog -j FLASH passthru.bit

```

See also: 
* [Windows ujprog command-line parameter issues](https://github.com/f32c/tools/issues/10)
* [Windows ujprog compile error: 'EOPNOTSUPP' undeclared](https://github.com/f32c/tools/issues/8)
