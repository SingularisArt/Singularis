#!/usr/bin/bash

find ~/.local/share/gnupg -type f -exec chmod 600 {} \;
find ~/.local/share/gnupg -type d -exec chmod 700 {} \;
