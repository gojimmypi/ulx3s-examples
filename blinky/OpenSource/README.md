# ULX3S Examples - Open Source Blinky

This blinky is based on the [ULX3S-Blinky project](https://github.com/DoctorWkt/ULX3S-Blinky) from @Doctorwkt. This example blinks an LED using FPGA code.

It is assumed the yosys, nextpnr toolchain has been already installed. If not, see [instructions here](../../OpenSource-toolchain/README.md)

Optionally copy a fresh [ulx3s_v20.lpf constraint file](../../doc/constraints/ulx3s_v20.lpf).

```
# assume git clone to ~/workspace/
cd ~/workspace/ulx3s-examples/blinky/OpenSource
cp -f ../../doc/constraints/ulx3s_v20.lpf ./ # optionally copy an updated lpf file
```

On linux, the regular `ujprog` can be used:

```
make clean
make ulx3s.bit
../../bin/ujprog ulx3s.bit
```

For Windows WSL, there is [no USB support](https://github.com/Microsoft/WSL/issues/2185#issuecomment-306083436) so the linux `ujprog` will not work, but the Windows executable `ujprog.exe` can be used.

It is important to note that `fujprog.exe` should only be executed from a non-VoIFS directory in WSL (e.g. /mnt/c/somedirectory...) see [ujprog troubleshooting](https://github.com/f32c/tools/tree/master/ujprog#troubleshooting) and the discussion [here](https://github.com/f32c/tools/pull/9#issuecomment-465693978).

```
# assume git clone to C:\workspace\
# Note ujprog.exe does NOT work when launching from WSL VoIFS, so we move to a DOS directory (/mnt/c/....)
cd /mnt/c/workspace/ulx3s-examples/blinky/OpenSource
make clean
make ulx3s.bit
../../bin/fujprog.exe ulx3s.bit
```

for the 12F on WSL:

```
# assume git clone to C:\workspace\
# Note fujprog.exe does NOT work when launching from WSL VoIFS, so we move to a DOS directory (/mnt/c/....)
cd /mnt/c/workspace/ulx3s-examples/blinky/OpenSource
make clean
make ulx3s.bit -f Makefile.12F
../../bin/fujprog.exe ulx3s.bit
```

See also [other examples](../../README.md)
