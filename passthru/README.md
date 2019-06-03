# FPGA passthru 

FPGA passthru app allowing programming of the ESP32. 

As shown in the [schematics](../doc/schematics.pdf) (page 7), the ESP32 pins are not directly accessible, and need an FPGA signal PassThru to be loaded.

![ESP32-on-ULX3S](./images/ESP32-on-ULX3S.PNG )

[VHDL PassThru in Lattice Diamond for Windows](./Diamond/README.md)

[Verilog PassThru in Lattice Diamond for Windows](./Diamond/README.md)

[PassThru using Open Source](./OpenSource/README.md)

## Quick Start FPGA passthru
See [bin/upload_passthru.sh](../bin/upload_passthru.sh) or  [bin/upload_passthru.bat](../bin/upload_passthru.bat)

For additional passthru info, see https://github.com/emard/ulx3s-passthru
