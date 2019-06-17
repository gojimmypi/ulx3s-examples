# Open Source FPGA passthru

The [passthru.vhd](../Diamond/passthru.vhd) VHDL file in the [Diamond for Windows passthru (VHDL)](../Diamond/README.md) was converted to Verilog using @ldoolitt's [VHDL to Verilog](https://github.com/ldoolitt/vhd2vl) converter.

This is the not-yet-working version. TODO: why? This is the same Verilog and constraint file as in the DiamondVerilog example.


#Make for WSL

Assuming the repo was cloned to `C:\workspace\`, in WSL, ensure the [Open Source Toolchain](../../OpenSource-toolchain/README.md) is installed, then:

```
cd /mnt/c/workspace/ulx3s-examples/passthru/OpenSource

make wslprog -f Makefile.12F
```
This should result in a output something like this:

```
../../bin/ujprog.exe ulx3s.bit
Programming: 99% | ULX2S / ULX3S JTAG programmer v 3.0.92 (built Feb 18 2019 10:55:47)
Using USB cable: ULX3S FPGA 12K v3.0.3
Programming: 100%
Completed in 17.36 seconds.
```


# Make for Linux
```
gojimmypi:/mnt/c/workspace/ulx3s-examples/passthru/OpenSource
$ make prog -f Makefile.12F
nextpnr-ecp5 --25k --json passthru.json  \
        --lpf ulx3s_v20.lpf \
        --textcfg ulx3s_out.config
Info: Importing module passthru
Info: Rule checker, verifying imported design
Info: Checksum: 0x06b9ae23

Info: Annotating ports with timing budgets for target frequency 12.00 MHz
ERROR: cell type '$_DFFSR_PPP_' is unsupported (instantiated as '$auto$simplemap.cc:467:simplemap_dffsr$300')
1 warning, 1 error
Makefile.12F:74: recipe for target 'ulx3s_out.config' failed
make: *** [ulx3s_out.config] Error 255
```

Note that an error such as:

```
ERROR: cell type '$_DFFSR_PPP_' is unsupported (instantiated as '$auto$simplemap.cc:467:simplemap_dffsr$300')
```

means:

_Sounds like you have both an async set and reset, which isn't supported because it doesn't map to ECP5 registers
you can't asynchronously load a value_ 
-- @@daveshah1


See [Diamond PassThru](../Diamond/README.md)

See also [other examples](../../README.md)