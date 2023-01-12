#!/bin/bash
INSTALL_PATH=${INSTALL_PATH:-""}

function doInstall(){
    local arg1="$1"
    shift
    echo + install ".$arg1" " $INSTALL_PATH$arg1" "$@"
    install "./$arg1" "$INSTALL_PATH$arg1" "$@"
}
function doInstallIfNotExits(){
    local arg1="$1"
    shift
    if [ -f  "$INSTALL_PATH$arg1" ] 
    then 
        echo "  Skipping:  $arg1 : already exists."
    else
        echo + install ".$arg1" " $INSTALL_PATH$arg1" "$@"
        install "./$arg1" "$INSTALL_PATH$arg1" "$@"
    fi
}

function doUninstall(){
    echo + rm -f "$1"
    rm -f "$1"
}

function doKeep (){
    echo "  Skipping: configuration file : $1"
    rm -f "$1"  
}

function performReplace(){
    $1   /lib/systemd/system/usernetns-bridge.service
    $1   /lib/systemd/system/usernetnstest@.service
    $1   /lib/systemd/system/usernetns@.service
    $1   /usr/local/bin/makebridge
    $1   /usr/local/bin/makeusernetns
    $1   /usr/local/bin/usernetnsexec
}

function performOnConfig(){
    $1   /etc/usernetns.conf
}

if [ "$1" == "uninstall" ] 
then 
    performReplace doUninstall
    performOnConfig doKeep
elif [ "$#" == "0" ] || [ "$1" == "install"] 
then
    set -e
    performReplace doInstall
    performOnConfig doInstallIfNotExits
else
    echo "Unknown options: " "$@" 1>&2
    exit 1
fi
