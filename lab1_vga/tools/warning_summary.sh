#!/bin/bash
# Extract warnings and errors from synthesis and implementation to the single log file

# Run from top directory

PROJECT_PATH=fpga/build
LOG_FILE=results/warning_summary.log

SYNTH_IGNORE="29-345"
IMPL_IGNORE="pipelining"
    
printf '%b\n' 'Warnings, critical warnings and errors from synthesis and implementation\n' > $LOG_FILE 
printf '%b\n\n' "Created: $(date '+%c')" >> $LOG_FILE

printf '%b\n' '----SYNTHESIS----' >> $LOG_FILE
SYNTH_LOG=$PROJECT_PATH/*.runs/synth_1/runme.log
if compgen -G "$SYNTH_LOG" > /dev/null
then
    if ! grep -v $SYNTH_IGNORE $SYNTH_LOG | grep 'CRITICAL\|WARNING\|ERROR' >> $LOG_FILE
    then
        printf 'CLEAR :)\n' >> $LOG_FILE
    fi  
else
    printf 'No synthesis log file found!\n' >> $LOG_FILE
fi  

printf '%b\n' '\n----IMPLEMENTATION----' >> $LOG_FILE
IMPL_LOG=$PROJECT_PATH/*.runs/impl_1/runme.log
if compgen -G "$IMPL_LOG" > /dev/null
then
    if ! grep -v $IMPL_IGNORE $IMPL_LOG | grep 'CRITICAL\|WARNING\|ERROR' >> $LOG_FILE
    then
        printf 'CLEAR :)\n' >> $LOG_FILE
    fi  
else
    printf 'No implementation log file found!\n' >> $LOG_FILE
fi  

sed -i -r "s/\/home\/([a-zA-Z0-9\_]*\/)*$(basename "$PWD")\///" $LOG_FILE
