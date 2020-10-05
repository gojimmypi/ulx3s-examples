# ULX3S Examples

Getting started with the [ULX3S](https://radiona.org/ulx3s/) is easy! You just need a Verilog source code file and the [constraint file](./doc/constraints/ulx3s_v20.lpf). 

To program the FPGA on the ULX3S, either the commercial [Lattice Diamond](http://www.latticesemi.com/latticediamond) or Open Source tools such as [yosys](https://github.com/YosysHQ/yosys), [nextpnr](https://github.com/YosysHQ/nextpnr) and  [fujprog](https://github.com/kost/fujprog) are needed.

If you've never worked with FPGA devices, they are programmed with a _hardware definition_ language or "HDL", that may look like a traditional programming language - however it is quite different. The "code" is really just a clever shorthand for how circuits and logic gates are connected. Verilog is one type of HDL. 

You can learn more at sites such as [fpga4fun](http://www.fpga4fun.com/), [asic-world digital logic](http://www.asic-world.com/digital/tutorial.html), [asic-world verilog](http://www.asic-world.com/verilog/veritut.html) and [nandland](https://www.nandland.com/verilog/tutorials/index.html).

Once you have your circuit logic generically defined properly in a Verilog file, the hardware-specific constraint file is used to connect the inputs and outputs of the Verilog code to physical pins on the FPGA device.

Here is a collection of various ULX3S examples to get started:

* [ESP 32 Blinky](./blinky/ESP32/README.md)

* [FPGA Blinky in Lattice Diamond for Windows](./blinky/Diamond/README.md)

* [FPGA Blinky using Open Source](./blinky/OpenSource/README.md)

* [FPGA PassThru QuickStart](./passthru/README.md#quick-start-fpga-passthru)

* [FPGA PassThru in VHDL using Lattice Diamond for Windows](./passthru/Diamond/README.md)

* [FPGA PassThru in Verilog using Lattice Diamond for Windows](./passthru/DiamondVerilog/README.md)

* [Build Open Source Toolchain yosys/nextpnr](./OpenSource-toolchain/README.md)

* [FPGA PassThru using Open Source](./passthru/OpenSource/README.md)

* [Using Visual Micro to program the ESP32](./VisualMicro/README.md)

* [Visual Micro ESP32 SSD1331 Display Example](./VisualMicro-SSD1331-Display/README.md)

* [Using nanoFramework to program the ESP32 with C#](./passthru/nanoFramework/README.md)

* [MicroPython on the ULX3S ESP32](./MicroPython/README.md)

* [More links to RadionaOrg ULX3S examples](https://github.com/RadionaOrg/ulx3s-links/blob/master/README.md) 

## Common Problems

Here are some common problems that may be encountered, and how to resolve them.

### FT_Open() failed Cannot find JTAG cable.
Check to see if the serial port is in use, such as:
* Arduino Serial Monitor
* Visual Micro Serial Monitor
* Putty
* Anything else that might have the serial port in use

### Found unknown (FFFFFFFF) device, but the bitstream is for LFE5U-12E.

This error has been seen when experimenting with SPI pins to get VSPI/HSPI working. Create and upload a blank Arduino project (empty `setup` / `loop`)

## See also: 

[binaries](./bin/README.md), [hardware](https://github.com/emard/ulx3s), [kost/fujprog](https://github.com/kost/fujprog)

* https://github.com/goran-mahovlic/fpga-odysseus/tree/master/tutorials/04-Video

* https://github.com/albertxie/iverilog-tutorial/blob/master/code_samples/simple_tb.v

* https://github.com/mmicko/cross-fpga

* https://github.com/jhol/otl-modem/blob/master/fw/syn/top.v

* [icestorm](http://www.clifford.at/icestorm/)

* [Windows Subsystem for Linux (WSL): what can't I do with the Ubuntu application for Microsoft Windows?](https://askubuntu.com/questions/1051525/windows-subsystem-for-linux-wsl-what-cant-i-do-with-the-ubuntu-application-f)

* [ldoolitt/vhd2vl](https://github.com/ldoolitt/vhd2vl) and [doolittle.icarus.com/~larry/vhd2vl/](http://doolittle.icarus.com/~larry/vhd2vl/) (some confusion as tp which is actually the _latest_) 

