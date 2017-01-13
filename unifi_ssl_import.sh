#!/usr/bin/env bash

# unifi_ssl_import.sh
# UniFi Controller SSL Certificate Import Script for Unix/Linux Systems
# by Steve Jenkins <http://www.stevejenkins.com/>
# Part of https://github.com/stevejenkins/ubnt-linux-utils/
# Incorporates ideas from https://source.sosdg.org/brielle/lets-encrypt-scripts
# Version 2.8
# Last Updated Jan 13, 2017

# REQUIREMENTS
# 1) Assumes you have a UniFi Controller installed and running on your system.
# 2) Assumes you already have a valid 2048-bit private key, signed certificate, and certificate authority
#    chain file. The Controller UI will not work with a 4096-bit certificate. See http://wp.me/p1iGgP-2wU
#    for detailed instructions on how to generate those files and use them with this script.

# KEYSTORE BACKUP
# Even though this script attempts to be clever and careful in how it backs up your existing keystore,
# it's never a bad idea to manually back up your keystore (located at $UNIFI_DIR/data/keystore on RedHat
# systems or /$UNIFI_DIR/keystore on Debian/Ubunty systems) to a separate directory before running this
# script. If anything goes wrong, you can restore from your backup, restart the UniFi Controller service,
# and be back online immediately.

# CONFIGURATION OPTIONS
UNIFI_HOSTNAME=hostname.example.com
UNIFI_SERVICE=unifi

# Uncomment following three lines for Fedora/RedHat/CentOS
UNIFI_DIR=/opt/UniFi
JAVA_DIR=${UNIFI_DIR}
KEYSTORE=${UNIFI_DIR}/data/keystore

# Uncomment following three lines for Debian/Ubuntu
#UNIFI_DIR=/var/lib/unifi
#JAVA_DIR=/usr/lib/unifi
#KEYSTORE=${UNIFI_DIR}/keystore

# FOR LET'S ENCRYPT SSL CERTIFICATES ONLY
# Generate your Let's Encrtypt key & cert with certbot before running this script
LE_MODE=no
LE_LIVE_DIR=/etc/letsencrypt/live

# THE FOLLOWING OPTIONS NOT REQUIRED IF LE_MODE IS ENABLED
PRIV_KEY=/etc/ssl/private/hostname.example.com.key
SIGNED_CRT=/etc/ssl/certs/hostname.example.com.crt
CHAIN_FILE=/etc/ssl/certs/startssl-chain.crt

# CONFIGURATION OPTIONS YOU PROBABLY SHOULDN'T CHANGE
ALIAS=unifi
PASSWORD=aircontrolenterprise

#### SHOULDN'T HAVE TO TOUCH ANYTHING PAST THIS POINT ####

printf "\nStarting UniFi Controller SSL Import...\n"

# Check to see whether Let's Encrypt Mode (LE_MODE) is enabled

if [[ ${LE_MODE} == "YES" || ${LE_MODE} == "yes" || ${LE_MODE} == "Y" || ${LE_MODE} == "y" || ${LE_MODE} == "TRUE" || ${LE_MODE} == "true" || ${LE_MODE} == "ENABLED" || ${LE_MODE} == "enabled" || ${LE_MODE} == 1 ]] ; then
	LE_MODE=true
	printf "\nRunning in Let's Encrypt Mode...\n"
	PRIV_KEY=${LE_LIVE_DIR}/${UNIFI_HOSTNAME}/privkey.pem
	SIGNED_CRT=${LE_LIVE_DIR}/${UNIFI_HOSTNAME}/cert.pem
	CHAIN_FILE=${LE_LIVE_DIR}/${UNIFI_HOSTNAME}/chain.pem
else
	LE_MODE=false
	printf "\nRunning in Standard Mode...\n"
fi

if [ ${LE_MODE} == "true" ]; then
	# Check to see whether LE certificate has changed
	printf "\nInspecting current SSL certificate...\n"
	if md5sum -c ${LE_LIVE_DIR}/${UNIFI_HOSTNAME}/cert.pem.md5 &>/dev/null; then
		# MD5 remains unchanged, exit the script
		printf "\nCertificate is unchanged, no update is necessary.\n"
		exit 0
	else
	# MD5 is different, so it's time to get busy!
	printf "\nUpdated SSL certificate available. Proceeding with import...\n"
	fi
fi

# Verify required files exist
if [ ! -f ${PRIV_KEY} ] || [ ! -f ${SIGNED_CRT} ] || [ ! -f ${CHAIN_FILE} ]; then
	printf "\nMissing one or more required files. Check your settings.\n"
	exit 1
else
	# Everything looks OK to proceed
	printf "\nImporting the following files:\n"
	printf "Private Key: %s\n" "$PRIV_KEY"
	printf "Signed Certificate: %s\n" "$SIGNED_CRT"
	printf "CA File: %s\n" "$CHAIN_FILE"
fi

# Create temp files
P12_TEMP=$(mktemp)
CA_TEMP=$(mktemp)

# Stop the UniFi Controller
printf "\nStopping UniFi Controller...\n"
service ${UNIFI_SERVICE} stop

if [ ${LE_MODE} == "true" ]; then
	
	# Write a new MD5 checksum based on the updated certificate	
	printf "\nUpdating certificate MD5 checksum...\n"

	md5sum ${LE_LIVE_DIR}/${UNIFI_HOSTNAME}/cert.pem > ${LE_LIVE_DIR}/${UNIFI_HOSTNAME}/cert.pem.md5 
	
	# Create local copy of cross-signed CA File (required for keystore import)
	# Verify original @ https://www.identrust.com/certificates/trustid/root-download-x3.html
  cat > "${CA_TEMP}" <<'_EOF'
