#!/usr/bin/env bash
# Creates fresh django project

usage() 
{
    echo "${0} project_name dest_dir"
}

projname="${1}"
destdir="${2}"

[[ $# -eq 2 ]] || { usage; exit 1; }

[ -z "${projname}" ] && { echo "No project name given"; usage; exit 2; }

[ -z "${VIRTUAL_ENV}" ] && { echo "You're not in a virtual env." ; exit 1; }
echo "Using virtualenv ${VIRTUAL_ENV}"

django-admin.py startproject ${projname} ${destdir} || 
{
    echo "Failed to create projet ${projname}"
    exit 3
}

