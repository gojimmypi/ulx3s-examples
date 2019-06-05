PROJ = fpga-spi
TOP_MOD_FILE = spi_driver
PIN_DEF = ulx3s_v20.lpf
DEVICE = up5k
LUT_SIZE = 25k

ARACHNE = arachne-pnr 
ARACHNE_ARGS = 
# ICEPACK = ecppack
# ICEPACK = icepack
ICETIME = icetime
ICEPROG = ../f32c_tools/ujprog/ujprog.exe
IS_WSL = 0  


# Verilator

TOPMOD  := SPI_driver
VLOGFIL := $(TOPMOD).v
VCDFILE := $(TOPMOD).vcd
SIMPROG := $(TOPMOD)_tb
RPTFILE := $(TOPMOD).rpt
BINFILE := $(TOPMOD).bin
SIMFILE := $(SIMPROG).cpp
VDIRFB  := ./obj_dir
#COSIMS  := uartsim.cpp

SHELL=bash


all: $(VCDFILE)

GCC := g++
CFLAGS = -g -Wall -I$(VINC) -I $(VDIRFB)
#
# Modern versions of Verilator and C++ may require an -faligned-new flag
# CFLAGS = -g -Wall -faligned-new -I$(VINC) -I $(VDIRFB)

VERILATOR=verilator
VFLAGS := -O3 -MMD --trace -Wall

## Find the directory containing the Verilog sources.  This is given from
## calling: "verilator -V" and finding the VERILATOR_ROOT output line from
## within it.  From this VERILATOR_ROOT value, we can find all the components
## we need here--in particular, the verilator include directory
VERILATOR_ROOT ?= $(shell bash -c '$(VERILATOR) -V|grep VERILATOR_ROOT | head -1 | sed -e "s/^.*=\s*//"')
##
## The directory containing the verilator includes
VINC := $(VERILATOR_ROOT)/include

$(VDIRFB)/V$(TOPMOD).cpp: $(TOPMOD).v
	$(VERILATOR) $(VFLAGS) -cc $(VLOGFIL)

$(VDIRFB)/V$(TOPMOD)__ALL.a: $(VDIRFB)/V$(TOPMOD).cpp
	make --no-print-directory -C $(VDIRFB) -f V$(TOPMOD).mk

$(SIMPROG): $(SIMFILE) $(VDIRFB)/V$(TOPMOD)__ALL.a $(COSIMS)
	$(GCC) $(CFLAGS) $(VINC)/verilated.cpp				\
		$(VINC)/verilated_vcd_c.cpp $(SIMFILE) $(COSIMS)	\
		$(VDIRFB)/V$(TOPMOD)__ALL.a -o $(SIMPROG)

test: $(VCDFILE)

$(VCDFILE): $(SIMPROG)
	./$(SIMPROG)

