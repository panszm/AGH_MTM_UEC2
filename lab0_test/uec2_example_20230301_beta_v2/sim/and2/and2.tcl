# Specify files for test: top_example
    
# Specify verilog design files location   -- EDIT
#read_verilog {
#    ../src/rtl/top_example.v
#}

# Specify vhdl design files location      -- EDIT
#read_vhdl {
#    rtl/MouseCtl.vhd    
#    rtl/MouseDisplay.vhd
#}

# Specify files for memory initialization -- EDIT
#read_mem {
#    rtl/image_rom.data
#}

# Specify simulation files location       -- EDIT
add_files -fileset sim_1 {
    and2/and2_tb.sv
    ../rtl/and2.sv
}

