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



# Bitstream location
set bitstream_file [lindex ${argv} 0]


# Load bitstream to FPGA
proc program_fpga {bitstream_file} {
    if {[file exists $bitstream_file] == 0} {
        puts "ERROR: Bitstream not found"
        exit 1
    } else {
        open_hw_manager
        connect_hw_server
        current_hw_target [get_hw_targets *]
        open_hw_target
        current_hw_device [lindex [get_hw_devices] 0]
        refresh_hw_device -update_hw_probes false [lindex [get_hw_devices] 0]

        set_property PROBES.FILE {} [lindex [get_hw_devices] 0]
        set_property FULL_PROBES.FILE {} [lindex [get_hw_devices] 0]
        set_property PROGRAM.FILE ${bitstream_file} [lindex [get_hw_devices] 0]

        program_hw_devices [lindex [get_hw_devices] 0]
        refresh_hw_device [lindex [get_hw_devices] 0]
    }
}


## MAIN
if {${argc} != 1} {
    puts "ERROR: Bitsream not specified"
    exit 1
} else {
    program_fpga $bitstream_file
    exit
}
