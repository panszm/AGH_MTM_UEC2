git clean -fXd
$source_path = $args[0]
Set-Location sim
& vivado -mode tcl -source run_simulation.tcl -tclargs $source_path 0
Set-Location ..
