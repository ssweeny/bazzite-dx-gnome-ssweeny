#!/bin/bash

set -ouex pipefail

### Install packages

# Install pop-shell extension
dnf5 install -y \
    gnome-shell-extension-pop-shell \
    gnome-shell-extension-pop-shell-shortcut-overrides

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

dnf5 copr enable -y ublue-os/staging
dnf5 install -y \
    gnome-shell-extension-tailscale-gnome-qs
dnf5 copr disable -y ublue-os/staging

# Add system76-thelio-io driver
dnf copr enable -y ssweeny/system76-hwe
KERNEL_VERSION="$(rpm -q --queryformat="%{EVR}.%{ARCH}" kernel-core)"
skopeo copy "docker://ghcr.io/ublue-os/akmods-extra:bazzite-$(rpm -E %fedora)-${KERNEL_VERSION}" dir:/tmp/akmods
AKMODS_TARGZ=$(jq -r '.layers[].digest' </tmp/akmods/manifest.json | cut -d : -f 2)
tar -xvzf /tmp/akmods/"$AKMODS_TARGZ" -C /tmp/
dnf5 install -y /tmp/rpms/kmods/*system76*.rpm
dnf copr disable -y ssweeny/system76-hwe

# Install COSMIC desktop as well because why not
dnf5 copr enable -y ryanabx/cosmic-epoch
dnf5 -y install @cosmic-desktop @cosmic-desktop-apps
dnf5 copr disable -y ryanabx/cosmic-epoch

dnf5 clean all

# Set up System76 power and firmware deaemons
systemctl enable com.system76.PowerDaemon.service
systemctl enable system76-firmware-daemon
systemctl mask upower.service
