#!/usr/bin/env bash

set -x

# Test for a binary in $PATH.
in_path () {
    type -p "$1" >/dev/null
}

# Verbose in_path().
check_for () {
    if ! in_path "$1"; then
        return 1
    fi
}

# ------------

OS=
case $(uname -s) in
    Darwin)
        OS=macos

        pkg_install () {
            brew install "$@"
        }
        ;;

    Linux)
        # Test both for magic pathes and supposed package manager
        # binaries.

        if in_path pacman && [[ -f /etc/arch-release ]]; then
            OS=arch

            pkg_install () {
                pacman -S --noconfirm "$@"
            }
        elif in_path apt-get && [[ -f /etc/debian_version ]]; then
            OS=debian

            pkg_install () {
                apt-get --assume-yes install "$@"
            }
        elif in_path dnf && [[ -f /etc/redhat-release ]]; then
            OS=fedora

            pkg_install () {
                dnf --assumeyes install "$@"
            }
        elif in_path zypper; then
            # Quote from https://en.opensuse.org/Etc_SuSE-release:
            #
            # The file /etc/SuSE-release has been marked as
            # depreciated since openSUSE 13.1 and will no longer be
            # present in openSUSE Leap 15.0. Please adjust your
            # software (or file bug reports) to use /etc/os-release
            # instead.
            #
            if [[ -f /etc/SuSE-release ]] || grep -iq opensuse /etc/os-release; then
                OS=suse

                pkg_install () {
                    zypper install --no-confirm "$@"
                }
            fi
        fi
        ;;
esac

[[ -n $OS ]] || bye 'Your OS is not supported.'

clear

cat <<-EOF
Welcome to
    ██████╗  █████╗ ███████╗██╗  ██╗███████╗██╗     ██╗██╗  ██╗
    ██╔══██╗██╔══██╗██╔════╝██║  ██║██╔════╝██║     ██║╚██╗██╔╝
    ██████╔╝███████║███████╗███████║█████╗  ██║     ██║ ╚███╔╝ 
    ██╔══██╗██╔══██║╚════██║██╔══██║██╔══╝  ██║     ██║ ██╔██╗ 
    ██████╔╝██║  ██║███████║██║  ██║██║     ███████╗██║██╔╝ ██╗
    ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═╝     ╚══════╝╚═╝╚═╝  ╚═╝
This script will install the following software:
* python
* pip
* npm
* nodejs
* vlc
* pirate-get
* subliminal
* peerflix
EOF

# Generic tools to packages mapping.
declare -A deps=(
    [curl]=curl
    [pip3]=python3-pip
    [npm]=npm
    [vlc]=vlc
)

MACOS_VLC=/Applications/VLC.app/Contents/MacOS/VLC

# OS-specific overrides for $deps.
case $OS in
    macos)
        deps[pip3]=python       # Provides pip3
        deps[npm]=node          # Provides npm
        deps[$MACOS_VLC]=$MACOS_VLC
        unset -v 'deps[vlc]'
        ;;

    arch)
        deps[pip3]=python-pip
        ;;
esac

# Skip satisfied deps.
for bin in "${!deps[@]}"; do
    if check_for "$bin"; then
        unset -v "deps[$bin]"
    fi
done

# Install unmet deps.
if (( ndeps=${#deps[@]} )); then
    if [[ $OS == macos ]]; then

        # Special case. https://formulae.brew.sh/cask/vlc
        if [[ -v deps[$MACOS_VLC] ]]; then
            pkg_install --cask vlc
            unset -v 'deps[$MACOS_VLC]'
            ((ndeps--))
        fi
    fi

    (( ndeps )) && pkg_install "${deps[@]}"
fi

# ------------

pip3 install --user pirate-get --upgrade
pip3 install --user subliminal --upgrade

rm -rf /usr/local/lib/node_modules/peerflix
npm uninstall -g peerflix --save
npm install -g peerflix

touch ~/bashflix_previously.txt
mkdir -p ~/bin
curl -s https://raw.githubusercontent.com/0zz4r/bashflix/master/bashflix.sh -o ~/bin/bashflix
chmod +x ~/bin/bashflix
echo "export PATH=\"$HOME/bin:$PATH\"" >> ~/.bashrc
echo "export PATH=\"$HOME/bin:$PATH\"" >> ~/.zshrc
source ~/.bashrc
source ~/.zshrc
bashflix -h

