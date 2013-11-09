#!/usr/bin/env bash
###############################################################################
# Configures OpenVPN
###############################################################################
. util.sh

checkroot

SRC_CONF=../conf/etc/openvpn/server.conf
TA="${OPENVPN_DEST_DIR}/ta.key"
DH="${OPENVPN_DEST_DIR}/dh2048.pem"
VARS_SRC=../conf/etc/openvpn/easy-rsa/vars

log "Installing openvpn configuration in ${OPENVPN_DEST_DIR}"
install -v --backup -g root -o root -m 600 -p -t ${OPENVPN_DEST_DIR} ${SRC_CONF} ||
{
    log "Failed to install openvpn configuration."
    exit 2
}

# Generate DH key if needed
if [ ! -f ${DH} ] ; then 
    log "Creating ${DH}"
    openssl dhparam -out ${DH} 2048 ||
    {
        log "Failed to create ${DH}"
        exit 3
    }
else
    log "${DH} exists. Not generating."
fi

# Generate HMAC key if needed
if [ ! -f ${TA} ] ; then 
    log "Creating ${TA}"
    openvpn --genkey --secret ${TA} ||
    {
        log "Failed to create ${TA}"
        exit 4
    }
else
    log "${TA} exists. Not generating."
fi

if [ ! -d ${EASY_RSA_DIR} ] ; then
   log "Installing easy-rsa from ${EASY_RSA_SRC_DIR}"

   [ -d ${EASY_RSA_SRC_DIR} ] || 
   { 
       log "Can't find easy-rsa." 
       exit 5 
   }

   # Install easy-rsa
   cp -dpr ${EASY_RSA_SRC_DIR} ${EASY_RSA_DIR} ||
   { 
       log "Failed to install easy-rsa."
       exit 6
   }   

   chmod 700 ${EASY_RSA_DIR} || 
   { 
       log "Failed to fix perms on ${EASY_RSA_DIR}"; exit 6; 
   }

   install -v --backup -g root -o root -m 0600 -p -t ${EASY_RSA_DIR} ${VARS_SRC} ||
   {
       log "Failed to install vars file."
       exit 7
   }
else
   log "easy-rsa exists. Not installing."  
fi

if [ ! -f ${OPENVPN_DEST_DIR}/server.key ] ; then
    log "server key does not exist. Creating CA."
    pushd ${EASY_RSA_DIR}
.   ./vars
    ./clean-all
    ./build-ca
    ./build-key-server server
    popd

    cp ${EASY_RSA_DIR}/keys/server.crt \
       ${EASY_RSA_DIR}/keys/server.key \
       ${EASY_RSA_DIR}/keys/ca.crt \
       ${OPENVPN_DEST_DIR} || 
    {
        log "Failed to install openvpn keys."
        exit 8
    }
else
    log "Server key exists. Not going to mess with them."
fi   


