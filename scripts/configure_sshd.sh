#!/usr/bin/env bash
###############################################################################
# Configures SSHD to an alternate port
# and disables password authentication
###############################################################################
. util.sh

checkroot

log "Backing up sshd configuration."
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.orig || 
{
    log "Failed to backup sshd_config."
    exit 3
}


# Alter SSH port to 
# Move SSH port to make it the slightest bit more difficult for the bots
log "Fixing sshd_config to move port, turn off password authentication"

sed -r -i -e "s/^\s\*Port\s+[0-9]+/Port ${SSH_PORT}/g" \
          -e 's/^(\s*#?)(\s*PasswordAuthentication\s+[Yy][eE][sS])/#\2\nPasswordAuthentication no/g' \
          -e 's/^(\s*#?)(\s*RSAAuthentication\s+[Nn][oO])/#\2\nRSAAuthentication yes/g' \
          -e 's/^(\s*#?)(\s*PubkeyAuthentication\s+[Nn][oO])/#\2\nPubkeyAuthentication yes/g' \
           /etc/ssh/sshd_config || 
{
    log "Failed to alter sshd listening port"
    exit 4
}

service ssh restart
