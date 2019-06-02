# MicroPython on the ULX3S ESP32

Examples assume the ULX3S is found on COM13

## Windows/DOS - the easy way
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
MAC: 3c:71:bf:17:c4:68
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

## WSL with Windows EXE (also fails)
```
 ./esptool.exe --chip esp32 --port /dev/ttyS13 --baud 460800 write_flash -z 0x1000 esp32-20190529-v1.11.bin
```

WSL Windows EXE failure message (same EXE that works with DOS command prompt, above):
```
$ ./esptool.exe --chip esp32 --port /dev/ttyS13 --baud 460800 write_flash -z 0x1000 esp32-20190529-v1.11.bin
esptool.py v2.6-beta1
Serial port /dev/ttyS13
Traceback (most recent call last):
  File "esptool.py", line 2865, in <module>
  File "esptool.py", line 2858, in _main
  File "esptool.py", line 2565, in main
  File "esptool.py", line 213, in __init__
  File "site-packages\serial\__init__.py", line 88, in serial_for_url
  File "site-packages\serial\serialwin32.py", line 62, in open
serial.serialutil.SerialException: could not open port '/dev/ttyS13': WindowsError(3, 'The system cannot find the path specified.')
Failed to execute script esptool
```
 
See files in:
```
C:\Users\%USERNAME%\AppData\Local\arduino15\packages\esp32\tools\esptool_py\2.6.0\
C:\Users\%USERNAME%\AppData\Local\arduino15\packages\esp32\hardware\esp32\1.0.1\tools\sdk\bin\
C:\Users\%USERNAME%\AppData\Local\arduino15\packages\esp32\hardware\esp32\1.0.1\tools\partitions\
```

See also:

https://github.com/espressif/esptool
https://micropython.org/download#esp32

