# Open Source FPGA passthru

The [passthru.vhd](../Diamond/passthru.vhd) VHDL file in the [Diamond for Windows passthru (VHDL)](../Diamond/README.md) was converted to Verilog using @ldoolitt's [VHDL to Verilog](https://github.com/ldoolitt/vhd2vl) converter.

This is the not-yet-working version.

```
gojimmypi:/mnt/c/workspace/ulx3s-examples/passthru/OpenSource
$ make prog -f Makefile.12F
nextpnr-ecp5 --25k --json passthru.json  \
        --lpf ulx3s_v20.lpf \
        --textcfg ulx3s_out.config
Info: Importing module passthru
Info: Rule checker, verifying imported design
Info: Checksum: 0x06b9ae23

Info: constraining clock net 'clk_25MHz' to 25.00 MHz
SYSCONFIG CONFIG_IOVOLTAGE=3.3 COMPRESS_CONFIG=ON MCCLK_FREQ=62 MASTER_SPI_PORT=ENABLE SLAVE_SPI_PORT=DISABLE SLAVE_PARALLEL_PORT=DISABLE' (on line 12)
ERROR: IO 'ftdi_ndsr' is unconstrained in LPF (override this error with --lpf-allow-unconstrained)
1 warning, 1 error
Makefile.12F:74: recipe for target 'ulx3s_out.config' failed
make: *** [ulx3s_out.config] Error 255
```

See [Diamond PassThru](../Diamond/README.md)

See also [other examples](../../README.md)