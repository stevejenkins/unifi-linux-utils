# UniFi Linux Utils
A collection of helpful Linux / Unix scripts and utilities for admins of Ubiquiti (UBNT) UniFi products.

### uap-reboot.sh
Remotely reboots a Ubiquiti (UBNT) UniFi access point.

### unifi_ssl_import.sh
Imports SSL certificates (including Let's Encrypt) for the Ubiquiti (UBNT) UniFi Controller on Linux / Unix Systems.

### upgrade_unifi_controller.sh
Automates upgrade of Ubiquiti (UBNT) UniFi Controller software on Linux / Unix Systems.

## UniFi Nagios Monitoring Scripts
### /nagios/check_unifi
A Python-based script that checks the status of UAPs and reports WARNING or CRITICAL output for Nagios/Icinga monitoring servers. Original version at https://github.com/msweetser/check_unifi.

## UniFi Controller Startup Scripts
### /startup-scripts/UniFi.service
A systemd service file which can be used to run a Ubiquiti (UBNT) UniFi controller Ubiquiti on Linux systems.

### /startup-scripts/UniFi
A SysV service file which can be used to run a Ubiquiti (UBNT) UniFi controller Ubiquiti on Linux systems.

### /startup-scripts/docker-unifi.service
A systemd service file which can be used to run a Ubiquiti (UBNT) UniFi controller in a Docker container on Linux systems (contributed by @rogierlommers). See https://github.com/goofball222/unifi for UniFi + Docker info.

## Other UniFi-related Linux Projects I Like
#### UniFi-API - https://github.com/calmh/unifi-api###
An API for communicating with Linux-based UniFi controllers, with a few helpful utilities that rely on the API.

#### UniFi Docker - https://github.com/goofball222/unifi###
A Docker container built for Ubiquiti (UBNT) UniFi controllers.
