#!/bin/bash

# Get PowerDNS Recursor configuration file
curl -sLO https://raw.githubusercontent.com/ebal/libredns-docker/refs/heads/main/rec.yml

# Get StevenBlack host file
curl -sLo hosts https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts

# Get OpenNic Root NameServers
OPENNIC_ROOTNS=""
OPENNIC_ROOTNS=$(curl -sL --retry 10 --retry-delay 5 'https://api.opennicproject.org/geoip/?bare&res=1')

# Exit script if in the end OPENNIC_ROOTNS is empty
if [ -z "$OPENNIC_ROOTNS" ]; then
    echo "Failed to get OpenNIC Root NameServers"
    exit 1
fi

# Get Openic root NS
dig . NS @"$OPENNIC_ROOTNS" +noall +answer +additional > OpenNIC

