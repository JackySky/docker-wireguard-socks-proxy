#!/bin/sh

set -e

sigterm_handler() {    
  echo "Received SIGTERM. Cleaning up..."
  kill -SIGTERM `pgrep sockd`       2>/dev/null
  exit 0
}

trap 'sigterm_handler' SIGTERM

ifname=$(basename $(ls -1 /etc/wireguard/*.conf | head -1) .conf)
sed -i'' -e "s/__replace_me_ifname__/$ifname/" /etc/sockd.conf

resolvconf -u 
echo nameserver 1.1.1.1 >> /etc/resolv.conf
echo nameserver 8.8.8.8 >> /etc/resolv.conf

wg-quick up /etc/wireguard/$ifname.conf
/usr/sbin/sockd
