#!/bin/bash
###############################################################################
# Configures an ubuntu server (currently v13.04) for application service duty
###############################################################################
PACKAGES="emacs24-nox \
         git \
         nginx-full \
         tmux \
         openvpn"

# Display message with timestamp
log()
{
   echo "[`date -Iseconds`] $*"
}

if [ ${EUID} -ne 0 ] ; then
    log "You need to be root in order to run this script."
    exit 1
fi

# Install requisite packages
apt-get install ${PACKAGES} || 
{ 
    log "Failed to install packages"
    exit 2
}

log "Backing up sshd configuration."
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.orig || 
{
    log "Failed to backup sshd_config."
    exit 3
}

# Move SSH port to make it the slightest bit more difficult for the bots
log "Changing sshd listening port to 22760"
sed -r -i -e 's/^\s*Port\s+[0-9]+/Port 22760/g' /etc/ssh/sshd_config || 
{
    log "Failed to change sshd listening port"
    exit 4
}

log "Disabling SSH Password authentication."
sed -r -i -e 's/^\s*PasswordAuthentication\s+([Yy][eE][sS])+/PasswordAuthentication no/g' /etc/ssh/sshd_config || 
{
    log "Failed to change sshd listening port"
    exit 4
}