-----BEGIN CERTIFICATE-----
MIIDSjCCAjKgAwIBAgIQRK+wgNajJ7qJMDmGLvhAazANBgkqhkiG9w0BAQUFADA/
MSQwIgYDVQQKExtEaWdpdGFsIFNpZ25hdHVyZSBUcnVzdCBDby4xFzAVBgNVBAMT
DkRTVCBSb290IENBIFgzMB4XDTAwMDkzMDIxMTIxOVoXDTIxMDkzMDE0MDExNVow
PzEkMCIGA1UEChMbRGlnaXRhbCBTaWduYXR1cmUgVHJ1c3QgQ28uMRcwFQYDVQQD
Ew5EU1QgUm9vdCBDQSBYMzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEB
AN+v6ZdQCINXtMxiZfaQguzH0yxrMMpb7NnDfcdAwRgUi+DoM3ZJKuM/IUmTrE4O
rz5Iy2Xu/NMhD2XSKtkyj4zl93ewEnu1lcCJo6m67XMuegwGMoOifooUMM0RoOEq
OLl5CjH9UL2AZd+3UWODyOKIYepLYYHsUmu5ouJLGiifSKOeDNoJjj4XLh7dIN9b
xiqKqy69cK3FCxolkHRyxXtqqzTWMIn/5WgTe1QLyNau7Fqckh49ZLOMxt+/yUFw
7BZy1SbsOFU5Q9D8/RhcQPGX69Wam40dutolucbY38EVAjqr2m7xPi71XAicPNaD
aeQQmxkqtilX4+U9m5/wAl0CAwEAAaNCMEAwDwYDVR0TAQH/BAUwAwEB/zAOBgNV
HQ8BAf8EBAMCAQYwHQYDVR0OBBYEFMSnsaR7LHH62+FLkHX/xBVghYkQMA0GCSqG
SIb3DQEBBQUAA4IBAQCjGiybFwBcqR7uKGY3Or+Dxz9LwwmglSBd49lZRNI+DT69
ikugdB/OEIKcdBodfpga3csTS7MgROSR6cz8faXbauX+5v3gTt23ADq1cEmv8uXr
AvHRAosZy5Q6XkjEGB5YGV8eAlrwDPGxrancWYaLbumR9YbK+rlmM6pZW87ipxZz
R8srzJmwN0jP41ZL9c8PDHIyh8bwRLtTcm1D9SZImlJnt1ir/md2cXjbDaJWFBM5
JDGFoqgCWjBH4d1QB7wCCZAA62RjYJsWvIjJEubSfZGL+T0yjWW06XyxV3bqxbYo
Ob8VZRzI9neWagqNdwvYkQsEjgfbKbYK7p2CNTUQ
-----END CERTIFICATE-----
_EOF
fi

# Create double-safe keystore backup
if [ -s "${KEYSTORE}.orig" ]; then
	printf "\nBackup of original keystore exists!\n"
	printf "\nCreating non-destructive backup as keystore.bak...\n"
	cp ${KEYSTORE} ${KEYSTORE}.bak
else
	cp ${KEYSTORE} ${KEYSTORE}.orig
	printf "\nNo original keystore backup found.\n"
	printf "\nCreating backup as keystore.orig...\n"
fi
	 
# Export your existing SSL key, cert, and CA data to a PKCS12 file
printf "\nExporting SSL certificate and key data into temporary PKCS12 file...\n"

openssl pkcs12 -export \
-in ${SIGNED_CRT} \
-inkey ${PRIV_KEY} \
-CAfile ${CHAIN_FILE} \
-out ${P12_TEMP} -passout pass:${PASSWORD} \
-caname root -name ${ALIAS}
	
# Delete the previous certificate data from keystore to avoid "already exists" message
printf "\nRemoving previous certificate data from UniFi keystore...\n"
keytool -delete -alias ${ALIAS} -keystore ${KEYSTORE} -deststorepass ${PASSWORD}
	
# Import the temp PKCS12 file into the UniFi keystore
printf "\nImporting SSL certificate into UniFi keystore...\n"
keytool -importkeystore \
-srckeystore ${P12_TEMP} -srcstoretype PKCS12 \
-srcstorepass ${PASSWORD} \
-destkeystore ${KEYSTORE} \
-deststorepass ${PASSWORD} \
-destkeypass ${PASSWORD} \
-alias ${ALIAS} -trustcacerts
	
# Import the certificate authority data into the UniFi keystore
printf "\nImporting certificate authority into UniFi keystore...\n\n"
if [ ${LE_MODE} == "true" ]; then
	# Import with additional cross-signed CA file
	java -jar ${JAVA_DIR}/lib/ace.jar import_cert \
	${SIGNED_CRT} \
	${CHAIN_FILE} \
	${CA_TEMP}
else
	# Import in standard mode
	java -jar ${JAVA_DIR}/lib/ace.jar import_cert \
	${SIGNED_CRT} \
	${CHAIN_FILE}
fi	

# Clean up temp files
printf "\nRemoving temporary files...\n"
rm -f ${P12_TEMP}
rm -f ${CA_TEMP}
	
# Restart the UniFi Controller to pick up the updated keystore
printf "\nRestarting UniFi Controller to apply new Let's Encrypt SSL certificate...\n"
service ${UNIFI_SERVICE} start

# That's all, folks!
printf "\nDone!\n"

exit 0
