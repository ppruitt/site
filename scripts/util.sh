# Utility functions
. config.sh

# Display message with timestamp
log()
{
   echo "[`date -Iseconds`] $*"
}

# Check for 
checkroot()
{
    if [ ${EUID} -ne 0 ] ; then
        log "You need to be root in order to run this script."
        exit 1
    fi
}


