# Copyright (C) 2021  AGH University of Science and Technology
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.



#Project name                                 -- EDIT  TODO: dac to do design_files albo do .sh
set project_name example_project
# Top module name                             -- EDIT  TODO: dac to do design_files albo do .sh
set top_module top
# FPGA device
set target xc7a35tcpg236-1
# Design files
set design_files scripts/design_files.tcl


# Create project
proc create_new_project {project_name target top_module files} {
    file mkdir build
    create_project ${project_name} build -part ${target} -force
    
    # Run script reading sources
    source $files

    set_property top ${top_module} [current_fileset]
    update_compile_order -fileset sources_1
}


# Generate bitstream
proc generate_bitstream {} {
    # Run synthesis
    reset_run synth_1
    launch_runs synth_1 -jobs 8
    wait_on_run synth_1
    
    # Run implemenatation up to bitstream generation
    launch_runs impl_1 -to_step write_bitstream -jobs 8
    wait_on_run impl_1
}


## MAIN
create_new_project $project_name $target $top_module $design_files   
generate_bitstream
exit
