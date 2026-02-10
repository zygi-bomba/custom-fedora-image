#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail
set -x # Debug output

# Install Nix package manager
if ! curl -fsSL https://install.determinate.systems/nix | sh -s -- install --no-confirm --init none; then
    echo "Nix installation failed"
    exit 1
fi

# Install the devbox binary to /usr/bin
if ! curl -fsSL https://get.jetpack.io/devbox | bash -s -- -f; then
    echo "Devbox installation failed"
    exit 1
fi
