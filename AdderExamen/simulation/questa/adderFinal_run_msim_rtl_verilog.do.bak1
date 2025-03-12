transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/ronma/OneDrive/Escritorio/logprogramable/clock\ divider {C:/Users/ronma/OneDrive/Escritorio/logprogramable/clock divider/clkdiv.v}
vlog -vlog01compat -work work +incdir+C:/Users/ronma/OneDrive/Escritorio/logprogramable/Adder_1 {C:/Users/ronma/OneDrive/Escritorio/logprogramable/Adder_1/decoder.v}
vlog -vlog01compat -work work +incdir+C:/Users/ronma/OneDrive/Escritorio/logprogramable/FinalADDER {C:/Users/ronma/OneDrive/Escritorio/logprogramable/FinalADDER/adderFinal.v}

vlog -vlog01compat -work work +incdir+C:/Users/ronma/OneDrive/Escritorio/logprogramable/FinalADDER {C:/Users/ronma/OneDrive/Escritorio/logprogramable/FinalADDER/adderFinal_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L fiftyfivenm_ver -L rtl_work -L work -voptargs="+acc"  adderFinal_tb

add wave *
view structure
view signals
run -all
