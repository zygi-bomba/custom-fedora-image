#!/bin/bash
# Konfiguracja
export VAULT_ADDR="http://192.168.2.100:8200"
export VAULT_TOKEN="root-token"

HOME_JSON=$(vault kv get -format=json secrets/vpn/home)
PW_JSON=$(vault kv get -format=json secrets/vpn/pw)

HOME_PRIV=$(echo "$HOME_JSON" | jq -r '.data.data.private_key')
HOME_ADDR=$(echo "$HOME_JSON" | jq -r '.data.data.home_addr')
HOME_PSK=$(echo "$HOME_JSON" | jq -r '.data.data.preshared_key')
HOME_PUB=$(echo "$HOME_JSON" | jq -r '.data.data.public_key')

ISOD_USER=$(echo "$PW_JSON" | jq -r '.data.data.username')
ISOD_PASS=$(echo "$PW_JSON" | jq -r '.data.data.password')

nmcli connection modify home \
  wireguard.private-key "$HOME_PRIV" \
  wireguard-peer."$HOME_PUB".endpoint "$HOME_ADDR" \
  wireguard-peer."$HOME_PUB".preshared-key "$HOME_PSK"

nmcli connection modify "Split PW" \
  vpn.secrets "form:main:username=$ISOD_USER, form:main:password=$ISOD_PASS"

nmcli connection up home
nmcli connection up "Split PW"
