
This FOSSi toolchain was developed to run under WSL Ubuntu, but should work on standard Ubuntu.

Instead of the close-source Lattice Diamond software, this toolchain allows building binary files for the ULX3S using completely open-source tools such as [yosys](https://github.com/cliffordwolf/yosys.git) and [nextpnr](https://github.com/YosysHQ/nextpnr#nextpnr-ecp5).

Adapted from [gojimmypi/ULXS3_WSL_Toolchain.sh](https://gist.github.com/gojimmypi/f96cd86b2b8595b4cf3be4baf493c5a7)


```
#!/bin/bash
WORKSPACE=~/workspace       # put your workspace parent directory here. avoid spaces in path
export ULX3S_COM=/dev/ttyS8  # put your device name here

# from https://gist.github.com/gojimmypi/f96cd86b2b8595b4cf3be4baf493c5a7

# This WSL Ubuntu bash script will update the system, fetch all dependencies, and git clone
# all of the libraries for running the @DoctorWkt Blinky for the ecp5 ULX3S Board
# including icestorm, nextpnr (or arachne-pnr), yosys
#
#
# A WSL-specific Makefile will also be fetched. (TODO)
#
# wget (TODO)/raw/Makefile -O Makefile
#
# or if you prefer the older arachne-pnr:
#
# wget (TODO)/raw/Makefile -O Makefile
#
# Works best with Ubuntu 18.04 or later
#
# if weird errors are detected after editing from something like Visual Studio in Windows, try running
#  dos2unix ./ULX3S_WSL_Toolchain.sh
#
#"***************************************************************************************************"
# To fetch and use this file:
#
#   wget https://gist.githubusercontent.com/gojimmypi/f96cd86b2b8595b4cf3be4baf493c5a7/raw/ULX3S_WSL_Toolchain.sh -O ULX3S_WSL_Toolchain.sh
#   chmod +x ./ULX3S_WSL_Toolchain.sh
#   ./ULX3S_WSL_Toolchain.sh
#
# To clone this gist:
#
#   cd $WORKSPACE
#   git clone https://gist.github.com/f96cd86b2b8595b4cf3be4baf493c5a7.git ULX3S_WSL_Toolchain
#   cd ULX3S_WSL_Toolchain
#
#"***************************************************************************************************"
STARTING_PATH=$(pwd)

# see https://unix.stackexchange.com/questions/14270/get-exit-status-of-process-thats-piped-to-another/73180#73180
# we don't want tee to capture exit codes
set -o pipefail

# convert entire list of params to single lower case string
params="$(tr [A-Z] [a-z] <<< "$@")"
# echo $params

LOG_SUFFIX=$(date +"%Y%m%d_%H%M%S")

# strip any path from $0 to get just the file name of this script, stripping any CR, LF, Tabs
THIS_FILE_NAME=$(basename $0 .sh | tr --delete '\t\r\n' )

mkdir -p "$WORKSPACE"
mkdir -p "$WORKSPACE/install_logs"
LOG_DIRECTORY="$WORKSPACE/install_logs"

#"***************************************************************************************************"
# CheckForError() function
#
# example: CheckForError $? mylog.1.txt mylog2.txt
#
# functions are a common place to get weird script errors. typically carriage returns. use dos2unix
#
# for cmake internal recipe errors, see: https://cmake.org/cmake/help/v3.9/command/execute_process.html
#
# note tee captures error code: https://stackoverflow.com/questions/1221833/pipe-output-and-capture-exit-status-in-bash
#"***************************************************************************************************"
CheckForError() { # $1 expected to be error code via $?
	if [ "$1" != "0" ]; then
		if [ "$2" != "" ]; then
			echo "---------------------------"
			echo "Looking in $2 for errors..."
			echo "---------------------------"
			grep -v " --disable-werror " "$2" | grep -B2 -i error
		fi
		if [ "$3" != "" ]; then
			echo "---------------------------"
			echo "Looking in $3 for errors..."
			echo "---------------------------"
			grep -v " --disable-werror " "$3" | grep -B2 -i error
		fi
		if [ "$4" != "" ]; then
			echo "---------------------------"
			echo "Looking in $4 for errors..."
			echo "---------------------------"
			grep -v " --disable-werror " "$4" | grep -B2 -i error
		fi
		if [ "$5" != "" ]; then
			echo "---------------------------"
			echo "Looking in $5 for errors..."
			echo "---------------------------"
			grep -v " --disable-werror " "$5" | grep -B2 -i error
		fi
		read -p "Error detected. Try updating dependencies. Press enter to continue, or Ctrl-C to abort."
	else
		echo "Ok! Exit code = [$1] using params=$params" 
	fi
}

#"***************************************************************************************************"
# CheckForGitFileChange() bash function. Compare hash of local file to one on GitHub
# 
# example: check specific file:
#   CheckForGitFileChange ~/workspace/nextpnr/README.md
#
# example: check this bash file:
#   CheckForGitFileChange $0    
#
# see https://gist.github.com/gojimmypi/22b7d43ce69e9c828e97534ff0a1d27f
#
#"***************************************************************************************************"
CheckForGitFileChange() {
	SAVED_CURRENT_PATH=$(pwd)
	if [ ! -f "$1" ]; then
		echo "File not found: "$1
		return 1
	fi

	## in case we get called from some other directory, we need to know the entire path of this file
	## as git commands need to be run in the repository directory.
	GIT_REL_PATH=$(dirname $1 | tr --delete '\t\r\n') 
	GIT_FULL_PATH="$(cd "${GIT_REL_PATH}"; pwd)"
	GIT_FILE_NAME=$(basename $1 | tr --delete '\t\r\n' )
	cd $GIT_FULL_PATH

	# compares occur to local files only, so quietly fetch
	git fetch > /dev/null

	# we first need to get the latest commit hash
	COMMIT_HASH=$(git show --format=%H --no-patch --no-abbrev-commit HEAD..origin/master)

	# view the file in the commit hash found and pipe to `git hash-object` to compute hash
	GIT_HASH=$(git show $COMMIT_HASH:$1 | git hash-object --stdin )

	# simple `git hash-object` to compute hash of the local file
	THIS_HASH=$(git hash-object $1)

	# some visual entertainment
	echo "COMMIT_HASH = $COMMIT_HASH"
	echo "GIT_HASH    = $GIT_HASH"
	echo "THIS_HASH   = $THIS_HASH"

	if [ "$THIS_HASH" == "$GIT_HASH" ]; then
		echo "Confirmed $1 is the most recent version found in GitHub."
	else 
		echo "Warning! This version of $1 does not match the most recent version in GitHub!"
		read -p "Press enter to continue, or Ctrl-C to abort. (manually push/pull recent file)"
	fi
	cd $SAVED_CURRENT_PATH
}

CheckForGitFileChange $0


if [ "$1" == "" ]; then
  echo ""
  echo "$0 --help for additional options."
  echo ""
  read -p "Press [Enter] to update all system dependencies, fetch latest github code, and rebuild everything..."
fi

if [[ "$params" == *"help"* ]] || [[ "$params" == *"--help"* ]] || [[ "$params" == *"-h"* ]];  then
  echo ""
  echo "$THIS_FILE_NAME help. Version 0.1"
  echo ""
  echo "If no parametes are selected, install and update everything."
  echo ""
  echo "If selection option is already installed, git fetch latest version and install."
  echo ""
  echo "Logs are saved to "$LOG_DIRECTORY"/"$THIS_FILE_NAME"_[step]_"$LOG_SUFFIX".log"
  echo "Edit WORKSPACE setting to fit your needs."
  echo ""
  echo "  --arachne-pnr  : install/update arachne-pnr"
  echo "  --blinky       : install/update ULX3S-Blinky"
  echo "  --help         : show this help screen"
  echo "  --icestorm     : install/update icestorm"
  echo "  --make         : make the current project"
  echo "  --nextpnr      : install/update nextpnr"
  echo "  --nosystem     : do not install requirements; do not perform apt-get update and apt-get upgrade"
  echo "  --prjtrellis   : install/update prjtrellis"
  echo "  --system       : install requirements; perform apt-get update and apt-get upgrade"
  echo "  --ujprog       : install/update ujprog"
  echo "  --version      : show versions of installed tools"
  echo "  --yosys        : install/update yosys"
  echo ""
fi

# for anything other than --help we will likely need to be sudo to install, so run once with the date to get started
if [ "$params" != "--help" ]; then
	sudo date # pause if copy/paste password prompt (otherwise text ends up in password prompt)
fi


# either explicitly updating with keyword "system" or no parameter at all, will update system
# a "nosystem" parameter will avoid updating the system libraries
if [[ "$1" != *"--nosystem"* ]]  && { [[ "$1" == *"--system"* ]] || [ "$1" == "" ]; } then
	cd "$WORKSPACE"
	THIS_LOG=$LOG_DIRECTORY"/"$THIS_FILE_NAME"_system_update_"$LOG_SUFFIX".log"

	echo "***************************************************************************************************"
	echo "update/upgrade current system. Saving log to $THIS_LOG"
	echo "***************************************************************************************************"
	sudo apt-get update --assume-yes        | tee -a "$THIS_LOG"
	sudo apt-get upgrade --assume-yes       | tee -a "$THIS_LOG"

	echo "***************************************************************************************************"
	echo "git install and config. Saving log to $THIS_LOG"
	echo "***************************************************************************************************"
	# These git .insteadOf options may not be needed if your firewall does not blocks the git ports, 
	# but we set anyhow. 
	#
	# it is unlikely to cause harm for these repositories, unless for some reason your firewall is blocking HTTPS
	sudo apt-get install git --assume-yes   | tee -a "$THIS_LOG"

	# git config --global url.https://git.qemu.org/git/.insteadOf git://git.qemu-project.org/
	# git config --global url.https://anongit.freedesktop.org/git/.insteadOf git://anongit.freedesktop.org/

	# git config --global url.https://github.com/riscv.insteadOf git://github.com/riscv

	# also consider somerthing like this for everything on GitHub:
	# git config --global url.https://github.com/.insteadOf git://github.com/
	#
	# and to clear:
	# git config --global --unset url.https://github.com/.insteadOf

	echo "***************************************************************************************************"
	echo " install x11 dependencies (only needed for WSL?)"
	echo "***************************************************************************************************"
	sudo apt install dbus-x11

	cd "$WORKSPACE"
	echo "***************************************************************************************************"
	echo "install icestorm dependencies. Saving log to $THIS_LOG"
	echo "***************************************************************************************************"
	# this next install needs a bit of disk space:
	#   0 upgraded, 205 newly installed, 0 to remove and 3 not upgraded.
	#   Need to get 130 MB of archives.
	#   After this operation, 652 MB of additional disk space will be used.
	#
	sudo apt-get install build-essential clang bison flex libreadline-dev \
						 gawk tcl-dev libffi-dev git mercurial graphviz   \
						 xdot pkg-config python python3 libftdi-dev --assume-yes | tee -a "$THIS_LOG"
	CheckForError $? "$THIS_LOG"

	echo "***************************************************************************************************"
	echo "install nextpnr dependencies. Saving log to $THIS_LOG"
	echo "***************************************************************************************************"
	# this next line is about another half gig of files!
	#   0 upgraded, 249 newly installed, 0 to remove and 3 not upgraded.
	#   Need to get 132 MB of archives.
	#   After this operation, 623 MB of additional disk space will be used.
	#
	sudo apt-get install libboost-all-dev python3-dev qt5-default clang-format libeigen3-dev --assume-yes | tee -a "$THIS_LOG"
	sudo apt-get install cmake --assume-yes | tee -a "$THIS_LOG"
	CheckForError $? "$THIS_LOG"

	echo "***************************************************************************************************"
	echo "install verilator. Saving log to $THIS_LOG"
	echo "***************************************************************************************************"
	# The following NEW packages will be installed:
	#  verilator
	# 0 upgraded, 1 newly installed, 0 to remove and 1 not upgraded.
	# Need to get 2878 kB of archives.
	# After this operation, 13.1 MB of additional disk space will be used.
	sudo apt-get install verilator   | tee -a "$THIS_LOG"
	CheckForError $? "$THIS_LOG"

	if grep -q Microsoft /proc/version; then
	  echo "***************************************************************************************************"
	  echo "WSL detected; Install x86_64-w64-mingw32-gcc; Saving log to $THIS_LOG"
	  echo "***************************************************************************************************"
	  sudo apt-get install mingw-w64 | tee -a "$THIS_LOG"
	  CheckForError $? "$THIS_LOG"
	fi

	echo "***************************************************************************************************"
	echo "update/upgrade current system again. Saving log to $THIS_LOG"
	echo "***************************************************************************************************"
	sudo apt-get update --assume-yes        | tee -a "$THIS_LOG"
	CheckForError $? "$THIS_LOG"

	sudo apt-get upgrade --assume-yes       | tee -a "$THIS_LOG"
	CheckForError $? "$THIS_LOG"
fi


if [[ "$1" == *"--blinky"* ]] || [ "$1" == "" ]; then
	cd "$WORKSPACE"
	THIS_LOG=$LOG_DIRECTORY"/"$THIS_FILE_NAME"_blinky_"$LOG_SUFFIX".log"

	echo "***************************************************************************************************"
	echo "@DoctorWkt ULX3S-Blinky. Saving log to $THIS_LOG"
	echo "***************************************************************************************************"
	if [ ! -d "$WORKSPACE"/ULX3S-Blinky ]; then
	  git clone --recursive https://github.com/DoctorWkt/ULX3S-Blinky | tee -a "$THIS_LOG"
	  cd ULX3S-Blinky
	else
	  cd ULX3S-Blinky
	  git fetch                                                       | tee -a "$THIS_LOG"
	  git pull                                                        | tee -a "$THIS_LOG"
	fi
fi

sudo apio drivers --serial-enable
sudo usermod -a -G dialout $USER


if [[ "$1" == *"--icestorm"* ]] || [ "$1" == "" ]; then
	cd "$WORKSPACE"
	THIS_LOG=$LOG_DIRECTORY"/"$THIS_FILE_NAME"_icestorm_"$LOG_SUFFIX".log"

	echo "***************************************************************************************************"
	echo " icestorm. Saving log to: "$THIS_LOG
	echo "***************************************************************************************************"

	# see http://www.clifford.at/icestorm/
	if [ ! -d "$WORKSPACE"/icestorm ]; then
	  git clone https://github.com/cliffordwolf/icestorm.git icestorm | tee -a "$THIS_LOG"
	  cd icestorm
	else
	  cd icestorm
	  git fetch                                                       | tee -a "$THIS_LOG"
	  git pull                                                        | tee -a "$THIS_LOG"
	  make clean                                                      | tee -a "$THIS_LOG"
	  CheckForError $? "$THIS_LOG"
	fi

	make -j$(nproc)                                                   | tee -a "$THIS_LOG"
	CheckForError $? "$THIS_LOG"

	sudo make install                                                 | tee -a "$THIS_LOG"
	CheckForError $? "$THIS_LOG"
fi


if [[ "$1" == *"--arachne-pnr"* ]] || [ "$1" == "" ]; then
	cd "$WORKSPACE"
	THIS_LOG=$LOG_DIRECTORY"/"$THIS_FILE_NAME"_arachne-pnr_"$LOG_SUFFIX".log"

	echo "***************************************************************************************************"
	echo " arachne-pnr. Saving log to $THIS_LOG"
	echo "***************************************************************************************************"
	if [ ! -d "$WORKSPACE"/arachne-pnr ]; then
	  git clone https://github.com/cseed/arachne-pnr.git arachne-pnr | tee -a "$THIS_LOG"
	  cd arachne-pnr
	else
	  cd arachne-pnr
	  git fetch                                                      | tee -a "$THIS_LOG" 
	  git pull                                                       | tee -a "$THIS_LOG"

	  make clean                                                     | tee -a "$THIS_LOG" 
	  CheckForError $? "$THIS_LOG"
	fi

	make -j$(nproc)                                                  | tee -a "$THIS_LOG"
	CheckForError $? "$THIS_LOG"

	sudo make install                                                | tee -a "$THIS_LOG"
	CheckForError $? "$THIS_LOG"
fi

if [[ "$1" == *"--prjtrellis"* ]] || [ "$1" == "" ]; then
	cd "$WORKSPACE"
	THIS_LOG=$LOG_DIRECTORY"/"$THIS_FILE_NAME"_prjtrellis_"$LOG_SUFFIX".log"

	echo "***************************************************************************************************"
	echo " prjtrellis (required for nextpnr-ecp5). Saving log to $THIS_LOG"
	echo "***************************************************************************************************"
	if [ ! -d "$WORKSPACE"/prjtrellis ]; then
	  git clone --recursive https://github.com/SymbiFlow/prjtrellis
	  cd prjtrellis
	else
	  cd prjtrellis
	  git fetch                                                      | tee -a "$THIS_LOG"
	  git pull                                                       | tee -a "$THIS_LOG"

	fi

	# cmake must run from the libtrellis directory
	cd libtrellis
	make clean                                                       | tee -a "$THIS_LOG"
	CheckForError $? "$THIS_LOG"

	cmake -DCMAKE_INSTALL_PREFIX=/usr .                              | tee -a "$THIS_LOG"
	CheckForError $? "$THIS_LOG"

	make                                                             | tee -a "$THIS_LOG"
	CheckForError $? "$THIS_LOG"

	sudo make install                                                | tee -a "$THIS_LOG"
	CheckForError $? "$THIS_LOG"
fi


if [[ "$1" == *"--nextpnr"* ]] || [ "$1" == "" ]; then
	cd "$WORKSPACE"
	THIS_LOG=$LOG_DIRECTORY"/"$THIS_FILE_NAME"_nextpnr_"$LOG_SUFFIX".log"

	echo "***************************************************************************************************"
	echo " nextpnr-ecp5. Saving log to $THIS_LOG"
	echo "***************************************************************************************************"
	# see https://github.com/YosysHQ/nextpnr#nextpnr-ecp5
	if [ ! -d "$WORKSPACE"/nextpnr ]; then
	  git clone https://github.com/YosysHQ/nextpnr.git               | tee -a "$THIS_LOG"
	  cd nextpnr
	else
	  cd nextpnr
	  git fetch                                                      | tee -a "$THIS_LOG"
	  git pull                                                       | tee -a "$THIS_LOG"

	  make clean                                                     | tee -a "$THIS_LOG"
	  CheckForError $? "$THIS_LOG" "./CMakeFiles/CMakeOutput.log" "./CMakeFiles/CMakeError.log"
	fi

		# Note the "=/path/to/prjtrellis" value is the install directory, not git workspace clone directory
	# If CMake fails, try rm CMakeCache.txt
	cmake -DARCH=ecp5 -DTRELLIS_ROOT=/usr/share/trellis/ .           | tee -a "$THIS_LOG"
	CheckForError $? "./CMakeFiles/CMakeOutput.log" "./CMakeFiles/CMakeError.log"

	make -j$(nproc)                                                  | tee -a "$THIS_LOG"
	CheckForError $? "./CMakeFiles/CMakeOutput.log" "./CMakeFiles/CMakeError.log"

	sudo make install                                                | tee -a "$THIS_LOG"
	CheckForError $? 

fi


if [[ "$1" == *"--yosys"* ]] || [ "$1" == "" ]; then
	cd "$WORKSPACE"
	THIS_LOG=$LOG_DIRECTORY"/"$THIS_FILE_NAME"_yosys_"$LOG_SUFFIX".log"

	echo "***************************************************************************************************"
	echo " yosys. Saving log to $THIS_LOG"
	echo "***************************************************************************************************"
	# see http://www.clifford.at/yosys/
	if [ ! -d "$WORKSPACE"/yosys ]; then
	  git clone https://github.com/cliffordwolf/yosys.git yosys      | tee -a "$THIS_LOG"
	  cd yosys
	else
	  cd yosys
	  git fetch                                                      | tee -a "$THIS_LOG"
	  git pull                                                       | tee -a "$THIS_LOG" 

	  make clean                                                     | tee -a "$THIS_LOG"
	  CheckForError $? "$THIS_LOG"
	fi

	make -j$(nproc)                                                  | tee -a "$THIS_LOG"
	CheckForError $? "$THIS_LOG"

	sudo make install                                                | tee -a "$THIS_LOG"
	CheckForError $? "$THIS_LOG"
fi


if [[ "$1" == *"--ujprog"* ]] || [ "$1" == "" ]; then
	cd "$WORKSPACE"
	THIS_LOG=$LOG_DIRECTORY"/"$THIS_FILE_NAME"_ujprog_"$LOG_SUFFIX".log"

	echo "***************************************************************************************************"
	echo " ujprog. Saving log to $THIS_LOG"
	echo "***************************************************************************************************"
	# see https://github.com/f32c/tools/tree/master/ujprog
	# NOTE: Although this successfully compiles, it does not seem to work in WSL (not USB device support)
	if [ ! -d "$WORKSPACE"/f32c_tools ]; then
	  git clone https://github.com/f32c/tools.git f32c_tools         | tee -a "$THIS_LOG"
	  cd f32c_tools/ujprog
	else
	  cd f32c_tools
	  git fetch                                                      | tee -a "$THIS_LOG"
	  git pull                                                       | tee -a "$THIS_LOG"
	  cd f32c_tools/ujprog

	  make clean                                                     | tee -a "$THIS_LOG"
	  CheckForError $? "$THIS_LOG"
	fi

	# There's no point to making the linux version of ujprog in WSL, as native USB devices are not supported.
	# but we can compile the Windows version, amd actually call it from WSL (call from /mnt/c... not ~/...)
	if grep -q Microsoft /proc/version; then
	  THIS_LOG=$LOG_DIRECTORY"/"$THIS_FILE_NAME"_ming32_64_"$LOG_SUFFIX".log"
	  cd "$WORKSPACE"

	  echo "***************************************************************************************************"
	  echo " ming32_64. Saving log to $THIS_LOG"
	  echo "***************************************************************************************************"

	  make -f Makefile.ming32_64                                     | tee -a "$THIS_LOG"
	  CheckForError $? "$THIS_LOG"

	  sudo make -f Makefile.ming32_64 install                        | tee -a "$THIS_LOG"
	  CheckForError $? "$THIS_LOG"
	else
	  make -f Makefile.linux                                         | tee -a "$THIS_LOG"
	  CheckForError $? "$THIS_LOG"

	  sudo make -f Makefile.linux install                            | tee -a "$THIS_LOG"
	  CheckForError $? "$THIS_LOG"
	fi
fi


if [[ "$1" == *"--version"* ]] || [ "$1" == "" ]; then
	cd "$WORKSPACE"
	THIS_LOG=$LOG_DIRECTORY"/"$THIS_FILE_NAME"_version_"$LOG_SUFFIX".log"

	echo "***************************************************************************************************"
	echo " show versions installed. Saving log to $THIS_LOG"
	echo "***************************************************************************************************"
	lsb_release -a                                                              | tee -a "$THIS_LOG"
	python --version                                                            | tee -a "$THIS_LOG"
	python3.5 --version                                                         | tee -a "$THIS_LOG"
	cmake --version                                                             | tee -a "$THIS_LOG"
	clang --version                                                             | tee -a "$THIS_LOG"
	echo qtf_default $(apt-cache show qt5-default | grep -m1 Version)           | tee -a "$THIS_LOG"
	echo libboost-all-dev $(apt-cache show libboost-all-dev | grep -m1 Version) | tee -a "$THIS_LOG"

	for pk in build-essential clang bison flex libreadline-dev \
			  gawk tcl-dev libffi-dev git mercurial graphviz   \
			  xdot pkg-config python python3 libftdi-dev \
			  qt5-default python3-dev libboost-dev; \
	  do echo "$pk" $(apt-cache show "$pk" | grep -m1 Version | tee -a "$THIS_LOG");  done

	nextpnr-ecp5 --version                                                      | tee -a "$THIS_LOG"
	yosys -V                                                                    | tee -a "$THIS_LOG"
fi



if [[ "$1" == *"--make"* ]] || [ "$1" == "" ]; then
	cd "$WORKSPACE"
	THIS_LOG=$LOG_DIRECTORY"/"$THIS_FILE_NAME"_make_"$LOG_SUFFIX".log"

	echo "***************************************************************************************************"
	echo "  build the ULX3S-Blinky. Saving log to $THIS_LOG"
	echo "***************************************************************************************************"
	# See https://github.com/DoctorWkt/ULX3S-Blinky

	cd ULX3S-Blinky


	# Get our WSL-specific Makefile
	# wget (todo)/raw/Makefile -O Makefile

	make clean

	read -p "Press [Enter] to program ULX3S"

	make prog

	date
fi

echo ""
echo "Done!"
if [ "$params" != "--help" ]; then
	echo "See log files in:" $LOG_DIRECTORY
	ls $LOG_DIRECTORY | grep -x $THIS_FILE_NAME".*"$LOG_SUFFIX".log"
fi
cd $STARTING_PATH
```