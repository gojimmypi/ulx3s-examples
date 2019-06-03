
This FOSSi toolchain was developed to run under WSL Ubuntu, but should work on standard Ubuntu.

Instead of the close-source Lattice Diamond software, this toolchain allows building binary files for the ULX3S using completely open-source tools such as [yosys](https://github.com/cliffordwolf/yosys.git) and [nextpnr](https://github.com/YosysHQ/nextpnr#nextpnr-ecp5).

Adapted from [gojimmypi/ULXS3_WSL_Toolchain.sh](https://gist.github.com/gojimmypi/f96cd86b2b8595b4cf3be4baf493c5a7)

See the [ULX3S_WSL_Toolchain](./ULX3S_WSL_Toolchain) directory for [ULX3S_WSL_Toolchain.sh](./ULX3S_WSL_Toolchain/ULX3S_WSL_Toolchain.sh)

```
git clone https://gist.github.com/f96cd86b2b8595b4cf3be4baf493c5a7.git ULX3S_WSL_Toolchain
```

from the `ULX3S_WSL_Toolchain` directory:

```
./ULX3S_WSL_Toolchain.sh --help
```


```
COMMIT_HASH =
GIT_HASH    = 425f183d2b217d170f633e471ab5cb77de56ec17
THIS_HASH   = 425f183d2b217d170f633e471ab5cb77de56ec17
Confirmed ./ULX3S_WSL_Toolchain.sh is the most recent version found in GitHub.

ULX3S_WSL_Toolchain help. Version 0.1

If no parametes are selected, install and update everything.

If selection option is already installed, git fetch latest version and install.

Logs are saved to /home/gojimmypi/workspace/install_logs/ULX3S_WSL_Toolchain_[step]_20190602_182848.log
Edit WORKSPACE setting to fit your needs.

  --arachne-pnr  : install/update arachne-pnr
  --blinky       : install/update ULX3S-Blinky
  --help         : show this help screen
  --icestorm     : install/update icestorm
  --make         : make the current project
  --nextpnr      : install/update nextpnr
  --nosystem     : do not install requirements; do not perform apt-get update and apt-get upgrade
  --prjtrellis   : install/update prjtrellis
  --system       : install requirements; perform apt-get update and apt-get upgrade
  --ujprog       : install/update ujprog
  --version      : show versions of installed tools
  --yosys        : install/update yosys```