#Specify design files

# Specify .xdc files location             -- EDIT
read_xdc {
    constraints/top_example_basys3.xdc
}

# Specify verilog design files location   -- EDIT
read_verilog -sv {
    rtl/top_example_basys3.sv
    ../rtl/top_example.sv
    ../rtl/and2.sv
    ../rtl/xor2.sv
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

