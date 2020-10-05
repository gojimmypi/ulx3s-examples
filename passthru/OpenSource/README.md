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
../../bin/fujprog.exe ulx3s.bit
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

Current full output:

```
$ make wslprog -f Makefile.12F
yosys passthru.ys

 /----------------------------------------------------------------------------\
 |                                                                            |
 |  yosys -- Yosys Open SYnthesis Suite                                       |
 |                                                                            |
 |  Copyright (C) 2012 - 2018  Clifford Wolf <clifford@clifford.at>           |
 |                                                                            |
 |  Permission to use, copy, modify, and/or distribute this software for any  |
 |  purpose with or without fee is hereby granted, provided that the above    |
 |  copyright notice and this permission notice appear in all copies.         |
 |                                                                            |
 |  THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES  |
 |  WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF          |
 |  MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR   |
 |  ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES    |
 |  WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN     |
 |  ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF   |
 |  OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.            |
 |                                                                            |
 \----------------------------------------------------------------------------/

 Yosys 0.8+510 (git sha1 36120fcc, clang 6.0.0-1ubuntu2 -fPIC -Os)


-- Executing script file `passthru.ys' --

1. Executing Verilog-2005 frontend: passthru.v
Parsing Verilog input from `passthru.v' to AST representation.
Warning: Yosys has only limited support for tri-state logic at the moment. (passthru.v:149)
Generating RTLIL representation for module `\ulx3s_passthru_wifi'.
passthru.v:180: Warning: Identifier `\clk_25MHz' is implicitly declared.
Successfully finished Verilog frontend.

2. Executing SYNTH_ECP5 pass.

2.1. Executing Verilog-2005 frontend: /usr/local/bin/../share/yosys/ecp5/cells_sim.v
Parsing Verilog input from `/usr/local/bin/../share/yosys/ecp5/cells_sim.v' to AST representation.
Lexer warning: The SystemVerilog keyword `assert' (at /usr/local/bin/../share/yosys/ecp5/cells_sim.v:419) is not recognized unless read_verilog is called with -sv!
Lexer warning: The SystemVerilog keyword `assert' (at /usr/local/bin/../share/yosys/ecp5/cells_sim.v:420) is not recognized unless read_verilog is called with -sv!
Lexer warning: The SystemVerilog keyword `assert' (at /usr/local/bin/../share/yosys/ecp5/cells_sim.v:421) is not recognized unless read_verilog is called with -sv!
Lexer warning: The SystemVerilog keyword `assert' (at /usr/local/bin/../share/yosys/ecp5/cells_sim.v:422) is not recognized unless read_verilog is called with -sv!
Generating RTLIL representation for module `\LUT4'.
Generating RTLIL representation for module `\L6MUX21'.
Generating RTLIL representation for module `\CCU2C'.
Generating RTLIL representation for module `\TRELLIS_RAM16X2'.
Generating RTLIL representation for module `\PFUMX'.
Generating RTLIL representation for module `\TRELLIS_DPR16X4'.
Generating RTLIL representation for module `\DPR16X4C'.
Generating RTLIL representation for module `\LUT2'.
Generating RTLIL representation for module `\TRELLIS_FF'.
Generating RTLIL representation for module `\OBZ'.
Generating RTLIL representation for module `\IB'.
Generating RTLIL representation for module `\TRELLIS_IO'.
Generating RTLIL representation for module `\OB'.
Generating RTLIL representation for module `\BB'.
Generating RTLIL representation for module `\INV'.
Generating RTLIL representation for module `\TRELLIS_SLICE'.
Generating RTLIL representation for module `\DP16KD'.
Generating RTLIL representation for module `\FD1S3BX'.
Successfully finished Verilog frontend.

2.2. Executing Verilog-2005 frontend: /usr/local/bin/../share/yosys/ecp5/cells_bb.v
Parsing Verilog input from `/usr/local/bin/../share/yosys/ecp5/cells_bb.v' to AST representation.
Generating RTLIL representation for module `\MULT18X18D'.
Generating RTLIL representation for module `\ALU54B'.
Generating RTLIL representation for module `\EHXPLLL'.
Generating RTLIL representation for module `\DTR'.
Generating RTLIL representation for module `\OSCG'.
Generating RTLIL representation for module `\USRMCLK'.
Generating RTLIL representation for module `\JTAGG'.
Generating RTLIL representation for module `\DELAYF'.
Generating RTLIL representation for module `\DELAYG'.
Generating RTLIL representation for module `\IDDRX1F'.
Generating RTLIL representation for module `\IDDRX2F'.
Generating RTLIL representation for module `\IDDR71B'.
Generating RTLIL representation for module `\IDDRX2DQA'.
Generating RTLIL representation for module `\ODDRX1F'.
Generating RTLIL representation for module `\ODDRX2F'.
Generating RTLIL representation for module `\ODDR71B'.
Generating RTLIL representation for module `\OSHX2A'.
Generating RTLIL representation for module `\ODDRX2DQA'.
Generating RTLIL representation for module `\ODDRX2DQSB'.
Generating RTLIL representation for module `\TSHX2DQA'.
Generating RTLIL representation for module `\TSHX2DQSA'.
Generating RTLIL representation for module `\DQSBUFM'.
Generating RTLIL representation for module `\DDRDLLA'.
Generating RTLIL representation for module `\CLKDIVF'.
Generating RTLIL representation for module `\ECLKSYNCB'.
Generating RTLIL representation for module `\DCCA'.
Generating RTLIL representation for module `\DCUA'.
Generating RTLIL representation for module `\EXTREFB'.
Generating RTLIL representation for module `\PCSCLKDIV'.
Successfully finished Verilog frontend.

2.3. Executing HIERARCHY pass (managing design hierarchy).

2.3.1. Finding top of design hierarchy..
root of   0 design levels: ulx3s_passthru_wifi
Automatically selected ulx3s_passthru_wifi as design top module.

2.3.2. Analyzing design hierarchy..
Top module:  \ulx3s_passthru_wifi

2.3.3. Analyzing design hierarchy..
Top module:  \ulx3s_passthru_wifi
Removed 0 unused modules.

2.4. Executing PROC pass (convert processes to netlists).

2.4.1. Executing PROC_CLEAN pass (remove empty switches from decision trees).
Cleaned up 0 empty switches.

2.4.2. Executing PROC_RMDEAD pass (remove dead branches from decision trees).
Marked 1 switch rules as full_case in process $proc$passthru.v:202$19 in module ulx3s_passthru_wifi.
Marked 1 switch rules as full_case in process $proc$passthru.v:192$17 in module ulx3s_passthru_wifi.
Marked 1 switch rules as full_case in process $proc$passthru.v:180$11 in module ulx3s_passthru_wifi.
Removed a total of 0 dead cases.

2.4.3. Executing PROC_INIT pass (extract init attributes).
Found init rule in `\ulx3s_passthru_wifi.$proc$passthru.v:126$26'.
  Set init value: \R_progn = 8'00000000
Found init rule in `\ulx3s_passthru_wifi.$proc$passthru.v:125$25'.
  Set init value: \R_prog_release = 18'000000000000000001

2.4.4. Executing PROC_ARST pass (detect async resets in processes).
Found async reset \wifi_gpio17 in `\ulx3s_passthru_wifi.$proc$passthru.v:192$17'.

2.4.5. Executing PROC_MUX pass (convert decision trees to multiplexers).
Creating decoders for process `\ulx3s_passthru_wifi.$proc$passthru.v:126$26'.
     1/1: $1\R_progn[7:0]
