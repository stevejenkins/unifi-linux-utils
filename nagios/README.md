check_unifi
===========

Nagios plugin to check the UniFi Controller for AP status.

Install
-------
The UniFi API pip module is required:

    sudo pip install -U unifi
    
Copy check_unifi into your plugins directory.

Usage
-----
```
usage: check_unifi [-h] [-H HOSTNAME] [-u USERNAME] [-p PASSWORD] [-b PORT]
                   [-v VERSION] [-s SITEID] [-w WARNING] [-c CRITICAL] [-a AP]

optional arguments:
  -h, --help            show this help message and exit
  -H HOSTNAME, --hostname HOSTNAME
                        the controller address (default "unifi")
  -u USERNAME, --username USERNAME
                        the controller username (default("admin")
  -p PASSWORD, --password PASSWORD
                        the controller password
  -b PORT, --port PORT  the controller port (default "8443")
  -v VERSION, --version VERSION
                        the controller base version (default "v2")
  -s SITEID, --siteid SITEID
                        the site ID, UniFi >=3.x only (default "default")
  -w WARNING, --warning WARNING
                        amount of APs to be down for WARNING (default: none)
  -c CRITICAL, --critical CRITICAL
                        amount of APs to be down for CRITICAL (default: none)
  -a AP, --ap AP        name of AP to get status of (default: overall check)
```

License
-------
This project is licensed under the terms of the MIT license.

Credits
-------
Current version by Michael Sweetser, available at: https://github.com/msweetser/check_unifi

Based on Michel Greijmans' original UniFi WiFi Nagios Monitoring Plugin, available at: https://community.ubnt.com/t5/UniFi-Wireless/UniFi-WiFi-Nagios-Monitoring-Plugin/td-p/1092503
