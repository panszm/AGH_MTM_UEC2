$ROOT_DIR = Get-Location
[Environment]::SetEnvironmentVariable('ROOT_DIR', $ROOT_DIR, 'User')
[Environment]::SetEnvironmentVariable('PATH', "tools;" + $env:PATH, 'User')