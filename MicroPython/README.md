# MicroPython on the ULX3S ESP32

Ensure the [FPGA pass-thru](../passthru/) code is loaded onto the FPGA, as the ESP32 sits behind the ECP5 FPGA chip:

![ESP32-on-ULX3S](./images/ESP32_on_ULX3S.png )

## Quick Start FPGA passthru
See [bin/upload_passthru.sh](../bin/upload_passthru.sh) or  [bin/upload_passthru.bat](../bin/upload_passthru.bat)

## Windows / DOS prompt: load FPGA passthru to program the ESP32
```
if NOT EXIST c:\workspace mkdir c:\workspace
git clone https://github.com/gojimmypi/ulx3s-examples.git c:\workspace\ulx3s-examples
c:
cd \workspace\ulx3s-examples\bin\
.\ujprog.exe passthru.bit
```

## WSL - load FPGA passthru
There is still no native USB driver support in WSL, so we expect an error message such as:
```
ULX2S / ULX3S JTAG programmer v 3.0.92 (built Jun  1 2019 15:29:22)
Cannot find JTAG cable.
```
We can call the Windows version from the Linux prompt. Note that for some unknown reason, it needs to be called from the Windows file system and not the Linux one. (e.g. not `~/workspace/`). Symptoms of running the Windows executable from the WSL filesystem is that no output at all is returned from `ujprog.exe`.
```
mkdir -p /mnt/c/workspace/  # this is actually C:\workspace\ to Windows
git clone https://github.com/gojimmypi/ulx3s-examples.git /mnt/c/workspace/ulx3s-examples
cd /mnt/c/workspace/ulx3s-examples/bin/
# ./ujprog.exe -j FLASH passthru.bit # optionally write to flash
./ujprog.exe passthru.bit
```

Examples assume the ULX3S is found on COM13

## Windows/DOS - the easy way to load MicroPython onto the ULX3S
```
if NOT EXIST c:\workspace mkdir c:\workspace
git clone https://github.com/gojimmypi/ulx3s-examples.git c:\workspace\ulx3s-examples
c:
cd \workspace\ulx3s-examples\MicroPython\bin\
esptool.exe --chip esp32 --port "COM13" --baud 460800 write_flash -z 0x1000 esp32-20190529-v1.11.bin
```
should give output like this:

```
esptool.py v2.6-beta1
Serial port COM13
Connecting....
Chip is ESP32D0WDQ6 (revision 1)
Features: WiFi, BT, Dual Core, 240MHz, VRef calibration in efuse, Coding Scheme None
MAC: 3c:71:bf:xx:xx:xx
Uploading stub...
Running stub...
Stub running...
Changing baud rate to 460800
Changed.
Configuring flash size...
Auto-detected Flash size: 4MB
Compressed 1146864 bytes to 717504...
Wrote 1146864 bytes (717504 compressed) at 0x00001000 in 17.5 seconds (effective 522.8 kbit/s)...
Hash of data verified.

Leaving...
Hard resetting via RTS pin...
```

## WSL - the easy way (but currently fails)
```
sudo apt-get update
sudo apt-get install esptool
sudo chmod 0666 /dev/ttyS13
cd /mnt/c/workspace/ulx3s-examples/MicroPython/bin/
esptool --chip esp32 --port /dev/ttyS13 --baud 460800 write_flash -z 0x1000 esp32-20190529-v1.11.bin
```

WSL fails with error (perhaps the apt-get version is too old?)
```
$ esptool --chip esp32 --port /dev/ttyS13 --baud 460800 write_flash -z 0x1000 esp32-20190529-v1.11.bin
esptool.py v2.1
Connecting....
Chip is ESP32D0WDQ6 (revision (unknown 0xa))
Changing baud rate to 460800
Changed.
Enabling default SPI flash mode...

A fatal error occurred: Timed out waiting for packet header
```

## WSL with Windows EXE to load MicroPython onto the ULX3S
Note when calling EXE files in WSL, we need to use COM port refrerences and not /dev/ttySnn !)
```
cd /mnt/c/workspace/ulx3s-examples/MicroPython/bin/
./esptool.exe --chip esp32 --port COM13 --baud 460800 write_flash -z 0x1000 esp32-20190529-v1.11.bin
```

 
# See files in:
```
C:\Users\%USERNAME%\AppData\Local\arduino15\packages\esp32\tools\esptool_py\2.6.0\
C:\Users\%USERNAME%\AppData\Local\arduino15\packages\esp32\hardware\esp32\1.0.1\tools\sdk\bin\
C:\Users\%USERNAME%\AppData\Local\arduino15\packages\esp32\hardware\esp32\1.0.1\tools\partitions\
```

# See also:

https://github.com/espressif/esptool
https://micropython.org/download#esp32
https://github.com/Microsoft/WSL/issues/1929
https://discourse.tinyfpga.com/t/recognizing-tinyfpga-bx-in-wsl/849/10


