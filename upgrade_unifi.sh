#!/bin/bash

#################################################################################
# A simple script for remotely upgrading Ubiquiti UniFi hardware firmware
# Version 1.2-beta1 (Dec 20, 2018)
# by Steve Jenkins (http://www.stevejenkins.com/)
#
# Requires bash and sshpass (https://sourceforge.net/projects/sshpass/)
# which should be available via dnf, yum, or apt on your *nix distro.
#
# USAGE
# Update the user-configurable settings below, then run ./upgrade_unifi.sh from
# the command line.
#
# Devices will be upgraded in the order their IP addresses appear in the their
# *_ip_list array. Take that into consideration when adding IPs to each array.
#################################################################################

# USER-CONFIGURABLE SETTINGS
username=ubnt
password=ubnt
known_hosts_file=/dev/null

#UAP-AC-Lite/LR/Pro/EDU/M/M-PRO/IW/IW-Pro
U7PG2_fw="https://dl.ubnt.com/unifi/firmware/U7PG2/4.0.11.9713/BZ.qca956x.v4.0.11.9713.181215.2314.bin"
U7PG2_ip_list=( 192.168.1.13 192.168.1.14 )

#UAP-HD/SHD/XG/BaseStationXG
U7HD_fw="https://dl.ubnt.com/unifi/firmware/U7HD/4.0.11.9713/BZ.ipq806x.v4.0.11.9713.181215.2314.bin"
U7HD_ip_list=( 192.168.1.15 192.168.1.17 )

#UAP-nanoHD/IW-HD
U7NHD_fw="https://dl.ubnt.com/unifi/firmware/U7NHD/4.0.11.9713/BZ.mt7621.v4.0.11.9713.181215.2314.bin"
U7NHD_ip_list=( 192.168.1.16 )

#UAP, UAP-LR, UAP-OD, UAP-OD5
BZ2_fw="https://dl.ubnt.com/unifi/firmware/BZ2/4.0.11.9713/BZ.ar7240.v4.0.11.9713.181215.2315.bin"
BZ2_ip_list=()

#UAP-v2, UAP-LR-v2
US2v2_fw="https://dl.ubnt.com/unifi/firmware/U2Sv2/4.0.11.9713/BZ.qca9342.v4.0.11.9713.181215.2315.bin"
US2v2_ip_list=()

#UAP-IW
U2IW_fw="https://dl.ubnt.com/unifi/firmware/U2IW/4.0.11.9713/BZ.qca933x.v4.0.11.9713.181215.2315.bin"
U2IW_ip_list=()

#UAP-Pro
U7P_fw="https://dl.ubnt.com/unifi/firmware/U7P/4.0.11.9713/BZ.ar934x.v4.0.11.9713.181215.2315.bin"
U7P_ip_list=()

#UAP-OD+
U2HSR_fw="https://dl.ubnt.com/unifi/firmware/U2HSR/4.0.11.9713/BZ.ar7240.v4.0.11.9713.181215.2315.bin"
U2HSR_ip_list=()

#USW
US24P250_fw="https://dl.ubnt.com/unifi/firmware/US24P250/4.0.11.9713/US.bcm5334x.v4.0.11.9713.181215.2314.bin"
US24P250_ip_list=()

#US-L2-POE
US24PL2_fw="https://dl.ubnt.com/unifi/firmware/US24PL2/4.0.11.9713/US2.bcm5334x.v4.0.11.9713.181215.2314.bin"
US24PL2_ip_list=()

#US-16-XG
USXG_fw="https://dl.ubnt.com/unifi/firmware/USXG/4.0.11.9713/US.bcm5341x.v4.0.11.9713.181215.2314.bin"
USXG_ip_list=()

#US-XG-6POE
US6XG150_fw="https://dl.ubnt.com/unifi/firmware/US6XG150/4.0.11.9713/US.bcm5616x.v4.0.11.9713.181215.2314.bin"
US6XG150_ip_list=()

#USW-Multi
USMULT_fw="https://dl.ubnt.com/unifi/firmware/USMULT/4.0.11.9713/US.MULT.4.0.11.9713.181215.2340.bin"
USMULT_ip_list=( 192.168.1.12 192.168.1.11 192.168.1.10 192.168.1.9 192.168.1.8 192.168.1.7 192.168.1.6 192.168.1.5 192.168.1.4 192.168.1.2 192.168.1.250 )

# SHOULDN'T NEED TO CHANGE ANYTHING PAST HERE

# Upgrade UAP-AC-Lite/LR/Pro/EDU/M/M-PRO/IW/IW-Pro devices
for i in "${U7PG2_ip_list[@]}"
do
	echo "Upgrading UAP-AC-Lite/LR/Pro/EDU/M/M-PRO/IW/IW-Pro @ $i..."
