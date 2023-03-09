#Specify design files

# Specify .xdc files location             -- EDIT
read_xdc {
    constraints/basys3.xdc
}

# Specify verilog design files location   -- EDIT
read_verilog -sv {
    rtl/top.sv
    ../rtl/tiff_writer.sv
    ../rtl/vga_timing.sv
}

# Specify vhdl design files location      -- EDIT
#read_vhdl {
#    rtl/MouseCtl.vhd    
#    rtl/MouseDisplay.vhd
#}

# Specify files for memory initialization -- EDIT
#read_mem {
#    rtl/image_rom.data
#}

