#!/usr/bin/env bash

. util.sh

checkroot

ufw allow 80/tcp    || { log "Failed to add firewall rule"; exit 1; }
ufw allow 443/tcp   || { log "Failed to add firewall rule"; exit 1; }
ufw allow ${SSH_PORT}/tcp || { log "Failed to add firewall rule"; exit 1; }
ufw allow ${OPENVPN_PORT}/udp || { log "Failed to add firewall rule"; exit 1; }
ufw enable || { log "Failed to enable firewall."; exit 1; }
