# ULX3S Examples

Getting started with the [ULX3S](https://radiona.org/ulx3s/) is easy! You just need a Verilog source code file and the [constraint file](./doc/constraints/ulx3s_v20.lpf). 

To program the FPGA on the ULX3S, either the commercial [Lattice Diamond](http://www.latticesemi.com/latticediamond) or Open Source tools such as [yosys](https://github.com/YosysHQ/yosys), [nextpnr](https://github.com/YosysHQ/nextpnr) and  [ujprog](https://github.com/f32c/tools/tree/master/ujprog) are needed.

If you've never worked with FPGA devices, they are programmed with a _hardware definition_ language or "HDL", that may look like a traditional programming language - however it is quite different. The "code" is really just a clever shorthand for how circuits and logic gates are connected. Verilog is one type of HDL. 

You can learn more at sites such as [fpga4fun](http://www.fpga4fun.com/), [asic-world digital logic](http://www.asic-world.com/digital/tutorial.html), [asic-world verilog](http://www.asic-world.com/verilog/veritut.html) and [nandland](https://www.nandland.com/verilog/tutorials/index.html).

Once you have your circuit logic generically defined properly in a Verilog file, the hardware-specific constraint file is used to connect the inputs and outputs of the Verilog code to physical pins on the FPGA device.

Here is a collection of various ULX3S examples to get started:

* [ESP 32 Blinky](./blinky/ESP32/README.md)

* [FPGA Blinky in Lattice Diamond for Windows](./blinky/Diamond/README.md)

* [FPGA Blinky using Open Source](./blinky/OpenSource/README.md)

* [FPGA PassThru QuickStart](./passthru/README.md#quick-start-fpga-passthru)

* [PassThru in Lattice Diamond for Windows](./passthru/Diamond/README.md)

* [PassThru using Open Source](./passthru/OpenSource/README.md)

* [Using Visual Micro to program the ESP32](./VisualMicro/README.md)

* [MicroPython on the ULX3S ESP32](./MicroPython/README.md)

* [More links to RadionaOrg ULX3S examples](https://github.com/RadionaOrg/ulx3s-links/blob/master/README.md) 

# See also: 

[binaries](./bin/README.md), [hardware](https://github.com/emard/ulx3s), [f32c/tools/ujprog](https://github.com/f32c/tools/tree/master/ujprog)

* https://github.com/goran-mahovlic/fpga-odysseus/tree/master/tutorials/04-Video

* https://github.com/albertxie/iverilog-tutorial/blob/master/code_samples/simple_tb.v

* https://github.com/mmicko/cross-fpga

* https://github.com/jhol/otl-modem/blob/master/fw/syn/top.v

* http://www.clifford.at/icestorm/

* [Windows Subsystem for Linux (WSL): what can't I do with the Ubuntu application for Microsoft Windows?](https://askubuntu.com/questions/1051525/windows-subsystem-for-linux-wsl-what-cant-i-do-with-the-ubuntu-application-f)