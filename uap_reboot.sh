#!/bin/bash

#######################################################################
# A simple script for remotely rebooting a Ubiquiti UniFi access point
# Version 2.3 (Mar 28, 2018)
# by Steve Jenkins (http://www.stevejenkins.com/)
#
# Requires bash and sshpass (https://sourceforge.net/projects/sshpass/)
# which should be available via dnf, yum, or apt on your *nix distro.
#
# USAGE
# Update the user-configurable settings below, then run ./uap_reboot.sh from
# the command line. To reboot on a schedule, create a cronjob such as:
# 45 3 * * * /usr/local/bin/unifi-linux-utils/uap_reboot.sh > /dev/null 2>&1 #Reboot UniFi APs
# The above example will reboot the UniFi access point(s) every morning at 3:45 AM.
#######################################################################

# USER-CONFIGURABLE SETTINGS
username=ubnt
password=ubnt
known_hosts_file=/dev/null
uap_list=( 192.168.0.2 192.168.0.3 192.168.0.4 192.168.0.5 )

# SHOULDN'T NEED TO CHANGE ANYTHING PAST HERE
for i in "${uap_list[@]}"
do

	echo "Rebooting UniFi access point at $i..."
	if sshpass -p $password ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=$known_hosts_file $username"@$i" reboot; then
                echo "Access point at $i rebooted!" 1>&2
	else
                echo "Could not reboot access point at $i." 1>&2
	fi
done
exit 0
