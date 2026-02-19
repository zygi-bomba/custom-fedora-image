#!/bin/bash
# Configuration
export VAULT_ADDR="http://192.168.2.100:8200"
export VAULT_TOKEN="root-token"

# 1. Fetch Home Secrets
HOME_PRIV=$(vault kv get -field=private_key secrets/vpn/home)
HOME_ADDR=$(vault kv get -field=home_addr secrets/vpn/home)
HOME_PSK=$(vault kv get -field=preshared_key secrets/vpn/home)
HOME_PUB=$(vault kv get -field=public_key secrets/vpn/home)

# 2. Fetch Work Secrets
ISOD_USER=$(vault kv get -field=username secrets/vpn/pw)
ISOD_PASS=$(vault kv get -field=password secrets/vpn/pw)

# 3. Apply to NetworkManager Memory
# Home WireGuard
nmcli connection modify home \
  wireguard.private-key "$HOME_PRIV" \
  wireguard-peer."$HOME_PUB".endpoint "$HOME_ADDR" \
  wireguard-peer."$HOME_PUB".preshared-key "$HOME_PSK"

# PW AnyConnect (Split PW)
nmcli connection modify "Split PW" \
  vpn.secrets "form:main:username=$ISOD_USER, form:main:password=$ISOD_PASS"

# 4. Establish Connections
nmcli connection up home
nmcli connection up "Split PW"