Creating decoders for process `\ulx3s_passthru_wifi.$proc$passthru.v:125$25'.
     1/1: $1\R_prog_release[17:0]
Creating decoders for process `\ulx3s_passthru_wifi.$proc$passthru.v:202$19'.
     1/1: $0\R_progn[7:0]
Creating decoders for process `\ulx3s_passthru_wifi.$proc$passthru.v:192$17'.
     1/1: $0\R_spi_miso[7:0]
Creating decoders for process `\ulx3s_passthru_wifi.$proc$passthru.v:180$11'.
     1/2: $0\R_prog_in[1:0]
     2/2: $0\R_prog_release[17:0]

2.4.6. Executing PROC_DLATCH pass (convert process syncs to latches).

2.4.7. Executing PROC_DFF pass (convert process syncs to FFs).
Creating register for signal `\ulx3s_passthru_wifi.\R_progn' using process `\ulx3s_passthru_wifi.$proc$passthru.v:202$19'.
  created $dff cell `$procdff$133' with positive edge clock.
Creating register for signal `\ulx3s_passthru_wifi.\R_spi_miso' using process `\ulx3s_passthru_wifi.$proc$passthru.v:192$17'.
Warning: Async reset value `{ 1'0 \btn }' is not constant!
  created $dffsr cell `$procdff$134' with positive edge clock and positive level non-const reset.
Creating register for signal `\ulx3s_passthru_wifi.\R_prog_in' using process `\ulx3s_passthru_wifi.$proc$passthru.v:180$11'.
  created $dff cell `$procdff$141' with positive edge clock.
Creating register for signal `\ulx3s_passthru_wifi.\R_prog_release' using process `\ulx3s_passthru_wifi.$proc$passthru.v:180$11'.
  created $dff cell `$procdff$142' with positive edge clock.

2.4.8. Executing PROC_CLEAN pass (remove empty switches from decision trees).
Removing empty process `ulx3s_passthru_wifi.$proc$passthru.v:126$26'.
Removing empty process `ulx3s_passthru_wifi.$proc$passthru.v:125$25'.
Found and cleaned up 1 empty switch in `\ulx3s_passthru_wifi.$proc$passthru.v:202$19'.
Removing empty process `ulx3s_passthru_wifi.$proc$passthru.v:202$19'.
Removing empty process `ulx3s_passthru_wifi.$proc$passthru.v:192$17'.
Found and cleaned up 2 empty switches in `\ulx3s_passthru_wifi.$proc$passthru.v:180$11'.
Removing empty process `ulx3s_passthru_wifi.$proc$passthru.v:180$11'.
Cleaned up 3 empty switches.

2.5. Executing FLATTEN pass (flatten design).
No more expansions possible.

2.6. Executing TRIBUF pass.

2.7. Executing DEMINOUT pass (demote inout ports to input or output).
Demoting inout port ulx3s_passthru_wifi.sd_d to output.
Demoting inout port ulx3s_passthru_wifi.wifi_gpio0 to output.
Demoting inout port ulx3s_passthru_wifi.ftdi_nrts to input.
Demoting inout port ulx3s_passthru_wifi.ftdi_ndtr to input.

2.8. Executing SYNTH pass.

2.8.1. Executing PROC pass (convert processes to netlists).

2.8.1.1. Executing PROC_CLEAN pass (remove empty switches from decision trees).
Cleaned up 0 empty switches.

2.8.1.2. Executing PROC_RMDEAD pass (remove dead branches from decision trees).
Removed a total of 0 dead cases.

2.8.1.3. Executing PROC_INIT pass (extract init attributes).

2.8.1.4. Executing PROC_ARST pass (detect async resets in processes).

2.8.1.5. Executing PROC_MUX pass (convert decision trees to multiplexers).

2.8.1.6. Executing PROC_DLATCH pass (convert process syncs to latches).

2.8.1.7. Executing PROC_DFF pass (convert process syncs to FFs).

2.8.1.8. Executing PROC_CLEAN pass (remove empty switches from decision trees).
Cleaned up 0 empty switches.

2.8.2. Executing OPT_EXPR pass (perform const folding).
Optimizing module ulx3s_passthru_wifi.
<suppressed ~8 debug messages>

2.8.3. Executing OPT_CLEAN pass (remove unused cells and wires).
Finding unused cells or wires in module \ulx3s_passthru_wifi..
Removed 3 unused cells and 20 unused wires.
<suppressed ~4 debug messages>

2.8.4. Executing CHECK pass (checking for obvious problems).
checking module ulx3s_passthru_wifi..
Warning: Wire ulx3s_passthru_wifi.\sd_d [3] is used but has no driver.
Warning: Wire ulx3s_passthru_wifi.\sd_d [2] is used but has no driver.
Warning: Wire ulx3s_passthru_wifi.\sd_d [1] is used but has no driver.
Warning: Wire ulx3s_passthru_wifi.\led [4] is used but has no driver.
Warning: Wire ulx3s_passthru_wifi.\led [3] is used but has no driver.
Warning: Wire ulx3s_passthru_wifi.\led [2] is used but has no driver.
Warning: Wire ulx3s_passthru_wifi.\led [1] is used but has no driver.
Warning: Wire ulx3s_passthru_wifi.\led [0] is used but has no driver.
Warning: Wire ulx3s_passthru_wifi.\flash_wpn is used but has no driver.
Warning: Wire ulx3s_passthru_wifi.\flash_holdn is used but has no driver.
Warning: Wire ulx3s_passthru_wifi.\clk_25MHz is used but has no driver.
found and reported 11 problems.

2.8.5. Executing OPT pass (performing simple optimizations).

2.8.5.1. Executing OPT_EXPR pass (perform const folding).
Optimizing module ulx3s_passthru_wifi.

2.8.5.2. Executing OPT_MERGE pass (detect identical cells).
Finding identical cells in module `\ulx3s_passthru_wifi'.
Removed a total of 0 cells.

2.8.5.3. Executing OPT_MUXTREE pass (detect dead branches in mux trees).
Running muxtree optimizer on module \ulx3s_passthru_wifi..
  Creating internal representation of mux trees.
  Evaluating internal representation of mux trees.
      Replacing known input bits on port B of cell $procmux$128: \R_prog_release -> { 1'1 \R_prog_release [16:0] }
  Analyzing evaluation results.
Removed 0 multiplexer ports.
<suppressed ~6 debug messages>

2.8.5.4. Executing OPT_REDUCE pass (consolidate $*mux and $reduce_* inputs).
  Optimizing cells in module \ulx3s_passthru_wifi.
Performed a total of 0 changes.

2.8.5.5. Executing OPT_MERGE pass (detect identical cells).
Finding identical cells in module `\ulx3s_passthru_wifi'.
Removed a total of 0 cells.

2.8.5.6. Executing OPT_RMDFF pass (remove dff with constant values).

2.8.5.7. Executing OPT_CLEAN pass (remove unused cells and wires).
Finding unused cells or wires in module \ulx3s_passthru_wifi..

2.8.5.8. Executing OPT_EXPR pass (perform const folding).
Optimizing module ulx3s_passthru_wifi.

2.8.5.9. Finished OPT passes. (There is nothing left to do.)

