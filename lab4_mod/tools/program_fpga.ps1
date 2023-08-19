$bitstream_file = Get-ChildItem -Path ".\results" -Filter "*.bit" -Recurse | Select-Object -First 1
Write-Host $bitstream_file.FullName
& vivado -mode tcl -source fpga/scripts/program_fpga.tcl -tclargs $bitstream_file.FullName
Remove-Item vivado*.jou, vivado*.log

