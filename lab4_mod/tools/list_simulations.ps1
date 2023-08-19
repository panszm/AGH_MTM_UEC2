Get-ChildItem sim | Where-Object { $_.Name -notmatch 'build|run_simulation.tcl' } | ForEach-Object { $_.Name }
