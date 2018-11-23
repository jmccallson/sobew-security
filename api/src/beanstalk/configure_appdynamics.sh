#!/bin/bash

ME=$(basename "$0")
LOG_FILE="${ME}.log"
[ -e ${LOG_FILE} ] && rm ${LOG_FILE}

function log() {
  # Log the first parameter to both the console and to an adjacent file
  local statement="$(date -u):  $1"
  echo "${statement}"
  echo "${statement}" >> ${LOG_FILE}
}

function logAndExit() {
  log "$1"
  exit 0
}

if [ ! -v AD_OPTS ]; then
  # Only take action if AppDynamics is explicitly enabled; the beanstalk provisioner sets AD_OPTS if AppDynamics
  #  is enabled
  logAndExit "AppDynamics is not enabled - AD_OPTS='${AD_OPTS}'"
fi

# Exit if AppDynamics is already instrumented
grep 'appdynamics.agent.' Procfile && logAndExit "AppDynamics is already instrumented"

# Exit if any of the PaaS environment variables are null or blank
[ -z ${FS_BLUEPRINT_NAME} ] && logAndExit "Failed because the environment variable FS_BLUEPRINT_NAME is not set"
[ -z ${FS_SYSTEM_NAME} ] && logAndExit "Failed because the environment variable FS_SYSTEM_NAME is not set"
[ -z ${FS_SERVICE_NAME} ] && logAndExit "Failed because the environment variable FS_SERVICE_NAME is not set"

# Replace the 'unique-host-id' string in AD_OPTS with the actual unique host id
UNIQUE_HOST_ID=$(hostname -f | sed -e 's/\.ec2\.internal.*//')
AD_OPTS=${AD_OPTS/unique-host-id/$UNIQUE_HOST_ID}

# AD_OPTS is set by the beanstalk provisioner when AppDynamics is enabled
log "Instrumenting AppDynamics with properties: ${AD_OPTS}"
sed -i.orig "s@\(.*: java\)\(.*\)@\1 ${AD_OPTS}\2@" Procfile
