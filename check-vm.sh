# Usage check-vm.sh
#
# The idea is to do some kind of 'ping' and then if it does not succeed,
# we log something.  This will confirm that connectivity to something is
# working and if not, we'll reboot to reset the device.
#
# While not ideal, at least we know we can have a predictable recovery.
#
MAX=4
INTERVAL=60

logger -t check-vm "Initiating the check-vm.sh script"

# Idiomatic way (i.e., copy/paste from web) to do loop with counting.
#
COUNTER=0
MAX=$[$MAX +1]

  while [ $COUNTER -lt $MAX ]; do
  ping -w 1 -i .5 -c 1 8.8.8.8 > /dev/null
  rc=$?
  if [[ $rc -eq 0 ]] ; then
      COUNTER=0
      logger -t check-vm "VM has connectivity ..."
  else
      COUNTER=$[$COUNTER +1]
      logger -t check-vm "VM has no connectivity"
  fi
  sleep $INTERVAL
  done

  logger -t check-vm "VM has lost connectivity, it's time to reboot -- sorry!"
  reboot

