# FPGA passthru 

FPGA passthru app allowing programming of the ESP32. 

## Passthru Details

As shown in the [schematics](../doc/schematics.pdf) (page 7), the ESP32 pins are not directly accessible, and need an FPGA signal PassThru to be loaded.

![ESP32-on-ULX3S](./images/ESP32-on-ULX3S.PNG )

## Passthru Project Options

There are several options for creating and/or loading the FPGA bitstream to allow passthru of key pins to the ESP32:

* [FPGA PassThru QuickStart](./passthru/README.md#quick-start-fpga-passthru) - when you just want to load known, working code

* [FPGA PassThru in VHDL using Lattice Diamond for Windows](./passthru/Diamond/README.md) - this is the [original code by emard](https://github.com/emard/ulx3s-passthru).

* [FPGA PassThru in Verilog using Lattice Diamond for Windows](./passthru/DiamondVerilog/README.md) - this is [emard's code](https://github.com/emard/ulx3s-passthru), converted to Verilog with [vhd2vl](https://github.com/ldoolitt/vhd2vl).

* [FPGA PassThru in Verilog using Open Source](./passthru/OpenSource/README.md) - this is [emard's code](https://github.com/emard/ulx3s-passthru) and configured to use yosys/nextpnr.

TODO: Note although the Open Source Verilog compiles, and allows _uploading_ of code to the ESP32, the SPI Display does not work, despite being the exact same Verilog as the Diamond compile. (why??)

See also [Build Open Source Toolchain yosys/nextpnr](./OpenSource-toolchain/README.md)

## Quick Start FPGA passthru

See [bin/upload_passthru.sh](../bin/upload_passthru.sh) or [bin/upload_passthru.bat](../bin/upload_passthru.bat)

For additional passthru info, see https://github.com/emard/ulx3s-passthru

## See also

* [VisualMicro Arduino IDE for programming the ESP32 with Visual Studio](../VisualMicro/README.md)
* [Blinky ESP32 using Arduino IDE](../blinky/ESP32/README.md)
* [MicroPython on the ULX3S](../MicroPython/README.md)
