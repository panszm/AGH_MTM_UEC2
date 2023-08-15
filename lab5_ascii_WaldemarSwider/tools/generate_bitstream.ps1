git clean -fXd fpga

Set-Location fpga
vivado -mode tcl -source scripts/generate_bitstream.tcl

Get-ChildItem build -Recurse -Include "*.bit" | Copy-Item -Destination results

# & "$PSScriptRoot\warning_summary.ps1"
