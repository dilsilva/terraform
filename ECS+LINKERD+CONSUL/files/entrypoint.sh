#!/bin/sh
export HOST=$(curl --retry 5 --connect-timeout 3 -s 169.254.169.254/latest/meta-data/local-hostname)
export LOCAL_IP=$(curl --retry 5 --connect-timeout 3 -s 169.254.169.254/latest/meta-data/local-ipv4)
exec "$@"