#!/usr/bin/env bash
###############################################################################
# Creates openvpn keys for a client machine
# bundles required files into an archive
###############################################################################
. util.sh

checkroot

CLIENT_CONF_FILE="../conf/etc/openvpn/client.conf"
CLIENT_NAME=${1}
CLIENT_TMP_DIR="${TEMP}/${1}"
CLIENT_TARFILE="${EASY_RSA_DIR}/${CLIENT_NAME}.tar.xz"

if [ -z "${CLIENT_NAME}" ] ; then
    log "Usage: ${0} client_name"
    exit 1
fi

pushd ${EASY_RSA_DIR}
. vars
./build-key-pass ${1}
popd 

if [ -d $CLIENT_TMP_DIR ] ; then
   log "Removing tmp dir ${CLIENT_TMP_DIR}"
   rm -rf ${CLIENT_TMP_DIR}
fi

mkdir -p ${CLIENT_TMP_DIR} ||
{
    log "Failed to create client dir."
    exit 2
}

cp ${OPENVPN_DEST_DIR}/ta.key \
   ${EASY_RSA_KEY_DIR}/${CLIENT_NAME}.crt \
   ${EASY_RSA_KEY_DIR}/${CLIENT_NAME}.key \
   ${EASY_RSA_KEY_DIR}/ca.crt \
   ${CLIENT_TMP_DIR}


if [ ! -f ${CLIENT_CONF_FILE} ] ; then
   log "${CLIENT_CONF_FILE} does not exist."
   exit 3
fi

cat ${CLIENT_CONF_FILE} | \
   sed -r -e "s/(client)\.(crt|key)/${CLIENT_NAME}.\2/g" \
   > "${CLIENT_TMP_DIR}/${CLIENT_NAME}.conf"

if [ $? -ne 0 ] ; then 
    log "Failed to install client openvpn config file."
    exit 3
fi

tar -C `dirname ${CLIENT_TMP_DIR}` -cJvf ${CLIENT_TARFILE} ${CLIENT_NAME} ||
{
   log "Failed to create key tar file."
   exit 4
}

log "Created keys in ${CLIENT_TARFILE}"

# clean up
rm -rf ${CLIENT_TMP_DIR} ||
{
    log "Failed to cleanup tmp dir: $CLIENT_TMP_DIR}"
    exit 4
}
