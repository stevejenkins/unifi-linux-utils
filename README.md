# UniFi Linux Utils
A collection of helpful Linux / Unix scripts and utilities for admins of Ubiquiti (UBNT) UniFi products.

### uap-reboot.sh
Remotely reboots a Ubiquiti (UBNT) UniFi access point.

### unifi_ssl_import.sh
Imports SSL certificates (including Let's Encrypt) for the Ubiquiti (UBNT) UniFi SDN Controller on Linux / Unix Systems.

### upgrade_unifi_controller.sh
Automates upgrade of Ubiquiti (UBNT) UniFi SDN Controller software on Linux / Unix Systems.

### upgrade_unifi.sh
Automates local LAN fimware upgrades of Ubiquiti (UBNT) UniFi devices (still in beta).

## UniFi Nagios Monitoring Scripts
### /nagios/check_unifi
A Python-based script that checks the status of UAPs and reports WARNING or CRITICAL output for Nagios/Icinga monitoring servers. Original version at https://github.com/msweetser/check_unifi.

## USG config.gateway.json Files
### /config.gateway.json
A collection of valid JSON `config.gateway.json` files that may be used to modify your USG configuration beyond the abilities of the UniFi SDN Controller's web interfaces. The filename and a comment near the top of each example indicate what that particular file will configure.

Over time, more and more of these snippets should be archived as that functionality (hopefully) becomes incorporated into the UniFi SDN Controller's web interface.

Each example file in this folder is a complete and validated `config.gateway.json` file. However, if you wish to combine one or more example files (or add to your existing `config.gateway.json` file), I *strongly* recommend using the excellent [JSONLint Validator](https://jsonlint.com/) prior to saving the file on your Controller and re-provisioning your USG. If your JSON is not valid, your USG will be stuck in a provisioning loop until you correct the problem in your `config.gateway.json` file.

## UniFi SDN Controller Startup Scripts
### /startup-scripts/UniFi.service
A systemd service file which can be used to run a Ubiquiti (UBNT) UniFi SDN Controller on Linux systems.

### /startup-scripts/UniFi
A SysV service file which can be used to run a Ubiquiti (UBNT) UniFi SDN controller on Linux systems.

### /startup-scripts/docker-unifi.service
A systemd service file which can be used to run a Ubiquiti (UBNT) UniFi SDN controller in a Docker container on Linux systems (contributed by @rogierlommers). See https://github.com/goofball222/unifi for UniFi + Docker info.

## Other UniFi-related Linux Projects I Like
#### UniFi-API - https://github.com/calmh/unifi-api###
An API for communicating with Linux-based UniFi controllers, with a few helpful utilities that rely on the API.

#### UniFi Docker - https://github.com/goofball222/unifi###
A Docker container built for Ubiquiti (UBNT) UniFi controllers.
