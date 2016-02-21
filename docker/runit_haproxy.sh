#!/usr/bin/env bash
cd /srv/odania

echo "Creating haproxy config"
rake odania:haproxy:internal

# Starting haproxy
exec haproxy -f /usr/local/etc/haproxy/haproxy.cfg -p /run/haproxy.pid
