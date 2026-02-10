#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install linux --init none --no-start-daemon --no-confirm && 
echo "experimental-features = nix-command flakes" >> /etc/nix/nix.conf && \
systemctl enable nix-daemon.service

curl -fsSL https://get.jetify.com/devbox | bash -s -- -f
