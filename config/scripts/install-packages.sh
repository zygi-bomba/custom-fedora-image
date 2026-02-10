#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# 1. Create the /nix mount point (Standard for Fedora Atomic)
mkdir -p /var/nix
if [ ! -L /nix ]; then
    ln -s /var/nix /nix
fi

# 2. Install Nix using the Determinate Installer
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --no-confirm

# 3. Install Devbox
curl -fsSL https://get.jetify.com/devbox | bash -s -- -f