##
## Find all of the Verilog dependencies and submodules
##
DEPS := $(wildcard $(VDIRFB)/*.d)

## Include any of these submodules in the Makefile
## ... but only if we are not building the "clean" target
## which would (oops) try to build those dependencies again
##
ifneq ($(MAKECMDGOALS),clean)
ifneq ($(DEPS),)
include $(DEPS)
endif
endif

help: 
	@printf " all          main build of everything to create $(PROJ).bit   \n"
	@printf " clean        remove files that are created with this Makefile \n"
	@printf " install      install toolchain and all dependencies           \n"
	@printf " prog         create binary file and upload using $(ICEPROG)   \n"
	@printf " sim          run iverilog and then launch gtkwave for $(PROJ) \n"
	@printf " xserver      primaily for WSL users, load cygwin64 startxwin  \n"
	@printf "                                                               \n"
	@printf "Project-named parameters:                                      \n"
	@printf " $(PROJ).bit  same as --all                                    \n"
	@printf "                                                               \n"


# main build
all: $(PROJ).bit
	@printf "\n\n $(PROJ).bit done! \n\n"
	ls $(PROJ).bit -al


%.bit: $(PROJ)_out.config
	@printf "\n\n bit ecppack...\n\n"
	ecppack $(PROJ)_out.config $(PROJ).bit --idcode 0x21111043
	grep -i warning $(PROJ).nextpnr-ecp5.log || true
	grep -i warning $(PROJ).yosys.log        || true

%_out.config: $(PROJ).json
	@printf "\n\n nextpnr-ecp5 config... \n\n "
	nextpnr-ecp5 --$(LUT_SIZE) --json $(PROJ).json --lpf $(PIN_DEF) \
                 --textcfg $(PROJ)_out.config --log  $(PROJ).nextpnr-ecp5.log
		

%.json: $(PROJ).ys $(TOP_MOD_FILE).v
	@printf "\n\n yosys ... \n\n "
	yosys $(PROJ).ys | tee $(PROJ).yosys.log

#%.blif: %.v
	#printf "yosys..."
	#read continue
	#yosys -p 'synth_ice40 -top top -blif $@' $<

#%.asc: $(PIN_DEF) %.blif
	#echo "$(ARACHNE) $(ARACHNE_ARGS) -d $(subst up,,$(subst hx,,$(subst lp,,$(DEVICE)))) -o $@ -p $^"
	#printf "asc..."
	#read continue
	#$(ARACHNE) $(ARACHNE_ARGS) -d $(subst up,,$(subst hx,,$(subst lp,,$(DEVICE)))) -o $@ -p $^


%.bin: %.asc
	@printf ""\n\n bin... "\n\n"
	$(ICEPACK) $< $@

%.rpt: %.asc
	$(ICETIME) -d $(DEVICE) -mtr $@ $<

prog: $(PROJ).bit
	$(ICEPROG)  $<

sudo-prog: $(PROJ).bin
	@printf '"\n\n Executing prog as root!!! "\n\n'
	sudo $(ICEPROG) $<

clean:
	@printf ""\n\n clean... "\n\n"
	rm -rf $(VDIRFB)/ $(SIMPROG) $(VCDFILE) blinky/ $(BINFILE) $(RPTFILE)
	rm -f $(PROJ).blif $(PROJ).asc $(PROJ).rpt $(PROJ).bit $(PROJ).json $(PROJ)_out.config $(PROJ).nextpnr-ecp5.log $(PROJ).yosys.log

sim: 
	rm -f $(PROJ).vcd
	iverilog  -o $(PROJ).vvp spi.v spi_tb.v
	vvp $(PROJ).vvp
	export DISPLAY=:0

## if we are running in WSL, we need a bit of help for GUI XWindows: copy .Xauthority file locally.
## sometimes the WSL username is not the same as the Windows username, and we need the windows user path.
## this is the Windows %USER% environment variable when called from makefile: $(shell cmd.exe /c "echo $$USER")
	@if [ "$(shell grep Microsoft /proc/version)" != "" ]; then   \
		cp /mnt/c/cygwin64/home/$(shell cmd.exe /c "echo $$USER")/.Xauthority   ~/.Xauthority; \
    fi

	(gtkwave $(PROJ).vcd $(PROJ)_savefile.gtkw)&

xserver:
## launch the Windows cygwin64 startxwin when WSL iss detected
	@if [ "$(shell grep Microsoft /proc/version)" != "" ]; then   \
		echo "Launching Windows XServer from WSL...";             \
		(/mnt/c/cygwin64/bin/run.exe --quote /usr/bin/bash.exe -l -c " exec /usr/bin/startxwin -- -listen tcp -nowgl")&  \
	else                                                          \
		echo "Not launching WSL XServer!" ;                                             \
    fi

install:
	git clone https://gist.github.com/gojimmypi/f96cd86b2b8595b4cf3be4baf493c5a7 ULX3S_WSL_Toolchain.sh
	@printf "\n\n  ULX3S_WSL_Toolchain.sh fetched; review, edit for your device if desired, then run it. ... \n\n "

.SECONDARY:
.PHONY: all prog clean