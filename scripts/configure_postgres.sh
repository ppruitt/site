#!/usr/bin/env bash
###############################################################################
# Configure Postgresql
###############################################################################
. ./util.sh

P_UID=`id -u postgres`

if [ ${EUID} -ne ${P_UID} ] ; then
   log "You must run this script as user postgres."
   exit 1;
fi

createdb site || 
{
    log "Failed to create site database."
    exit 2;
}

createuser -P -R -D -S -e -l django_site ||
{
    log "Failed to create user"
    exit 3;
}

psql -c "grant all privileges on database site to django_site; "

