#!/usr/bin/env bash

. ./util.sh

PACKAGE_LIST="django-cms django-reversion<1.8 gunicorn psycopg2"

SITE_DIR="${1}"
if [ -z "${SITE_DIR}" ] ; then
    log "usage: ${0} site_virtualenv_dir"
    exit 1
fi

log "Creating virtualenv ${SITE_DIR}"
virtualenv ${SITE_DIR} || 
{
    log "Failed to create virtualenv ${SITE_DIR}"
    exit 2
}

log "Activating ${SITE_DIR}."
. ${SITE_DIR}/bin/activate

log "Installing packages: ${PACKAGE_LIST}"
pip install ${PACKAGE_LIST} ||
{
    log "Failed to install site packages."
    exit 3
}


