#!/bin/bash

set -ouex pipefail

### Install packages

# Install a few GNOME extensions
dnf5 install -y \
    gnome-shell-extension-dash-to-dock \
    gnome-shell-extension-pop-shell \
    gnome-shell-extension-pop-shell-shortcut-overrides \
    gnome-shell-extension-vertical-workspaces

# Add a few system76 packages
dnf5 copr enable -y szydell/system76
dnf5 install -y \
    system76-power \
    system76-firmware
dnf5 copr disable -y szydell/system76

# Add a few goodies from bluefin
dnf5 copr enable -y ublue-os/packages
dnf5 install -y \
    bluefin-backgrounds
dnf5 copr disable -y ublue-os/packages

# Install COSMIC desktop as well because why not
dnf5 -y install @cosmic-desktop

dnf5 clean all

# Set up System76 power and firmware deaemons
systemctl enable com.system76.PowerDaemon.service
systemctl enable system76-firmware-daemon

# system76-power conflicts with tuned
systemctl mask tuned.service tuned-ppd.service
