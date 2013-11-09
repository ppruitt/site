#!/bin/bash
###############################################################################
# Configures an ubuntu server (currently v13.04) for application service duty
###############################################################################
PACKAGES="emacs24-nox \
         git \
         nginx-full \
         tmux \
         openvpn \
         python-pillow \
         python-virtualenv \
         python-pip \
         postgresql \
         python-psycopg2"

. util.sh

# Ensure that we have root privileges
checkroot

# Install requisite packages
apt-get install ${PACKAGES} || 
{ 
    log "Failed to install packages"
    exit 2
}





