#!/bin/bash

if [ "$1" == "" ]; then
  echo ""
  echo "  Usage:"
  echo ""
  echo "  get_vnc.sh <name of VM>"
  echo ""
  exit
fi

# Get the uuid of the VM.
#
uuid=`xe vm-list name-label=$1 params=uuid --minimal`

if [ "$uuid" == "" ]; then
  echo ""
  echo "  Warning: VM '$1' not found"
  echo ""
  exit
fi

# Get the domain id of the VM using the uuid.
#
domid=`list_domains | grep $uuid | awk {'print $1'}`

# Get the vnc port from the domain id database.
#
vncPort=`xenstore-read /local/domain/$domid/console/vnc-port`
echo $vncPort
