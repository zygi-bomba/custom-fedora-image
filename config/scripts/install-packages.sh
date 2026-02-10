#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Install Nix package manager
curl -fsSL https://install.determinate.systems/nix | sh -s -- install --no-confirm -- --no-start-daemon --init none

# Install the devbox binary to /usr/bin
curl -fsSL https://get.jetpack.io/devbox | bash -s -- -f
