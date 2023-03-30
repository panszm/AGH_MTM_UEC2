$PROJECT_PATH="fpga/build"
$LOG_FILE="results/warning_summary.log"

$SYNTH_IGNORE="29-345"
$IMPL_IGNORE="pipelining"

"Warnings, critical warnings and errors from synthesis and implementation" | Out-File -FilePath $LOG_FILE -Encoding ascii
"`nCreated: $(Get-Date -Format 'g')" | Out-File -FilePath $LOG_FILE -Encoding ascii -Append

"----SYNTHESIS----" | Out-File -FilePath $LOG_FILE -Encoding ascii -Append
$SYNTH_LOG=Get-ChildItem "$PROJECT_PATH/*.runs/synth_1/runme.log"
if ($SYNTH_LOG -ne $null)
{
    if ((Get-Content $SYNTH_LOG.FullName | Select-String -Pattern $SYNTH_IGNORE -NotMatch) -match 'CRITICAL|WARNING|ERROR')
    {
        "CLEAR :)" | Out-File -FilePath $LOG_FILE -Encoding ascii -Append
    }
}
else
{
    "No synthesis log file found!" | Out-File -FilePath $LOG_FILE -Encoding ascii -Append
}

"`n----IMPLEMENTATION----" | Out-File -FilePath $LOG_FILE -Encoding ascii -Append
$IMPL_LOG=Get-ChildItem "$PROJECT_PATH/*.runs/impl_1/runme.log"
if ($IMPL_LOG -ne $null)
{
    if ((Get-Content $IMPL_LOG.FullName | Select-String -Pattern $IMPL_IGNORE -NotMatch) -match 'CRITICAL|WARNING|ERROR')
    {
        "CLEAR :)" | Out-File -FilePath $LOG_FILE -Encoding ascii -Append
    }
}
else
{
    "No implementation log file found!" | Out-File -FilePath $LOG_FILE -Encoding ascii -Append
}

(Get-Content $LOG_FILE) -replace "/home/([a-zA-Z0-9_]*\/)*$(Split-Path -Leaf $PWD)/", "" | Set-Content $LOG_FILE