2.8.6. Executing WREDUCE pass (reducing word size of cells).
Removed top 1 bits (of 2) from port B of cell ulx3s_passthru_wifi.$eq$passthru.v:141$2 ($eq).
Removed top 1 bits (of 2) from mux cell ulx3s_passthru_wifi.$ternary$passthru.v:141$3 ($mux).
Removed top 1 bits (of 2) from port B of cell ulx3s_passthru_wifi.$eq$passthru.v:182$12 ($eq).
Removed top 31 bits (of 32) from port B of cell ulx3s_passthru_wifi.$add$passthru.v:187$16 ($add).
Removed top 14 bits (of 32) from port Y of cell ulx3s_passthru_wifi.$add$passthru.v:187$16 ($add).
Removed top 31 bits (of 32) from port B of cell ulx3s_passthru_wifi.$add$passthru.v:204$23 ($add).
Removed top 24 bits (of 32) from port Y of cell ulx3s_passthru_wifi.$add$passthru.v:204$23 ($add).
Removed top 1 bits (of 8) from port A of cell ulx3s_passthru_wifi.$auto$proc_dff.cc:156:gen_dffsr$138 ($not).
Removed top 1 bits (of 8) from mux cell ulx3s_passthru_wifi.$auto$proc_dff.cc:163:gen_dffsr$139 ($mux).
Removed top 14 bits (of 32) from wire ulx3s_passthru_wifi.$add$passthru.v:187$16_Y.
Removed top 24 bits (of 32) from wire ulx3s_passthru_wifi.$add$passthru.v:204$23_Y.
Removed top 1 bits (of 8) from wire ulx3s_passthru_wifi.$auto$proc_dff.cc:153:gen_dffsr$136.
Removed top 1 bits (of 2) from wire ulx3s_passthru_wifi.$ternary$passthru.v:141$3_Y.

2.8.7. Executing PEEPOPT pass (run peephole optimizers).

2.8.8. Executing OPT_CLEAN pass (remove unused cells and wires).
Finding unused cells or wires in module \ulx3s_passthru_wifi..
Removed 0 unused cells and 4 unused wires.
<suppressed ~1 debug messages>

2.8.9. Executing TECHMAP pass (map to technology primitives).

2.8.9.1. Executing Verilog-2005 frontend: /usr/local/bin/../share/yosys/cmp2lut.v
Parsing Verilog input from `/usr/local/bin/../share/yosys/cmp2lut.v' to AST representation.
Generating RTLIL representation for module `\_90_lut_cmp_'.
Successfully finished Verilog frontend.

2.8.9.2. Continuing TECHMAP pass.
No more expansions possible.
<suppressed ~52 debug messages>

2.8.10. Executing ALUMACC pass (create $alu and $macc cells).
Extracting $alu and $macc cells in module ulx3s_passthru_wifi:
  creating $macc model for $add$passthru.v:187$16 ($add).
  creating $macc model for $add$passthru.v:204$23 ($add).
  creating $alu model for $macc $add$passthru.v:204$23.
  creating $alu model for $macc $add$passthru.v:187$16.
  creating $alu cell for $add$passthru.v:187$16: $auto$alumacc.cc:474:replace_alu$147
  creating $alu cell for $add$passthru.v:204$23: $auto$alumacc.cc:474:replace_alu$150
  created 2 $alu and 0 $macc cells.

2.8.11. Executing SHARE pass (SAT-based resource sharing).

2.8.12. Executing OPT pass (performing simple optimizations).

2.8.12.1. Executing OPT_EXPR pass (perform const folding).
Optimizing module ulx3s_passthru_wifi.

2.8.12.2. Executing OPT_MERGE pass (detect identical cells).
Finding identical cells in module `\ulx3s_passthru_wifi'.
Removed a total of 0 cells.

2.8.12.3. Executing OPT_MUXTREE pass (detect dead branches in mux trees).
Running muxtree optimizer on module \ulx3s_passthru_wifi..
  Creating internal representation of mux trees.
  Evaluating internal representation of mux trees.
  Analyzing evaluation results.
Removed 0 multiplexer ports.
<suppressed ~6 debug messages>

2.8.12.4. Executing OPT_REDUCE pass (consolidate $*mux and $reduce_* inputs).
  Optimizing cells in module \ulx3s_passthru_wifi.
Performed a total of 0 changes.

2.8.12.5. Executing OPT_MERGE pass (detect identical cells).
Finding identical cells in module `\ulx3s_passthru_wifi'.
Removed a total of 0 cells.

2.8.12.6. Executing OPT_RMDFF pass (remove dff with constant values).

2.8.12.7. Executing OPT_CLEAN pass (remove unused cells and wires).
Finding unused cells or wires in module \ulx3s_passthru_wifi..

2.8.12.8. Executing OPT_EXPR pass (perform const folding).
Optimizing module ulx3s_passthru_wifi.

2.8.12.9. Finished OPT passes. (There is nothing left to do.)

2.8.13. Executing FSM pass (extract and optimize FSM).

2.8.13.1. Executing FSM_DETECT pass (finding FSMs in design).

2.8.13.2. Executing FSM_EXTRACT pass (extracting FSM from design).

2.8.13.3. Executing FSM_OPT pass (simple optimizations of FSMs).

2.8.13.4. Executing OPT_CLEAN pass (remove unused cells and wires).
Finding unused cells or wires in module \ulx3s_passthru_wifi..

2.8.13.5. Executing FSM_OPT pass (simple optimizations of FSMs).

2.8.13.6. Executing FSM_RECODE pass (re-assigning FSM state encoding).

2.8.13.7. Executing FSM_INFO pass (dumping all available information on FSM cells).

2.8.13.8. Executing FSM_MAP pass (mapping FSMs to basic logic).

2.8.14. Executing OPT pass (performing simple optimizations).

2.8.14.1. Executing OPT_EXPR pass (perform const folding).
Optimizing module ulx3s_passthru_wifi.

2.8.14.2. Executing OPT_MERGE pass (detect identical cells).
Finding identical cells in module `\ulx3s_passthru_wifi'.
Removed a total of 0 cells.

2.8.14.3. Executing OPT_RMDFF pass (remove dff with constant values).

2.8.14.4. Executing OPT_CLEAN pass (remove unused cells and wires).
Finding unused cells or wires in module \ulx3s_passthru_wifi..

2.8.14.5. Finished fast OPT passes.

2.8.15. Executing MEMORY pass.

2.8.15.1. Executing MEMORY_DFF pass (merging $dff cells to $memrd and $memwr).

2.8.15.2. Executing OPT_CLEAN pass (remove unused cells and wires).
Finding unused cells or wires in module \ulx3s_passthru_wifi..

2.8.15.3. Executing MEMORY_SHARE pass (consolidating $memrd/$memwr cells).

2.8.15.4. Executing OPT_CLEAN pass (remove unused cells and wires).
Finding unused cells or wires in module \ulx3s_passthru_wifi..

2.8.15.5. Executing MEMORY_COLLECT pass (generating $mem cells).

2.8.16. Executing OPT_CLEAN pass (remove unused cells and wires).
Finding unused cells or wires in module \ulx3s_passthru_wifi..

2.9. Executing MEMORY_BRAM pass (mapping $mem cells to block memories).

2.10. Executing TECHMAP pass (map to technology primitives).

2.10.1. Executing Verilog-2005 frontend: /usr/local/bin/../share/yosys/ecp5/brams_map.v
Parsing Verilog input from `/usr/local/bin/../share/yosys/ecp5/brams_map.v' to AST representation.
Generating RTLIL representation for module `\$__ECP5_DP16KD'.
Successfully finished Verilog frontend.

2.10.2. Continuing TECHMAP pass.
No more expansions possible.

2.11. Executing OPT pass (performing simple optimizations).

2.11.1. Executing OPT_EXPR pass (perform const folding).
Optimizing module ulx3s_passthru_wifi.
<suppressed ~16 debug messages>

2.11.2. Executing OPT_MERGE pass (detect identical cells).
Finding identical cells in module `\ulx3s_passthru_wifi'.
Removed a total of 0 cells.

