# ULX3S examples/bin

UPDATE: `ujprog` is deprecated for the ULX3S and has been included only for historical / legacy reference. Please be sure to use [fujprog](https://github.com/kost/fujprog) for all new applications.

`ujprog` - compiled for x86 linux (see [f32c/tools/ujprog](https://github.com/f32c/tools/tree/master/ujprog))

Note: The linux-compiled `ujprog` does not work in WSL as native [USB drivers are not supported](https://github.com/Microsoft/WSL/issues/2185#issuecomment-306083436) at this time. See [#3185](https://github.com/Microsoft/WSL/issues/3185) [#1521](https://github.com/Microsoft/WSL/issues/1521) [#2287](https://github.com/Microsoft/WSL/issues/2287) [#2195](https://github.com/Microsoft/WSL/issues/2195) [#2185](https://github.com/Microsoft/WSL/issues/2185) [#412](https://github.com/Microsoft/WSL/issues/412) however the `ujporg.exe` can be called in WSL.

`ujprog.exe` - compiled for Windows / WSL

`passthru_implementation_12F.bit` - prebuilt 12F passthru (see [PassThru example](../passthru/README.md) )

To get started quickly, see the [upload_passthru.sh](./upload_passthru.sh) to upload the FPGA passthru code and [ESP32/upload_blinky.sh](./ESP32/upload_blinky.sh) for the ESP32 blinky.

For other binaries see [https://github.com/emard/ulx3s-bin](https://github.com/emard/ulx3s-bin)

## Diamond Verilog Fresh Build

Run this command from this local `./bin/` directory in WSL for load fresh [Diamond Verilog Passthru](../passthru/DiamondVerilog/README.md).
Note the file is copied local due to `ujprog` having issues with a long path:

```
cp /mnt/c/workspace/ulx3s-examples/passthru/DiamondVerilog/implementation/passthru_implementation.bit ./DiamondVerilog_passthru.bit
./fujprog.exe ./DiamondVerilog_passthru.bit
```


## Troubleshooting

### ESP32 Disply blank after loading FPGA bitfile with ujprog

This is a known problem. Reload ESP32 app if FPGA code is not saved to flash (as otherwise FPGA code is lost during power cycle)

###  $'\r': command not found

If this error is encountered:

```
$ ./upload_passthru.sh
./upload_passthru.sh: line 9: $'\r': command not found
./upload_passthru.sh: line 12: $'\r': command not found
./upload_passthru.sh: line 22: syntax error: unexpected end of file
```
This means the file was improperly terminated with CR/LF characters when saving in Visual Studio. To fix, use the `dos2unix` utility:

```
$ dos2unix ./upload_passthru.sh
dos2unix: converting file ./upload_passthru.sh to Unix format...
```

### Path too long for ujprog

When the path paramter to `ujprog` is too long:
```
Using USB cable: ULX3S FPGA 12K v3.0.3
open(/mnt/c/workspace/ulx3s-examples/passthru/DiamondVerilog/implementation/passthru_implementation.bit) failed

Failed.
```

See also [other examples](../README.md)
