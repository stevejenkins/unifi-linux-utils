#!/usr/bin/env bash

cat <<'USAGE'
Usage:

  uap_reboot.sh:

    docker run --rm -it \
        -e UAP_USERNAME="username" \
        -e UAP_PASSWORD="password" \
        -e UAP_LIST="10.0.1.10 10.0.1.20 10.0.1.30" \
        unifi-linux-utils uap_reboot.sh

  check_unifi:

    docker run --rm -it \
        unifi-linux-utils check_unifi \
        -H 10.0.1.1 \
        -u "username" \
        -p "password"

USAGE

exit 1
