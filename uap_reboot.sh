#!/usr/bin/env bash

#######################################################################
# A simple script for remotely rebooting a Ubiquiti UniFi access point
# Version 2.3 (Mar 28, 2018)
# by Steve Jenkins (http://www.stevejenkins.com/)
#
# Requires bash and sshpass (https://sourceforge.net/projects/sshpass/)
# which should be available via dnf, yum, or apt on your *nix distro.
#
# USAGE
# Override the user-configurable settings by providing environment variables,
# then run ./uap_reboot.sh from the command line. To reboot on a schedule,
# create a cronjob such as:
# 45 3 * * * UAP_LIST="10.0.1.10 10.0.1.20" /usr/local/bin/unifi-linux-utils/uap_reboot.sh > /dev/null 2>&1 #Reboot UniFi APs
# The above example will reboot the UniFi access point(s) every morning at 3:45 AM.
#######################################################################

# USER-CONFIGURABLE SETTINGS
username="${UAP_USERNAME:-ubnt}"
password="${UAP_PASSWORD:-ubnt}"
known_hosts_file=/dev/null
IFS=' '; read -ra uap_list <<< "${UAP_LIST?}"

# SHOULDN'T NEED TO CHANGE ANYTHING PAST HERE
EXIT=0
for i in "${!uap_list[@]}"
do

  uap_addr="${uap_list[$i]}"
  echo "Rebooting UniFi access point at ${uap_addr}... ($((i + 1))/${#uap_list[@]})"
	if sshpass -p "$password" ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile="$known_hosts_file" "${username}@${uap_addr}" reboot; then
                echo "Access point at $uap_addr rebooted!" 1>&2
	else
                echo "Could not reboot access point at $uap_addr." 1>&2
                EXIT=$((EXIT + 1))
	fi
done
exit $EXIT
