#!/bin/bash

# Needs sudoers:
# nagios  ALL=(root) NOPASSWD: /home/nagios/check_incus/check_incus.sh

name="$1"

if [ -z "$name" ]
then
    echo "UNKNOWN - usage: check_incus_instance <name>"
    exit 3
fi

if ! status=$(incus list "^${name}\$" --format=csv -c s 2>&1)
then
    echo "UNKNOWN - incus: $status"
    exit 3
fi

case "$status" in
    RUNNING)
        echo "OK - $name is running"
        exit 0
        ;;
    "")
        echo "CRITICAL - $name not found"
        exit 2
        ;;
    *)
        echo "CRITICAL - $name is $status"
        exit 2
        ;;
esac
