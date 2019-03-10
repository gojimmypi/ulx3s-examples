# ULX3S Examples

Getting started with the [ULX3S](https://radiona.org/ulx3s/) is easy! You just need a Verilog source code file and the [constraint file](./doc/constraints/ulx3s_v20.lpf). 

To program the FPGA on the ULX3S, either the commercial [Lattice Diamond](http://www.latticesemi.com/latticediamond) or Open Source tools such as [yosys](https://github.com/YosysHQ/yosys), [nextpnr](https://github.com/YosysHQ/nextpnr) and  [ujprog](https://github.com/f32c/tools/tree/master/ujprog) are needed.

If you've never worked with FPGA devices, they are programmed with a _hardware definition_ language or "HDL", that may look like a traditional programming language - however it is quite different. The "code" is really just a clever shorthand for how circuits and logic gates are connected. Verilog is one type of HDL. 

You can learn more at sites such as [fpga4fun](http://www.fpga4fun.com/), [asic-world digital logic](http://www.asic-world.com/digital/tutorial.html), [asic-world verilog](http://www.asic-world.com/verilog/veritut.html) and [nandland](https://www.nandland.com/verilog/tutorials/index.html).

Once you have your circuit logic generically defined properly in a Verilog file, the hardware-specific constraint file is used to connect the inputs and outputs of the Verilog code to physical pins on the FPGA device.

Here is a collection of various ulx3s examples to get started:

* [ESP 32 Blinky](./blinky/ESP32/README.md)

* [FPGA Blinky in Lattice Diamond for Windows](./blinky/Diamond/README.md)

* [FPGA Blinky using Open Source](./blinky/OpenSource/README.md)

* [PassThru in Lattice Diamond for Windows](./passthru/Diamond/README.md)

* [PassThru using Open Source](./passthru/OpenSource/README.md)

* [More links to RadionaOrg ULX3S examples](https://github.com/RadionaOrg/ulx3s-links/blob/master/README.md) 

See also: [binaries](./bin/README.md), [hardware](https://github.com/emard/ulx3s), [f32c/tools/ujprog](https://github.com/f32c/tools/tree/master/ujprog)


