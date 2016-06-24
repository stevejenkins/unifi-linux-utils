#!/bin/sh

# upgrade_unifi.sh
# Easy UniFi Controller Upgrade Script for Unix/Linux Systems
# by Steve Jenkins (stevejenkins.com)
# Last Updated June 24, 2016

# REQUIREMENTS
# 1) Assumes you already have any version of UniFi Controller installed 
#    and running on your system.
# 2) Assumes a user named "ubnt" owns the /opt/UniFi directory.
# 3) Requires a service start/stop script to properly shut down and 
#    restart the UniFi controller before and after upgrade. I've written
#    compatible startup scrips for SysV and systemd systems at 
#    http://wp.me/p1iGgP-2wl
# 4) Requires wget command to fetch the software from UBNT's download site.

# USAGE
# Modify the "unifi_version" variable below using the version number you
# wish to install (e.g. "5.0.7"). For Beta versions, use the full download 
# directory in the UBNT download link (e.g. "5.0.8-ac599f45"). Modify any 
# of the additional variables below (defaults should work fine), then run
# the script!

# UniFi Controller version to install
unifi_version=5.0.7

# Additional variables (defaults should work fine on most systems)
unifi_user=ubnt
unifi_parent_dir=/opt
unifi_dir=/opt/UniFi
unifi_backup_dir=/opt/UniFi_bak
unifi_archive_filename=UniFi.unix.zip
unifi_archive_location=https://www.ubnt.com/downloads/unifi/
temp_dir=/tmp

# SHOULDN'T HAVE TO MODIFY PAST THIS POINT

# Create progress dots function
function show_dots() {
	while ps $1 >/dev/null ; do
	printf "."
	sleep 1
	done
	printf "\n"
}

# Let's DO this!
printf "Upgrading to UniFi Controller v$unifi_version...\n"

# Stop the local UniFi Controller service
printf "\n"
service UniFi stop

# Retrieve the updated zip archive from UBNT (overwriting any previous version)
printf "\nDownloading $unifi_archive_filename from UBNT..."
cd $temp_dir
wget -qq $unifi_archive_location/$unifi_version/$unifi_archive_filename -O $unifi_archive_filename &
show_dots $!

# Remove previous backup directory (if it exists)
if [ -d "$unifi_backup_dir" ]; then
	printf "\nRemoving previous backup directory...\n"
	rm -rf $unifi_backup_dir
fi

# Move existing UniFi directory to backup location
printf "\nMoving existing UniFi Controller directory to backup location...\n"
mv $unifi_dir $unifi_backup_dir

# Extract new version
printf "\nExtracting downloaded software..."
unzip -qq $temp_dir/$unifi_archive_filename -d $unifi_parent_dir &
show_dots $!

# Jump into the backup directory
cd $unifi_backup_dir

# Create an archive of the existing data directory
printf "\nBacking up existing UniFi Controller data..."
tar zcf $temp_dir/unifi_data_bak.tar.gz data/ &
show_dots $!

# Extract the data into the new directory
printf "\nExtracting UniFi Controller backup data to new directory..."
tar zxf $temp_dir/unifi_data_bak.tar.gz -C $unifi_dir &
show_dots $!

# Enforce proper ownership of UniFi directory
chown -R $unifi_user:$unifi_user $unifi_dir

# Restart the local UniFi Controller service
printf "\n"
service UniFi start

# All done!
printf "\nUpgrade to UniFi Controller v$unifi_version complete!\n"

exit
