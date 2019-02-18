# Example config.gateway.json files for the UniFi Security Gateway (USG)

A collection of valid JSON `config.gateway.json` files that may be used to modify your USG configuration beyond the abilities of the UniFi SDN Controller's web interfaces. The filename and a comment near the top of each example indicate what that particular file will configure.

Over time, more and more of these snippets should be archived as that functionality (hopefully) becomes incorporated into the UniFi SDN Controller's web interface.

Each example file in this folder is a complete and validated `config.gateway.json` file. However, if you wish to combine one or more example files (or add to your existing `config.gateway.json` file), I *strongly* recommend using the excellent [JSONLint Validator](https://jsonlint.com/) prior to saving the file on your Controller and re-provisioning your USG. If your JSON is not valid, your USG will be stuck in a provisioning loop until you correct the problem in your `config.gateway.json` file.

### `add-debian-repos.json`
Enables additional Debian repos on a USG to make installing packages (like nano) easier. After provisioning USG run `sudo apt-get update` via CLI before attempting to install new packages.

### `force-dns-to-pihole.json` & `force-dns-to-dual-piholes.json`
Forwards all internal port 53 DNS traffic to a Pi-hole (or two Pi-holes with consecutive IP addresses), preventing LAN devices from using their own hard-coded DNS servers. Replace `eth1` with your USG's **LAN** interface and replace `192.168.0.105` (or `192.168.0.105-192.168.0.106` if using multiple Pi-holes) with your Pi-hole's IP address(es).

### `vrrp-dual-routers-usg3.json` & `vrrp-dual-routers-usg4.json`
Enables the Virtual Router Redundancy Protocol (VRRP) to allow two USG routers on a single network. The two example files show the JSON needed for a USG4 acting as the primary router with a USG3 as a redundant backup. Choose which example file(s) to use depending on your hardware and network setup. Each USG must be in a separate site on the UniFi SDN Controller, both sites need to have the same networks setup in them, and both LAN ports are used on each USG. Contributed by learningman. See https://bit.ly/2MoaFTa.
