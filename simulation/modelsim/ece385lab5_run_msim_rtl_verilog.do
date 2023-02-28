transcript on
if ![file isdirectory verilog_libs] {
	file mkdir verilog_libs
}

vlib verilog_libs/altera_ver
vmap altera_ver ./verilog_libs/altera_ver
vlog -vlog01compat -work altera_ver {/opt/intelFPGA_lite/22.1std/quartus/eda/sim_lib/altera_primitives.v}

vlib verilog_libs/lpm_ver
vmap lpm_ver ./verilog_libs/lpm_ver
vlog -vlog01compat -work lpm_ver {/opt/intelFPGA_lite/22.1std/quartus/eda/sim_lib/220model.v}

vlib verilog_libs/sgate_ver
vmap sgate_ver ./verilog_libs/sgate_ver
vlog -vlog01compat -work sgate_ver {/opt/intelFPGA_lite/22.1std/quartus/eda/sim_lib/sgate.v}

vlib verilog_libs/altera_mf_ver
vmap altera_mf_ver ./verilog_libs/altera_mf_ver
vlog -vlog01compat -work altera_mf_ver {/opt/intelFPGA_lite/22.1std/quartus/eda/sim_lib/altera_mf.v}

vlib verilog_libs/altera_lnsim_ver
vmap altera_lnsim_ver ./verilog_libs/altera_lnsim_ver
vlog -sv -work altera_lnsim_ver {/opt/intelFPGA_lite/22.1std/quartus/eda/sim_lib/altera_lnsim.sv}

vlib verilog_libs/fiftyfivenm_ver
vmap fiftyfivenm_ver ./verilog_libs/fiftyfivenm_ver
vlog -vlog01compat -work fiftyfivenm_ver {/opt/intelFPGA_lite/22.1std/quartus/eda/sim_lib/fiftyfivenm_atoms.v}
vlog -vlog01compat -work fiftyfivenm_ver {/opt/intelFPGA_lite/22.1std/quartus/eda/sim_lib/mentor/fiftyfivenm_atoms_ncrypt.v}

if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -sv -work work +incdir+/home/user/Documents/ece385/ece385lab5 {/home/user/Documents/ece385/ece385lab5/HexDriver.sv}
vlog -sv -work work +incdir+/home/user/Documents/ece385/ece385lab5 {/home/user/Documents/ece385/ece385lab5/register.sv}
vlog -sv -work work +incdir+/home/user/Documents/ece385/ece385lab5 {/home/user/Documents/ece385/ece385lab5/alu.sv}
vlog -sv -work work +incdir+/home/user/Documents/ece385/ece385lab5 {/home/user/Documents/ece385/ece385lab5/multiplexer.sv}
vlog -sv -work work +incdir+/home/user/Documents/ece385/ece385lab5 {/home/user/Documents/ece385/ece385lab5/datapath.sv}
vlog -sv -work work +incdir+/home/user/Documents/ece385/ece385lab5 {/home/user/Documents/ece385/ece385lab5/test_memory.sv}
vlog -sv -work work +incdir+/home/user/Documents/ece385/ece385lab5 {/home/user/Documents/ece385/ece385lab5/synchronizers.sv}
vlog -sv -work work +incdir+/home/user/Documents/ece385/ece385lab5 {/home/user/Documents/ece385/ece385lab5/SLC3_2.sv}
vlog -sv -work work +incdir+/home/user/Documents/ece385/ece385lab5 {/home/user/Documents/ece385/ece385lab5/Mem2IO.sv}
vlog -sv -work work +incdir+/home/user/Documents/ece385/ece385lab5 {/home/user/Documents/ece385/ece385lab5/ISDU.sv}
vlog -sv -work work +incdir+/home/user/Documents/ece385/ece385lab5 {/home/user/Documents/ece385/ece385lab5/slc3.sv}
vlog -sv -work work +incdir+/home/user/Documents/ece385/ece385lab5 {/home/user/Documents/ece385/ece385lab5/memory_contents.sv}
vlog -sv -work work +incdir+/home/user/Documents/ece385/ece385lab5 {/home/user/Documents/ece385/ece385lab5/slc3_testtop.sv}

vlog -sv -work work +incdir+/home/user/Documents/ece385/ece385lab5 {/home/user/Documents/ece385/ece385lab5/testbench.sv}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  testbench_cp1

add wave *
view structure
view signals
run 2000 ns
