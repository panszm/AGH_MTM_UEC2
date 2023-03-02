#!/bin/bash

# Clean all untracked files
git clean -fXd fpga

# Run Vivado and generate bitstream
cd fpga
vivado -mode tcl -source scripts/generate_bitstream.tcl
cd ${ROOT_DIR}

# Copy bitstream to results
find fpga/build -name "*.bit" -exec cp {} results/ \;

# Copy warnings and errors to single log file in results
./tools/warning_summary.sh