2.11.3. Executing OPT_RMDFF pass (remove dff with constant values).
Removing $procdff$133 ($dff) from module ulx3s_passthru_wifi.
Removing $procdff$141 ($dff) from module ulx3s_passthru_wifi.
Removing $procdff$142 ($dff) from module ulx3s_passthru_wifi.
Replaced 3 DFF cells.

2.11.4. Executing OPT_CLEAN pass (remove unused cells and wires).
Finding unused cells or wires in module \ulx3s_passthru_wifi..
Removed 10 unused cells and 16 unused wires.
<suppressed ~11 debug messages>

2.11.5. Rerunning OPT passes. (Removed registers in this run.)

2.11.6. Executing OPT_EXPR pass (perform const folding).
Optimizing module ulx3s_passthru_wifi.
<suppressed ~3 debug messages>

2.11.7. Executing OPT_MERGE pass (detect identical cells).
Finding identical cells in module `\ulx3s_passthru_wifi'.
Removed a total of 0 cells.

2.11.8. Executing OPT_RMDFF pass (remove dff with constant values).

2.11.9. Executing OPT_CLEAN pass (remove unused cells and wires).
Finding unused cells or wires in module \ulx3s_passthru_wifi..
Removed 4 unused cells and 3 unused wires.
<suppressed ~5 debug messages>

2.11.10. Finished fast OPT passes.

2.12. Executing MEMORY_MAP pass (converting $mem cells to logic and flip-flops).

2.13. Executing OPT pass (performing simple optimizations).

2.13.1. Executing OPT_EXPR pass (perform const folding).
Optimizing module ulx3s_passthru_wifi.
<suppressed ~2 debug messages>

2.13.2. Executing OPT_MERGE pass (detect identical cells).
Finding identical cells in module `\ulx3s_passthru_wifi'.
Removed a total of 0 cells.

2.13.3. Executing OPT_MUXTREE pass (detect dead branches in mux trees).
Running muxtree optimizer on module \ulx3s_passthru_wifi..
  Creating internal representation of mux trees.
  Evaluating internal representation of mux trees.
  Analyzing evaluation results.
Removed 0 multiplexer ports.
<suppressed ~1 debug messages>

2.13.4. Executing OPT_REDUCE pass (consolidate $*mux and $reduce_* inputs).
  Optimizing cells in module \ulx3s_passthru_wifi.
Performed a total of 0 changes.

2.13.5. Executing OPT_MERGE pass (detect identical cells).
Finding identical cells in module `\ulx3s_passthru_wifi'.
Removed a total of 0 cells.

2.13.6. Executing OPT_RMDFF pass (remove dff with constant values).

2.13.7. Executing OPT_CLEAN pass (remove unused cells and wires).
Finding unused cells or wires in module \ulx3s_passthru_wifi..

2.13.8. Executing OPT_EXPR pass (perform const folding).
Optimizing module ulx3s_passthru_wifi.

2.13.9. Finished OPT passes. (There is nothing left to do.)

2.14. Executing TECHMAP pass (map to technology primitives).

2.14.1. Executing Verilog-2005 frontend: <techmap.v>
Parsing Verilog input from `<techmap.v>' to AST representation.
Generating RTLIL representation for module `\_90_simplemap_bool_ops'.
Generating RTLIL representation for module `\_90_simplemap_reduce_ops'.
Generating RTLIL representation for module `\_90_simplemap_logic_ops'.
Generating RTLIL representation for module `\_90_simplemap_compare_ops'.
Generating RTLIL representation for module `\_90_simplemap_various'.
Generating RTLIL representation for module `\_90_simplemap_registers'.
Generating RTLIL representation for module `\_90_shift_ops_shr_shl_sshl_sshr'.
Generating RTLIL representation for module `\_90_shift_shiftx'.
Generating RTLIL representation for module `\_90_fa'.
Generating RTLIL representation for module `\_90_lcu'.
Generating RTLIL representation for module `\_90_alu'.
Generating RTLIL representation for module `\_90_macc'.
Generating RTLIL representation for module `\_90_alumacc'.
Generating RTLIL representation for module `\$__div_mod_u'.
Generating RTLIL representation for module `\$__div_mod'.
Generating RTLIL representation for module `\_90_div'.
Generating RTLIL representation for module `\_90_mod'.
Generating RTLIL representation for module `\_90_pow'.
Generating RTLIL representation for module `\_90_pmux'.
Generating RTLIL representation for module `\_90_lut'.
Successfully finished Verilog frontend.

2.14.2. Continuing TECHMAP pass.
Using extmapper simplemap for cells of type $eq.
Using extmapper simplemap for cells of type $mux.
Using extmapper simplemap for cells of type $and.
No more expansions possible.
<suppressed ~5 debug messages>

2.15. Executing DFFSR2DFF pass (mapping DFFSR cells to simpler FFs).

2.16. Executing dff2dffs pass (merge synchronous set/reset into FF cells).
Merging set/reset $_MUX_ cells into DFFs in ulx3s_passthru_wifi.

2.17. Executing OPT_CLEAN pass (remove unused cells and wires).
Finding unused cells or wires in module \ulx3s_passthru_wifi..
Removed 0 unused cells and 2 unused wires.
<suppressed ~1 debug messages>

2.18. Executing DFF2DFFE pass (transform $dff to $dffe where applicable).
Selected cell types for direct conversion:
  $__DFFS_PP1_ -> $__DFFSE_PP1
  $__DFFS_PP0_ -> $__DFFSE_PP0
  $__DFFS_PN1_ -> $__DFFSE_PN1
  $__DFFS_PN0_ -> $__DFFSE_PN0
  $__DFFS_NP1_ -> $__DFFSE_NP1
  $__DFFS_NP0_ -> $__DFFSE_NP0
  $__DFFS_NN1_ -> $__DFFSE_NN1
  $__DFFS_NN0_ -> $__DFFSE_NN0
  $_DFF_PP1_ -> $__DFFE_PP1
  $_DFF_PP0_ -> $__DFFE_PP0
  $_DFF_PN1_ -> $__DFFE_PN1
  $_DFF_PN0_ -> $__DFFE_PN0
  $_DFF_NP1_ -> $__DFFE_NP1
  $_DFF_NP0_ -> $__DFFE_NP0
  $_DFF_NN1_ -> $__DFFE_NN1
  $_DFF_NN0_ -> $__DFFE_NN0
  $_DFF_N_ -> $_DFFE_NP_
  $_DFF_P_ -> $_DFFE_PP_
Transforming FF to FF+Enable cells in module ulx3s_passthru_wifi:

2.19. Executing TECHMAP pass (map to technology primitives).

