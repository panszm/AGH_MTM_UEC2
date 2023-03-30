git clean -fXd fpga

Set-Location fpga
vivado -mode tcl -source fpga/scripts/generate_bitstream.tcl
Set-Location $ROOT_DIR

Get-ChildItem fpga/build -Recurse -Include "*.bit" | Copy-Item -Destination results

& "$PSScriptRoot\warning_summary.ps1"
