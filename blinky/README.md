# ULX3S Examples

## FPGA Blinky

Note when programming the ULX3S in Windows, Lattice Diamond does not recognized the FT232 as a programmer, so `ujprog` is needed to send the bitfile. 

When using WSL, `ujprog` compiled as linux app will not work due to [lack of USB suppport](https://github.com/Microsoft/WSL/issues/2185#issuecomment-306083436). Instead, use the windows `ujprog.exe`  (callable from WSL). 

If not, `ujprog` will return a message about not being able to find the JTAG cable. 

```
ULX2S / ULX3S JTAG programmer v 3.0.92 (built Feb 28 2019 12:17:59)
Cannot find JTAG cable.
```

[Blinky in Lattice Diamond for Windows](./Diamond/README.md)

[Blinky using Open Source](./OpenSource/README.md)

See also [other examples](../README.md) and [ESP32 Blinky with Arduino IDE() and [Visual Micro Arduino IDE for Visual Studio](../VisualMicro/README.md)