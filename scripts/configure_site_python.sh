#!/usr/bin/env bash

. ./util.sh

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

log "Installing mezzanine."
pip install mezzanine ||
{
    log "Failed to install mezzanine."
    exit 3
}

log "Installing gunicorn."
pip install gunicorn ||
{
    log "Failed to install gunicorn."
    exit 4
}

log "Installing pyscopg2."
pip install psycopg2 ||
{
    log "Failed to install psycopg2."
    exit 5
}

