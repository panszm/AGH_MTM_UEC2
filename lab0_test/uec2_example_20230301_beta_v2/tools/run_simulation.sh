#!/bin/bash
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


# ------------------------------------------------------------------------------
# Functions
# ------------------------------------------------------------------------------

function usage {
    echo "usage: $(basename "$0") [options]"
    echo "  options:"
    echo "    -g,  show gui (use with -t)"
    echo "    -l,  list available tests"
    echo "    -t   specify the test name"
    exit 1
}

# ------------------------------------------------------------------------------
# Arguments parsing and checking
# ------------------------------------------------------------------------------

if [[ $# -eq 0 ]]; then
    usage
fi

show_gui=0

while getopts aglrs:t: option; do
    case ${option} in
        g) show_gui=1;;
        l) list_available_test=1;;
        t) sim_module=${OPTARG};;
        *) usage;;
    esac
done

if [[ ${list_available_test} ]]; then
    ls -1 sim | grep -v 'build\|run_simulation.tcl'
    exit 0
fi


cd sim

# Clean all untracked files
git clean -fXd sim
# TODO moze lepiej tworzyc build niezaleznie w folderach danych modulow

vivado -mode tcl -source run_simulation.tcl -tclargs "${sim_module}" "${show_gui}"
rm vivado*.{jou,log}
