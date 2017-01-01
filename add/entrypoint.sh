#!/bin/bash
set -e

#
#Time zone
#
echo "Europe/Moscow" > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata

service apache2 start
sleep infinity

