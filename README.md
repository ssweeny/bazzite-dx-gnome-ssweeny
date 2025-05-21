# bazzite-gnome-dx-ssweeny

My customized version of Universal Blue's Bazzite with some System76 drivers and a few niceties from Pop!_OS added.

* `bazzite-gnome-dx-ssweeny`: Based on `bazzite-dx-gnome:stable`

## Installation

To rebase an existing atomic Fedora installation to the latest build:

- First rebase to the unsigned image, to get the proper signing keys and policies installed:
  ```
  rpm-ostree rebase ostree-unverified-registry:ghcr.io/ssweeny/bazzite-dx-gnome-ssweeny:latest
  ```
- Reboot to complete the rebase:
  ```
  systemctl reboot
  ```
- Then rebase to the signed image, like so:
  ```
  rpm-ostree rebase ostree-image-signed:docker://ghcr.io/ssweeny/bazzite-dx-gnome-ssweeny:latest
  ```
- Reboot again to complete the installation
  ```
  systemctl reboot
  ```

This image follows the `bazzite-dx-gnome` `stable` tag.

## ISO

If building on Fedora Atomic, you can generate an offline ISO with the instructions available [here](https://blue-build.org/learn/universal-blue/#fresh-install-from-an-iso). These ISOs cannot unfortunately be distributed on GitHub for free due to large sizes, so for public projects something else has to be used for hosting.

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/ssweeny/bazzite-dx-gnome-ssweeny
```

