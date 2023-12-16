#!/bin/bash

DNS="223.5.5.5"
HOSTS_FILE="hosts.txt"
DNSMASQ_CONF="dnsmasq.conf"
ADGUARD_CONF="adguardhome.txt"

_add_host() {
  local host="$1"
  echo "server=/$host/$DNS" >> $DNSMASQ_CONF
  echo "[/$host/]$DNS" >> $ADGUARD_CONF
}

make_files() {
  echo -n "" > $DNSMASQ_CONF
  echo -n "" > $ADGUARD_CONF

  local tmp_hosts=$(mktemp)
  cat $HOSTS_FILE |egrep -v '^ *$|^ *#' > $tmp_hosts
  while IFS='' read -r line; do
    _add_host $line
  done < "$tmp_hosts"

  rm -f $tmp_hosts
}

if [ "$1" ]; then
    DNS="$1"
fi

make_files

