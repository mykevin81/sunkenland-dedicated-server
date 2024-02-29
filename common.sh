#!/bin/bash
# The following are default values.
# They can be overridden by supplying the -e VAR=value option to the containerizer.

#Sunkenland server parameter
WORLD_GUID=${WORLD_GUID}
PASSWORD=${PASSWORD:-}
REGION=${REGION:-USW}
MAKE_SESSION_INVISIBLE=${MAKE_SESSION_INVISIBLE:-false}
MAX_PLAYER_CAPACITY=${MAX_PLAYER_CAPACITY:-10}
MAX_PLAYER=15
MIN_PLAYER=3
#TODO add capability to set logFile location

#Pre-start checkers
guidExistCheck() {
    if [ -z "$WORLD_GUID" ]; then
        fatal "No WORLD_GUID provided, cannot start without existing world"
    else
        info "WORLD_GUID provided: $WORLD_GUID, continue."
    fi
}

maxPlayerCapacityCheck() {
    regex='^[0-9]+$'
    max=15
    min=3
    if ! [[ $MAX_PLAYER_CAPACITY =~ $regex ]]; then
        error "MAX_PLAYER_CAPACITY is not a number, setting to default 10."
        MAX_PLAYER_CAPACITY=10
    fi
    if [[ $MAX_PLAYER_CAPACITY -gt $MAX_PLAYER ]]; then
        warn "MAX_PLAYER_CAPACITY cannot be more than $MAX_PLAYER, setting to $MAX_PLAYER."
        MAX_PLAYER_CAPACITY=$MAX_PLAYER
    fi
    if [[ $MAX_PLAYER_CAPACITY -lt $MIN_PLAYER ]]; then
        warn "MAX_PLAYER_CAPACITY cannot be less than $MIN_PLAYER, setting to $MIN_PLAYER."
        MAX_PLAYER_CAPACITY=$MIN_PLAYER
    fi 
}

preStartCheck() {
    guidExistCheck
    maxPlayerCapacityCheck
}


#Loggers
debug=50
info=40
warn=30
error=20
critical=10
fatal=5
log_level=${log_level:-$debug}

debug()    { logstd $debug    "DEBUG - [$$] - $*"; }
info()     { logstd $info     "INFO - $*"; }
warn()     { logstd $warn     "WARN - $*"; }
error()    { logerr $error    "ERROR - $*"; }
critical() { logerr $critical "CRITIAL - $*"; }
fatal()    { logerr $fatal    "FATAL - $*"; exit 1; }

logstd() {
    local log_at_level
    log_at_level="$1"; shift
    printline "$log_at_level" "$*"
}

logerr() {
    local log_at_level
    log_at_level="$1"; shift
    printline "$log_at_level" "$*" >&2
}

printline() {
    local log_at_level
    local log_data
    log_at_level="$1"; shift
    log_data="$*"

    if [ "$log_at_level" -le "$log_level" ]; then
        echo "$log_data"
    fi
}
