transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/ronma/OneDrive/Escritorio/logprogramable/Adder_1 {C:/Users/ronma/OneDrive/Escritorio/logprogramable/Adder_1/decoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/ronma/OneDrive/Escritorio/logprogramable {C:/Users/ronma/OneDrive/Escritorio/logprogramable/max_bcd_wrapper.v}
vlog -vlog01compat -work work +incdir+C:/Users/ronma/OneDrive/Escritorio/logprogramable/FrecuenciometroFPGA {C:/Users/ronma/OneDrive/Escritorio/logprogramable/FrecuenciometroFPGA/Frecuenciometro.v}

vlog -vlog01compat -work work +incdir+C:/Users/ronma/OneDrive/Escritorio/logprogramable/FrecuenciometroFPGA/output_files {C:/Users/ronma/OneDrive/Escritorio/logprogramable/FrecuenciometroFPGA/output_files/Frecuenciometro_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  Frecuenciometro_tb

add wave *
view structure
view signals
run -all