sshpass -p $password ssh -T -oStrictHostKeyChecking=no -oUserKnownHostsFile=$known_hosts_file $username"@$i" << EOF
sudo upgrade $U7PG2_fw ;
EOF
done

# Upgrade UAP-HD/SHD/XG/BaseStationXG devices
for i in "${U7HD_ip_list[@]}"
do
	echo "Upgrading UAP-HD/SHD/XG/BaseStationXG @ $i..."
sshpass -p $password ssh -T -oStrictHostKeyChecking=no -oUserKnownHostsFile=$known_hosts_file $username"@$i" << EOF
sudo upgrade $U7HD_fw ;
EOF
done

# Upgrade UAP-nanoHD/IW-HD devices
for i in "${U7NHD_ip_list[@]}"
do
	echo "Upgrading UAP-nanoHD/IW-HD @ $i..."
sshpass -p $password ssh -T -oStrictHostKeyChecking=no -oUserKnownHostsFile=$known_hosts_file $username"@$i" << EOF
sudo upgrade $U7NHD_fw ;
EOF
done

# Upgrade UAP, UAP-LR, UAP-OD, UAP-OD5 devices
for i in "${BZ2_ip_list[@]}"
do
	echo "Upgrading UAP, UAP-LR, UAP-OD, UAP-OD5 @ $i..."
sshpass -p $password ssh -T -oStrictHostKeyChecking=no -oUserKnownHostsFile=$known_hosts_file $username"@$i" << EOF
sudo upgrade $BZ2_fw ;
EOF
done

# Upgrade UAP-v2, UAP-LR-v2 devices
for i in "${US2v2_ip_list[@]}"
do
	echo "Upgrading UAP-v2, UAP-LR-v2 @ $i..."
sshpass -p $password ssh -T -oStrictHostKeyChecking=no -oUserKnownHostsFile=$known_hosts_file $username"@$i" << EOF
sudo upgrade $US2v2_fw ;
EOF
done

# Upgrade UAP-IW devices
for i in "${U2IW_ip_list[@]}"
do
	echo "Upgrading UAP-IW @ $i..."
sshpass -p $password ssh -T -oStrictHostKeyChecking=no -oUserKnownHostsFile=$known_hosts_file $username"@$i" << EOF
sudo upgrade $U2IW_fw ;
EOF
done

# Upgrade UAP-Pro devices
for i in "${U7P_ip_list[@]}"
do
	echo "Upgrading UAP-Pro @ $i..."
sshpass -p $password ssh -T -oStrictHostKeyChecking=no -oUserKnownHostsFile=$known_hosts_file $username"@$i" << EOF
sudo upgrade $U7P_fw ;
EOF
done

# Upgrade UAP-OD+ devices
for i in "${U2HSR_ip_list[@]}"
do
	echo "Upgrading UAP-OD+ at $i..."
sshpass -p $password ssh -T -oStrictHostKeyChecking=no -oUserKnownHostsFile=$known_hosts_file $username"@$i" << EOF
sudo upgrade $U2HSR_fw ;
EOF
done

# Upgrade USW devices
for i in "${US24P250_ip_list[@]}"
do
	echo "Upgrading USW @ $i..."
sshpass -p $password ssh -T -oStrictHostKeyChecking=no -oUserKnownHostsFile=$known_hosts_file $username"@$i" << EOF
sudo upgrade $US24P250_fw ;
EOF
done

# Upgrade US-L2-POE devices
for i in "${US24PL2_ip_list[@]}"
do
	echo "Upgrading US-L2-POE @ $i..."
sshpass -p $password ssh -T -oStrictHostKeyChecking=no -oUserKnownHostsFile=$known_hosts_file $username"@$i" << EOF
sudo upgrade $US24PL2_fw ;
EOF
done

# Upgrade US-16-XG devices
for i in "${USXG_ip_list[@]}"
do
	echo "Upgrading US-16-XG @ $i..."
sshpass -p $password ssh -T -oStrictHostKeyChecking=no -oUserKnownHostsFile=$known_hosts_file $username"@$i" << EOF
sudo upgrade $USXG_fw ;
EOF
done

# Upgrade US-XG-6POE devices
for i in "${US6XG150_ip_list[@]}"
do
	echo "Upgrading US-XG-6POE @ $i..."
sshpass -p $password ssh -T -oStrictHostKeyChecking=no -oUserKnownHostsFile=$known_hosts_file $username"@$i" << EOF
sudo upgrade $US6XG150_fw ;
EOF
done

# Upgrade USW-Multi devices
for i in "${USMULT_ip_list[@]}"
do
	echo "Upgrading USW-Multi @ $i..."
sshpass -p $password ssh -T -oStrictHostKeyChecking=no -oUserKnownHostsFile=$known_hosts_file $username"@$i" << EOF
sudo upgrade $USMULT_fw ;
EOF
done

# All device types upgraded so let's wrap this up!
exit 0
