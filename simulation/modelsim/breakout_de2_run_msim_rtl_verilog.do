transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+N:/Final\ Project\ 1\ VGA/Final\ Project\ 4-28/verilog/keyboard {N:/Final Project 1 VGA/Final Project 4-28/verilog/keyboard/PS2_Controller.v}
vlog -vlog01compat -work work +incdir+N:/Final\ Project\ 1\ VGA/Final\ Project\ 4-28/verilog/keyboard {N:/Final Project 1 VGA/Final Project 4-28/verilog/keyboard/keycode_recognizer.v}
vlog -vlog01compat -work work +incdir+N:/Final\ Project\ 1\ VGA/Final\ Project\ 4-28/verilog/keyboard {N:/Final Project 1 VGA/Final Project 4-28/verilog/keyboard/Altera_UP_PS2_Data_In.v}
vlog -vlog01compat -work work +incdir+N:/Final\ Project\ 1\ VGA/Final\ Project\ 4-28/verilog/keyboard {N:/Final Project 1 VGA/Final Project 4-28/verilog/keyboard/Altera_UP_PS2_Command_Out.v}
vlog -vlog01compat -work work +incdir+N:/Final\ Project\ 1\ VGA/Final\ Project\ 4-28/audio {N:/Final Project 1 VGA/Final Project 4-28/audio/square_wave_osc.v}
vlog -vlog01compat -work work +incdir+N:/Final\ Project\ 1\ VGA/Final\ Project\ 4-28/audio {N:/Final Project 1 VGA/Final Project 4-28/audio/I2C_Controller.v}
vlog -vlog01compat -work work +incdir+N:/Final\ Project\ 1\ VGA/Final\ Project\ 4-28/audio {N:/Final Project 1 VGA/Final Project 4-28/audio/avconf.v}
vlog -vlog01compat -work work +incdir+N:/Final\ Project\ 1\ VGA/Final\ Project\ 4-28/audio {N:/Final Project 1 VGA/Final Project 4-28/audio/Audio_Controller.v}
vlog -vlog01compat -work work +incdir+N:/Final\ Project\ 1\ VGA/Final\ Project\ 4-28/audio {N:/Final Project 1 VGA/Final Project 4-28/audio/Audio_Clock.v}
vlog -vlog01compat -work work +incdir+N:/Final\ Project\ 1\ VGA/Final\ Project\ 4-28/audio {N:/Final Project 1 VGA/Final Project 4-28/audio/Altera_UP_SYNC_FIFO.v}
vlog -vlog01compat -work work +incdir+N:/Final\ Project\ 1\ VGA/Final\ Project\ 4-28/audio {N:/Final Project 1 VGA/Final Project 4-28/audio/Altera_UP_Clock_Edge.v}
vlog -vlog01compat -work work +incdir+N:/Final\ Project\ 1\ VGA/Final\ Project\ 4-28/audio {N:/Final Project 1 VGA/Final Project 4-28/audio/Altera_UP_Audio_Out_Serializer.v}
vlog -vlog01compat -work work +incdir+N:/Final\ Project\ 1\ VGA/Final\ Project\ 4-28/audio {N:/Final Project 1 VGA/Final Project 4-28/audio/Altera_UP_Audio_In_Deserializer.v}
vlog -vlog01compat -work work +incdir+N:/Final\ Project\ 1\ VGA/Final\ Project\ 4-28/audio {N:/Final Project 1 VGA/Final Project 4-28/audio/Altera_UP_Audio_Bit_Counter.v}
vlog -vlog01compat -work work +incdir+N:/Final\ Project\ 1\ VGA/Final\ Project\ 4-28/verilog/vga_adapter {N:/Final Project 1 VGA/Final Project 4-28/verilog/vga_adapter/vga_pll.v}
vlog -vlog01compat -work work +incdir+N:/Final\ Project\ 1\ VGA/Final\ Project\ 4-28/verilog/vga_adapter {N:/Final Project 1 VGA/Final Project 4-28/verilog/vga_adapter/vga_controller.v}
vlog -vlog01compat -work work +incdir+N:/Final\ Project\ 1\ VGA/Final\ Project\ 4-28/verilog/vga_adapter {N:/Final Project 1 VGA/Final Project 4-28/verilog/vga_adapter/vga_address_translator.v}
vlog -vlog01compat -work work +incdir+N:/Final\ Project\ 1\ VGA/Final\ Project\ 4-28/verilog/vga_adapter {N:/Final Project 1 VGA/Final Project 4-28/verilog/vga_adapter/vga_adapter.v}
vlog -vlog01compat -work work +incdir+N:/Final\ Project\ 1\ VGA/Final\ Project\ 4-28/verilog {N:/Final Project 1 VGA/Final Project 4-28/verilog/processor.v}
vlog -vlog01compat -work work +incdir+N:/Final\ Project\ 1\ VGA/Final\ Project\ 4-28/verilog {N:/Final Project 1 VGA/Final Project 4-28/verilog/image_ram.v}
vlog -vlog01compat -work work +incdir+N:/Final\ Project\ 1\ VGA/Final\ Project\ 4-28/verilog {N:/Final Project 1 VGA/Final Project 4-28/verilog/datapath.v}
vlog -vlog01compat -work work +incdir+N:/Final\ Project\ 1\ VGA/Final\ Project\ 4-28/verilog {N:/Final Project 1 VGA/Final Project 4-28/verilog/controller.v}
vlog -vlog01compat -work work +incdir+N:/Final\ Project\ 1\ VGA/Final\ Project\ 4-28/verilog {N:/Final Project 1 VGA/Final Project 4-28/verilog/breakout_DE2.v}
vlog -vlog01compat -work work +incdir+N:/Final\ Project\ 1\ VGA/Final\ Project\ 4-28/verilog {N:/Final Project 1 VGA/Final Project 4-28/verilog/audio_top.v}

vlog -vlog01compat -work work +incdir+N:/Final\ Project\ 1\ VGA/Final\ Project\ 4-28/verilog {N:/Final Project 1 VGA/Final Project 4-28/verilog/processor_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  processor_tb

add wave *
view structure
view signals
run -all
