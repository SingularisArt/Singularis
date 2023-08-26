#!/usr/bin/sh

INSTALL_FOLDER="$HOME/.local/share/nvim"

# Install netcoredbg
rm -rf "$INSTALL_FOLDER/netcoredbg"
RELEASE_URL=https://github.com/Samsung/netcoredbg/releases/download/2.2.3-992/netcoredbg-linux-amd64.tar.gz
curl -k -L $RELEASE_URL --output netcoredbg.tar.gz && tar -xzf netcoredbg.tar.gz -C "$INSTALL_FOLDER" && rm netcoredbg.tar.gz
