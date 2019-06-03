# Diamond for Windows passthru (Verilog)

The [passthru.vhd](../Diamond/passthru.vhd) VHDL file in the [Diamond for Windows passthru (VHDL)](../Diamond/README.md) was converted to Verilog using @ldoolitt's [VHDL to Verilog](https://github.com/ldoolitt/vhd2vl) converter.


To program in WSL, assuming `git clone` from `c:\workspace`:

```
cd /mnt/c/workspace/ulx3s-examples/passthru/DiamondVerilog/implementation
/mnt/c/workspace/ulx3s-examples/bin/ujprog.exe passthru_implementation.bit
```

Note: The linux-compiled `ujprog` does not work in WSL as [native USB drivers are not supported](https://github.com/Microsoft/WSL/issues/2185#issuecomment-306083436) at this time. See [#3185](https://github.com/Microsoft/WSL/issues/3185) [#1521](https://github.com/Microsoft/WSL/issues/1521) [#2287](https://github.com/Microsoft/WSL/issues/2287) [#2195](https://github.com/Microsoft/WSL/issues/2195) [#2185](https://github.com/Microsoft/WSL/issues/2185) [#412](https://github.com/Microsoft/WSL/issues/412)

or from DOS:

```
c:
cd \workspace\ulx3s-examples\passthru\DiamondVerilog\implementation
c:\workspace\ulx3s-examples\bin\ujprog.exe passthru_implementation.bit
```

Note that a long path for parameter does not seem to work at this time:

```
$ cd ~/
gojimmypi:~
$ ls /mnt/c/workspace/ulx3s-examples/passthru/DiamondVerilog/implementation/passthru_implementation.bit -al
-rwxrwxrwx 1 gojimmypi gojimmypi 100441 Mar  3 10:02 /mnt/c/workspace/ulx3s-examples/passthru/DiamondVerilog/implementation/passthru_implementation.bit
gojimmypi:~
$ /mnt/c/workspace/ulx3s-examples/bin/ujprog.exe /mnt/c/workspace/ulx3s-examples/passthru/DiamondVerilog/implementation/passthru_implementation.bit
ULX2S / ULX3S JTAG programmer v 3.0.92 (built Feb 18 2019 10:55:47)
Using USB cable: ULX3S FPGA 12K v3.0.3
open(/mnt/c/workspace/ulx3s-examples/passthru/DiamondVerilog/implementation/passthru_implementation.bit) failed

Failed.
```


See also [other examples](../../README.md), as well as the [VHDL Passthru](../DiamondVerilog/README.md)
