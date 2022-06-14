#!/bin/bash

interface='eth0'
user='user@mail.com'
pass='password.user'
hostname='user.ddns.net'

url="https://dynupdate.no-ip.com/nic/update"
agent="Personal noip-ducv6/linux-v1.0"

lastaddr=''

update_ip () {
    addr=$(ip -6 addr show dev $interface | sed -e'/inet6/,/scope global/s/^.*inet6 \([^ ]*\)\/.*scope global.*$/\1/;t;d')
    if [[ $lastaddr != $addr ]]; then
        echo "updating to $addr"
        out=$(curl --get --silent --show-error --user-agent "$agent" --user "$user:$pass" -d "hostname='rhennan.ddns.net'

        echo $out

        if [[ $out == nochg* ]] || [[ $out == good* ]]; then
            lastaddr=$(host hostname | awk '/has IPv6 address/ { print $5 }')
        elif [[ $out == 911 ]]; then
            echo "911 response, waiting 30 minutes"
            sleep 25m
        else
            exit 1
        fi
    fi
}
update_ip | logger
while sleep 5m; do
    update_ip | logger
done
