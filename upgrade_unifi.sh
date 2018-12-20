#!/bin/bash

#########################################################################
# A simple script for remotely upgrading Ubiquiti UniFi hardware firmware
# Version 1.0 (Dec 18, 2018)
# by Steve Jenkins (http://www.stevejenkins.com/)
#
# Requires bash and sshpass (https://sourceforge.net/projects/sshpass/)
# which should be available via dnf, yum, or apt on your *nix distro.
#
# USAGE
# Update the user-configurable settings below, then run ./upgrade_unifi.sh from
# the command line.
#########################################################################

# USER-CONFIGURABLE SETTINGS
username=ubnt
password=ubnt
known_hosts_file=/dev/null

#UAP-AC-Lite/LR/Pro/EDU/M/M-PRO/IW/IW-Pro
U7PG2_fw="https://dl.ubnt.com/unifi/firmware/U7PG2/4.0.11.9713/BZ.qca956x.v4.0.11.9713.181215.2314.bin"
U7PG2_ip_list=( 192.168.1.13 192.168.1.14 )

#UAP-HD/SHD/XG/BaseStationXG
U7HD_fw=
U7HD_ip_list=()

#UAP-nanoHD/IW-HD
U7NHD_fw=
U7NHD_ip_list=()

#UAP, UAP-LR, UAP-OD, UAP-OD5
U7HD_fw=
U7HD_ip_list=()

#UAP-v2, UAP-LR-v2
BZ2=
BZ2_ip_list=()

#UAP-IW
U2IW_fw=
U2IW_ip_list=()

#UAP-Pro
U7P_fw=
U7P_ip_list=()

#UAP-OD+
U2HSR_fw=
U2HSR_ip_list=()

#USW
US24P250_fw=
US24P250_ip_list=()

#US-L2-POE
US24PL2_fw=
US24PL2_ip_list=()

#US-16-XG
USXG_fw=
USXG_ip_list=()

#US-XG-6POE
US6XG150_fw=
US6XG150_ip_list=()

#USW-Multi
USMULT_fw=
USMULT_ip_list=()

# SHOULDN'T NEED TO CHANGE ANYTHING PAST HERE
# Upgrade UAP-AC-Lite/LR/Pro/EDU/M/M-PRO/IW/IW-Pro devices
for i in "${U7PG2_ip_list[@]}"
do
        echo "Upgrading UAP at $i..."
        if sshpass -p $password ssh -oStrictHostKeyChecking=no -oUserKnownHostsFile=$known_hosts_file $username"@$i"<<EOF
                sudo upgrade $U7PG2_fw
EOF
then
                echo "Firmware upgrade for UAP $i initiated!" 1>&2
	else
                echo "Could not upgrade UAP at $i." 1>&2
	fi
done
exit 0