2.19.1. Executing Verilog-2005 frontend: /usr/local/bin/../share/yosys/ecp5/cells_map.v
Parsing Verilog input from `/usr/local/bin/../share/yosys/ecp5/cells_map.v' to AST representation.
Generating RTLIL representation for module `\$_DFF_N_'.
Generating RTLIL representation for module `\$_DFF_P_'.
Generating RTLIL representation for module `\$_DFFE_NN_'.
Generating RTLIL representation for module `\$_DFFE_PN_'.
Generating RTLIL representation for module `\$_DFFE_NP_'.
Generating RTLIL representation for module `\$_DFFE_PP_'.
Generating RTLIL representation for module `\$_DFF_NN0_'.
Generating RTLIL representation for module `\$_DFF_NN1_'.
Generating RTLIL representation for module `\$_DFF_PN0_'.
Generating RTLIL representation for module `\$_DFF_PN1_'.
Generating RTLIL representation for module `\$_DFF_NP0_'.
Generating RTLIL representation for module `\$_DFF_NP1_'.
Generating RTLIL representation for module `\$_DFF_PP0_'.
Generating RTLIL representation for module `\$_DFF_PP1_'.
Generating RTLIL representation for module `\$__DFFS_NN0_'.
Generating RTLIL representation for module `\$__DFFS_NN1_'.
Generating RTLIL representation for module `\$__DFFS_PN0_'.
Generating RTLIL representation for module `\$__DFFS_PN1_'.
Generating RTLIL representation for module `\$__DFFS_NP0_'.
Generating RTLIL representation for module `\$__DFFS_NP1_'.
Generating RTLIL representation for module `\$__DFFS_PP0_'.
Generating RTLIL representation for module `\$__DFFS_PP1_'.
Generating RTLIL representation for module `\$__DFFE_NN0'.
Generating RTLIL representation for module `\$__DFFE_NN1'.
Generating RTLIL representation for module `\$__DFFE_PN0'.
Generating RTLIL representation for module `\$__DFFE_PN1'.
Generating RTLIL representation for module `\$__DFFE_NP0'.
Generating RTLIL representation for module `\$__DFFE_NP1'.
Generating RTLIL representation for module `\$__DFFE_PP0'.
Generating RTLIL representation for module `\$__DFFE_PP1'.
Generating RTLIL representation for module `\$__DFFSE_NN0'.
Generating RTLIL representation for module `\$__DFFSE_NN1'.
Generating RTLIL representation for module `\$__DFFSE_PN0'.
Generating RTLIL representation for module `\$__DFFSE_PN1'.
Generating RTLIL representation for module `\$__DFFSE_NP0'.
Generating RTLIL representation for module `\$__DFFSE_NP1'.
Generating RTLIL representation for module `\$__DFFSE_PP0'.
Generating RTLIL representation for module `\$__DFFSE_PP1'.
Generating RTLIL representation for module `\FD1S3BX'.
Successfully finished Verilog frontend.

2.19.2. Continuing TECHMAP pass.
No more expansions possible.

2.20. Executing OPT_EXPR pass (perform const folding).
Optimizing module ulx3s_passthru_wifi.
<suppressed ~7 debug messages>

2.21. Executing SIMPLEMAP pass (map simple cells to gate primitives).

2.22. Executing ECP5_FFINIT pass (implement FF init values).
Handling FF init values in ulx3s_passthru_wifi.

2.23. Executing TECHMAP pass (map to technology primitives).

2.23.1. Executing Verilog-2005 frontend: /usr/local/bin/../share/yosys/ecp5/latches_map.v
Parsing Verilog input from `/usr/local/bin/../share/yosys/ecp5/latches_map.v' to AST representation.
Generating RTLIL representation for module `\$_DLATCH_N_'.
Generating RTLIL representation for module `\$_DLATCH_P_'.
Successfully finished Verilog frontend.

2.23.2. Continuing TECHMAP pass.
No more expansions possible.

2.24. Executing ABC pass (technology mapping using ABC).

2.24.1. Extracting gate netlist of module `\ulx3s_passthru_wifi' to `<abc-temp-dir>/input.blif'..
Extracted 8 gates and 12 wires to a netlist network with 3 inputs and 3 outputs.

2.24.1.1. Executing ABC.
Running ABC command: <yosys-exe-dir>/yosys-abc -s -f <abc-temp-dir>/abc.script 2>&1
ABC: ABC command line: "source <abc-temp-dir>/abc.script".
ABC:
ABC: + read_blif <abc-temp-dir>/input.blif
ABC: + read_lut <abc-temp-dir>/lutdefs.txt
ABC: + strash
ABC: + ifraig
ABC: + scorr
ABC: Warning: The network is combinational (run "fraig" or "fraig_sweep").
ABC: + dc2
ABC: + dretime
ABC: + retime
ABC: + strash
ABC: + dch -f
ABC: + if
ABC: + mfs2
ABC: + lutpack -S 1
ABC: + dress
ABC: Total number of equiv classes                =       4.
ABC: Participating nodes from both networks       =      10.
ABC: Participating nodes from the first network   =       3. (  75.00 % of nodes)
ABC: Participating nodes from the second network  =       7. ( 175.00 % of nodes)
ABC: Node pairs (any polarity)                    =       3. (  75.00 % of names can be moved)
ABC: Node pairs (same polarity)                   =       3. (  75.00 % of names can be moved)
ABC: Total runtime =     0.00 sec
ABC: + write_blif <abc-temp-dir>/output.blif

2.24.1.2. Re-integrating ABC results.
ABC RESULTS:              $lut cells:        6
ABC RESULTS:        internal signals:        6
ABC RESULTS:           input signals:        3
ABC RESULTS:          output signals:        3
Removing temp directory.
Removed 0 unused cells and 13 unused wires.

2.25. Executing TECHMAP pass (map to technology primitives).

2.25.1. Executing Verilog-2005 frontend: /usr/local/bin/../share/yosys/ecp5/cells_map.v
Parsing Verilog input from `/usr/local/bin/../share/yosys/ecp5/cells_map.v' to AST representation.
Generating RTLIL representation for module `\$_DFF_N_'.
Generating RTLIL representation for module `\$_DFF_P_'.
Generating RTLIL representation for module `\$_DFFE_NN_'.
Generating RTLIL representation for module `\$_DFFE_PN_'.
Generating RTLIL representation for module `\$_DFFE_NP_'.
Generating RTLIL representation for module `\$_DFFE_PP_'.
Generating RTLIL representation for module `\$_DFF_NN0_'.
Generating RTLIL representation for module `\$_DFF_NN1_'.
Generating RTLIL representation for module `\$_DFF_PN0_'.
Generating RTLIL representation for module `\$_DFF_PN1_'.
Generating RTLIL representation for module `\$_DFF_NP0_'.
Generating RTLIL representation for module `\$_DFF_NP1_'.
Generating RTLIL representation for module `\$_DFF_PP0_'.
Generating RTLIL representation for module `\$_DFF_PP1_'.
Generating RTLIL representation for module `\$__DFFS_NN0_'.
Generating RTLIL representation for module `\$__DFFS_NN1_'.
Generating RTLIL representation for module `\$__DFFS_PN0_'.
Generating RTLIL representation for module `\$__DFFS_PN1_'.
Generating RTLIL representation for module `\$__DFFS_NP0_'.
Generating RTLIL representation for module `\$__DFFS_NP1_'.
Generating RTLIL representation for module `\$__DFFS_PP0_'.
Generating RTLIL representation for module `\$__DFFS_PP1_'.
Generating RTLIL representation for module `\$__DFFE_NN0'.
Generating RTLIL representation for module `\$__DFFE_NN1'.
Generating RTLIL representation for module `\$__DFFE_PN0'.
Generating RTLIL representation for module `\$__DFFE_PN1'.
Generating RTLIL representation for module `\$__DFFE_NP0'.
Generating RTLIL representation for module `\$__DFFE_NP1'.
Generating RTLIL representation for module `\$__DFFE_PP0'.
Generating RTLIL representation for module `\$__DFFE_PP1'.
Generating RTLIL representation for module `\$__DFFSE_NN0'.
Generating RTLIL representation for module `\$__DFFSE_NN1'.
Generating RTLIL representation for module `\$__DFFSE_PN0'.
Generating RTLIL representation for module `\$__DFFSE_PN1'.
Generating RTLIL representation for module `\$__DFFSE_NP0'.
Generating RTLIL representation for module `\$__DFFSE_NP1'.
Generating RTLIL representation for module `\$__DFFSE_PP0'.
Generating RTLIL representation for module `\$__DFFSE_PP1'.
Generating RTLIL representation for module `\FD1S3BX'.
Generating RTLIL representation for module `\$lut'.
Successfully finished Verilog frontend.

2.25.2. Continuing TECHMAP pass.
Using template $paramod\$lut\WIDTH=2\LUT=4'1011 for cells of type $lut.
Using template $paramod\$lut\WIDTH=3\LUT=8'10110000 for cells of type $lut.
No more expansions possible.
<suppressed ~25 debug messages>
Removed 0 unused cells and 6 unused wires.

2.26. Executing HIERARCHY pass (managing design hierarchy).

2.26.1. Analyzing design hierarchy..
Top module:  \ulx3s_passthru_wifi

2.26.2. Analyzing design hierarchy..
Top module:  \ulx3s_passthru_wifi
Removed 0 unused modules.

2.27. Printing statistics.

=== ulx3s_passthru_wifi ===

   Number of wires:                 43
   Number of wire bits:            159
   Number of public wires:          43
   Number of public wire bits:     159
   Number of memories:               0
   Number of memory bits:            0
   Number of processes:              0
   Number of cells:                  3
     LUT4                            3

2.28. Executing CHECK pass (checking for obvious problems).
checking module ulx3s_passthru_wifi..
found and reported 0 problems.

2.29. Executing JSON backend.

Warnings: 14 unique messages, 14 total
End of script. Logfile hash: c2bf811754
CPU: user 0.59s system 0.36s, MEM: 219.11 MB total, 198.50 MB resident
Yosys 0.8+510 (git sha1 36120fcc, clang 6.0.0-1ubuntu2 -fPIC -Os)
Time spent: 63% 11x read_verilog (0 sec), 8% 13x opt_clean (0 sec), ...
nextpnr-ecp5 --25k --json passthru.json  \
        --lpf ulx3s_v20.lpf \
        --textcfg ulx3s_out.config
Info: Importing module ulx3s_passthru_wifi
Info: Rule checker, verifying imported design
Info: Checksum: 0x9a250b63

Info: constraining clock net 'clk_25mhz' to 25.00 MHz
Warning:     ignoring unsupported LPF command 'SYSCONFIG CONFIG_IOVOLTAGE=3.3 COMPRESS_CONFIG=ON MCCLK_FREQ=62 MASTER_SPI_PORT=DISABLE SLAVE_SPI_PORT=DISABLE SLAVE_PARALLEL_PORT=DISABLE' (on line 14)

Info: Packing IOs..
Info: pin 'user_programn$tr_io' constrained to Bel 'X0/Y38/PIOA'.
Info: pin 'clk_25mhz$tr_io' constrained to Bel 'X0/Y26/PIOA'.
Info: pin 'wifi_txd$tr_io' constrained to Bel 'X0/Y35/PIOA'.
Info: pin 'wifi_rxd$tr_io' constrained to Bel 'X0/Y29/PIOD'.
Info: pin 'ftdi_ndtr$tr_io' constrained to Bel 'X0/Y44/PIOD'.
Info: pin 'ftdi_nrts$tr_io' constrained to Bel 'X0/Y41/PIOB'.
Info: pin 'ftdi_txden$tr_io' constrained to Bel 'X0/Y41/PIOC'.
Info: pin 'wifi_en$tr_io' constrained to Bel 'X0/Y26/PIOB'.
Info: pin 'wifi_gpio0$tr_io' constrained to Bel 'X0/Y41/PIOD'.
Info: pin 'wifi_gpio5$tr_io' constrained to Bel 'X0/Y38/PIOC'.
Info: pin 'wifi_gpio16$tr_io' constrained to Bel 'X0/Y44/PIOC'.
Info: pin 'wifi_gpio17$tr_io' constrained to Bel 'X0/Y41/PIOA'.
Info: pin 'btn[0]$tr_io' constrained to Bel 'X6/Y0/PIOB'.
Info: pin 'btn[1]$tr_io' constrained to Bel 'X4/Y50/PIOA'.
Info: pin 'btn[2]$tr_io' constrained to Bel 'X4/Y50/PIOB'.
Info: pin 'btn[3]$tr_io' constrained to Bel 'X72/Y44/PIOB'.
Info: pin 'btn[4]$tr_io' constrained to Bel 'X6/Y50/PIOB'.
Info: pin 'btn[5]$tr_io' constrained to Bel 'X6/Y50/PIOA'.
Info: pin 'btn[6]$tr_io' constrained to Bel 'X72/Y8/PIOD'.
Info: pin 'sw[0]$tr_io' constrained to Bel 'X13/Y0/PIOA'.
Info: pin 'sw[1]$tr_io' constrained to Bel 'X13/Y0/PIOB'.
Info: pin 'sw[2]$tr_io' constrained to Bel 'X9/Y0/PIOB'.
Info: pin 'sw[3]$tr_io' constrained to Bel 'X9/Y0/PIOA'.
Info: pin 'sd_clk$tr_io' constrained to Bel 'X0/Y26/PIOC'.
Info: pin 'sd_cmd$tr_io' constrained to Bel 'X0/Y32/PIOB'.
Info: pin 'oled_resn$tr_io' constrained to Bel 'X0/Y47/PIOB'.
Info: pin 'gp[0]$tr_io' constrained to Bel 'X29/Y0/PIOA'.
Info: pin 'gp[1]$tr_io' constrained to Bel 'X27/Y0/PIOA'.
Info: pin 'gp[2]$tr_io' constrained to Bel 'X24/Y0/PIOA'.
Info: pin 'gp[3]$tr_io' constrained to Bel 'X22/Y0/PIOA'.
Info: pin 'gp[4]$tr_io' constrained to Bel 'X18/Y0/PIOA'.
Info: pin 'gp[5]$tr_io' constrained to Bel 'X15/Y0/PIOA'.
Info: pin 'gp[6]$tr_io' constrained to Bel 'X11/Y0/PIOA'.
Info: pin 'gp[7]$tr_io' constrained to Bel 'X4/Y0/PIOA'.
Info: pin 'gp[8]$tr_io' constrained to Bel 'X0/Y2/PIOA'.
Info: pin 'gp[9]$tr_io' constrained to Bel 'X0/Y14/PIOA'.
Info: pin 'gp[10]$tr_io' constrained to Bel 'X0/Y5/PIOA'.
Info: pin 'gp[12]$tr_io' constrained to Bel 'X0/Y23/PIOA'.
Info: pin 'gp[13]$tr_io' constrained to Bel 'X0/Y20/PIOA'.
Info: pin 'gp[14]$tr_io' constrained to Bel 'X72/Y47/PIOA'.
Info: pin 'gp[15]$tr_io' constrained to Bel 'X72/Y35/PIOA'.
Info: pin 'gp[16]$tr_io' constrained to Bel 'X72/Y32/PIOA'.
Info: pin 'gp[17]$tr_io' constrained to Bel 'X72/Y29/PIOA'.
Info: pin 'gp[18]$tr_io' constrained to Bel 'X72/Y11/PIOA'.
Info: pin 'gp[19]$tr_io' constrained to Bel 'X72/Y8/PIOA'.
Info: pin 'gp[20]$tr_io' constrained to Bel 'X72/Y5/PIOA'.
Info: pin 'gp[21]$tr_io' constrained to Bel 'X72/Y2/PIOA'.
Info: pin 'gp[22]$tr_io' constrained to Bel 'X51/Y0/PIOA'.
Info: pin 'gp[23]$tr_io' constrained to Bel 'X60/Y0/PIOA'.
Info: pin 'gp[24]$tr_io' constrained to Bel 'X58/Y0/PIOA'.
Info: pin 'gp[25]$tr_io' constrained to Bel 'X49/Y0/PIOA'.
Info: pin 'gp[26]$tr_io' constrained to Bel 'X42/Y0/PIOA'.
Info: pin 'gp[27]$tr_io' constrained to Bel 'X44/Y0/PIOA'.
Info: pin 'gn[0]$tr_io' constrained to Bel 'X29/Y0/PIOB'.
Info: pin 'gn[1]$tr_io' constrained to Bel 'X27/Y0/PIOB'.
Info: pin 'gn[2]$tr_io' constrained to Bel 'X24/Y0/PIOB'.
Info: pin 'gn[3]$tr_io' constrained to Bel 'X22/Y0/PIOB'.
Info: pin 'gn[4]$tr_io' constrained to Bel 'X18/Y0/PIOB'.
Info: pin 'gn[5]$tr_io' constrained to Bel 'X15/Y0/PIOB'.
Info: pin 'gn[6]$tr_io' constrained to Bel 'X11/Y0/PIOB'.
Info: pin 'gn[7]$tr_io' constrained to Bel 'X4/Y0/PIOB'.
Info: pin 'gn[8]$tr_io' constrained to Bel 'X0/Y2/PIOB'.
Info: pin 'gn[9]$tr_io' constrained to Bel 'X0/Y14/PIOB'.
Info: pin 'gn[10]$tr_io' constrained to Bel 'X0/Y5/PIOB'.
Info: pin 'gn[11]$tr_io' constrained to Bel 'X0/Y11/PIOB'.
Info: pin 'gn[12]$tr_io' constrained to Bel 'X0/Y23/PIOB'.
Info: pin 'gn[13]$tr_io' constrained to Bel 'X0/Y20/PIOB'.
Info: pin 'gn[14]$tr_io' constrained to Bel 'X72/Y47/PIOB'.
Info: pin 'gn[15]$tr_io' constrained to Bel 'X72/Y35/PIOB'.
Info: pin 'gn[16]$tr_io' constrained to Bel 'X72/Y32/PIOB'.
Info: pin 'gn[17]$tr_io' constrained to Bel 'X72/Y29/PIOB'.
Info: pin 'gn[18]$tr_io' constrained to Bel 'X72/Y11/PIOB'.
Info: pin 'gn[19]$tr_io' constrained to Bel 'X72/Y8/PIOB'.
Info: pin 'gn[20]$tr_io' constrained to Bel 'X72/Y5/PIOB'.
Info: pin 'gn[21]$tr_io' constrained to Bel 'X72/Y2/PIOB'.
Info: pin 'gn[22]$tr_io' constrained to Bel 'X51/Y0/PIOB'.
Info: pin 'gn[23]$tr_io' constrained to Bel 'X60/Y0/PIOB'.
Info: pin 'gn[24]$tr_io' constrained to Bel 'X58/Y0/PIOB'.
Info: pin 'gn[25]$tr_io' constrained to Bel 'X49/Y0/PIOB'.
Info: pin 'gn[26]$tr_io' constrained to Bel 'X42/Y0/PIOB'.
Info: pin 'gn[27]$tr_io' constrained to Bel 'X44/Y0/PIOB'.
Info: pin 'audio_l[0]$tr_io' constrained to Bel 'X0/Y8/PIOA'.
Info: pin 'audio_l[1]$tr_io' constrained to Bel 'X0/Y8/PIOD'.
Info: pin 'audio_l[2]$tr_io' constrained to Bel 'X0/Y8/PIOC'.
Info: pin 'audio_l[3]$tr_io' constrained to Bel 'X0/Y5/PIOD'.
Info: pin 'audio_r[0]$tr_io' constrained to Bel 'X0/Y5/PIOC'.
Info: pin 'audio_r[1]$tr_io' constrained to Bel 'X0/Y2/PIOC'.
Info: pin 'audio_r[2]$tr_io' constrained to Bel 'X0/Y8/PIOB'.
Info: pin 'audio_r[3]$tr_io' constrained to Bel 'X0/Y2/PIOD'.
Info: pin 'audio_v[0]$tr_io' constrained to Bel 'X0/Y20/PIOC'.
Info: pin 'audio_v[1]$tr_io' constrained to Bel 'X0/Y23/PIOC'.
Info: pin 'audio_v[2]$tr_io' constrained to Bel 'X0/Y11/PIOD'.
Info: pin 'audio_v[3]$tr_io' constrained to Bel 'X0/Y11/PIOC'.
Info: pin 'sd_cdn$tr_io' constrained to Bel 'X0/Y38/PIOB'.
Info: pin 'sd_wp$tr_io' constrained to Bel 'X0/Y38/PIOD'.
Info: pin 'ftdi_rxd$tr_io' constrained to Bel 'X0/Y35/PIOC'.
Info: pin 'ftdi_txd$tr_io' constrained to Bel 'X0/Y44/PIOB'.
Info: pin 'led[0]$tr_io' constrained to Bel 'X0/Y14/PIOC'.
Info: pin 'led[1]$tr_io' constrained to Bel 'X0/Y14/PIOD'.
Info: pin 'led[2]$tr_io' constrained to Bel 'X0/Y17/PIOA'.
Info: pin 'led[3]$tr_io' constrained to Bel 'X0/Y17/PIOC'.
Info: pin 'led[4]$tr_io' constrained to Bel 'X0/Y17/PIOB'.
Info: pin 'led[5]$tr_io' constrained to Bel 'X0/Y23/PIOD'.
Info: pin 'led[6]$tr_io' constrained to Bel 'X0/Y17/PIOD'.
Info: pin 'led[7]$tr_io' constrained to Bel 'X0/Y20/PIOD'.
Info: pin 'oled_csn$tr_io' constrained to Bel 'X0/Y44/PIOA'.
Info: pin 'oled_clk$tr_io' constrained to Bel 'X0/Y47/PIOD'.
Info: pin 'oled_mosi$tr_io' constrained to Bel 'X0/Y47/PIOC'.
Info: pin 'oled_dc$tr_io' constrained to Bel 'X0/Y47/PIOA'.
Info: pin 'shutdown$tr_io' constrained to Bel 'X72/Y8/PIOC'.
Info: pin 'flash_holdn$tr_io' constrained to Bel 'X9/Y50/PIOA'.
Info: pin 'flash_wpn$tr_io' constrained to Bel 'X9/Y50/PIOB'.
Info: pin 'sd_d[0]$tr_io' constrained to Bel 'X0/Y29/PIOC'.
Info: pin 'sd_d[1]$tr_io' constrained to Bel 'X0/Y32/PIOC'.
Info: pin 'sd_d[2]$tr_io' constrained to Bel 'X0/Y32/PIOD'.
Info: pin 'sd_d[3]$tr_io' constrained to Bel 'X0/Y32/PIOA'.
Info: pin 'gp[11]$tr_io' constrained to Bel 'X0/Y11/PIOA'.
Info: Packing constants..
Info: Packing carries...
Info: Finding LUTFF pairs...
Info: Packing LUT5-7s...
Info: Finding LUT-LUT pairs...
Info: Packing paired LUTs into a SLICE...
Info: Packing unpaired LUTs into a SLICE...
Info: Packing unpaired FFs into a SLICE...
Info: Generating derived timing constraints...
Info: Promoting globals...
Info: Checksum: 0x0df84d85

Info: Annotating ports with timing budgets for target frequency 12.00 MHz
Info: Checksum: 0x4d9f2d27

Info: Device utilisation:
Info:          TRELLIS_SLICE:     4/12144     0%
Info:             TRELLIS_IO:   117/  196    59%
Info:                   DCCA:     0/   56     0%
Info:                 DP16KD:     0/   56     0%
Info:             MULT18X18D:     0/   28     0%
Info:                 ALU54B:     0/   14     0%
Info:                EHXPLLL:     0/    2     0%
Info:                EXTREFB:     0/    1     0%
Info:                   DCUA:     0/    1     0%
Info:              PCSCLKDIV:     0/    2     0%
Info:                IOLOGIC:     0/  128     0%
Info:               SIOLOGIC:     0/   68     0%
Info:                    GSR:     0/    1     0%
Info:                  JTAGG:     0/    1     0%
Info:                   OSCG:     0/    1     0%
Info:                  SEDGA:     0/    1     0%
Info:                    DTR:     0/    1     0%
Info:                USRMCLK:     0/    1     0%
Info:                CLKDIVF:     0/    4     0%
Info:              ECLKSYNCB:     0/    8     0%
Info:                DLLDELD:     0/    8     0%
Info:                 DDRDLL:     0/    4     0%
Info:                DQSBUFM:     0/    8     0%
Info:        TRELLIS_ECLKBUF:     0/    8     0%

Info: Placed 117 cells based on constraints.
Info: Creating initial analytic placement for 4 cells, random placement wirelen = 666.
Info:     at initial placer iter 0, wirelen = 326
Info:     at initial placer iter 1, wirelen = 326
Info:     at initial placer iter 2, wirelen = 326
Info:     at initial placer iter 3, wirelen = 326
Info: Running main analytical placer.
Info:     at iteration #1, type TRELLIS_SLICE: wirelen solved = 326, spread = 326, legal = 344; time = 0.00s
Info: HeAP Placer Time: 0.01s
Info:   of which solving equations: 0.00s
Info:   of which spreading cells: 0.00s
Info:   of which strict legalisation: 0.00s

Info: Running simulated annealing placer for refinement.
Info:   at iteration #1: temp = 0.000000, timing cost = 0, wirelen = 344
Info:   at iteration #2: temp = 0.000000, timing cost = 0, wirelen = 336
Info: SA placement time 0.00s
Warning: No clocks found in design

Info: Max delay <async> -> <async>: 9.60 ns

Info: Slack histogram:
Info:  legend: * represents 1 endpoint(s)
Info:          + represents [1,1) endpoint(s)
Info: [ 73737,  74178) |*
Info: [ 74178,  74619) |
Info: [ 74619,  75060) |
Info: [ 75060,  75501) |
Info: [ 75501,  75942) |
Info: [ 75942,  76383) |
Info: [ 76383,  76824) |
Info: [ 76824,  77265) |***
Info: [ 77265,  77706) |
Info: [ 77706,  78147) |
Info: [ 78147,  78588) |
Info: [ 78588,  79029) |
Info: [ 79029,  79470) |*
Info: [ 79470,  79911) |*
Info: [ 79911,  80352) |**
Info: [ 80352,  80793) |*
Info: [ 80793,  81234) |
Info: [ 81234,  81675) |
Info: [ 81675,  82116) |**
Info: [ 82116,  82557) |*
Info: Checksum: 0xebc6b755
Info: Routing globals...

Info: Routing..
Info: Setting up routing queue.
Info: Routing 32 arcs.
Info:            |   (re-)routed arcs  |   delta    | remaining
Info:    IterCnt |  w/ripup   wo/ripup |  w/r  wo/r |      arcs
Info:         32 |        0         32 |    0    32 |         0
Info: Routing complete.
Info: Route time 0.03s
Info: Checksum: 0x938da6c5
Warning: No clocks found in design

Info: Critical path report for cross-domain path '<async>' -> '<async>':
Info: curr total
Info:  0.0  0.0  Source btn[0]$tr_io.O
Info:  3.5  3.5    Net btn[0] budget 41.549000 ns (6,0) -> (2,39)
Info:                Sink $abc$245$auto$blifparse.cc:492:parse_blif$248_SLICE.C1
Info:  0.2  3.7  Source $abc$245$auto$blifparse.cc:492:parse_blif$248_SLICE.F1
Info:  1.2  4.9    Net wifi_gpio0 budget 41.548000 ns (2,39) -> (0,41)
Info:                Sink wifi_gpio0$tr_io.I
Info: 0.2 ns logic, 4.7 ns routing

Info: Max delay <async> -> <async>: 4.93 ns

Info: Slack histogram:
Info:  legend: * represents 1 endpoint(s)
Info:          + represents [1,1) endpoint(s)
Info: [ 78406,  78635) |*
Info: [ 78635,  78864) |
Info: [ 78864,  79093) |
Info: [ 79093,  79322) |*
Info: [ 79322,  79551) |
Info: [ 79551,  79780) |
Info: [ 79780,  80009) |*
Info: [ 80009,  80238) |
Info: [ 80238,  80467) |
Info: [ 80467,  80696) |*
Info: [ 80696,  80925) |
Info: [ 80925,  81154) |
Info: [ 81154,  81383) |*
Info: [ 81383,  81612) |**
Info: [ 81612,  81841) |*
Info: [ 81841,  82070) |*
Info: [ 82070,  82299) |
Info: [ 82299,  82528) |
Info: [ 82528,  82757) |*
Info: [ 82757,  82986) |**
3 warnings, 0 errors
ecppack ulx3s_out.config ulx3s.bit --idcode 0x21111043
../../bin/fujprog.exe ulx3s.bit
ULX2S / ULX3S JTAG programmer v 3.0.92 (built Feb 18 2019 10:55:47)
Using USB cable: ULX3S FPGA 12K v3.0.3
Programming: 100%
Completed in 19.02 seconds.
gojimmypi:/mnt/c/workspace/ulx3s-examples/passthru/OpenSource
$
```