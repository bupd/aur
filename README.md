# AUR Packages

[![Validate PKGBUILDs](https://github.com/bupd/aur/actions/workflows/validate.yml/badge.svg)](https://github.com/bupd/aur/actions/workflows/validate.yml)
[![Check for Updates](https://github.com/bupd/aur/actions/workflows/check_updates.yml/badge.svg)](https://github.com/bupd/aur/actions/workflows/check_updates.yml)
[![AUR Maintainer](https://img.shields.io/badge/AUR-bupd-1793d1?logo=archlinux&logoColor=white)](https://aur.archlinux.org/packages?K=bupd&SeB=m)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)

Arch User Repository packages maintained by bupd. See [list of packages](https://aur.archlinux.org/packages?K=bupd&SeB=m).

## Packages

| Package | Description | AUR |
|---------|-------------|-----|
| [dagger-git](dagger-git/) | Programmable CI/CD engine (git version) | [![AUR](https://img.shields.io/aur/version/dagger-git)](https://aur.archlinux.org/packages/dagger-git) |
| [kitops](kitops/) | MLOps toolkit for packaging AI/ML models | [![AUR](https://img.shields.io/aur/version/kitops)](https://aur.archlinux.org/packages/kitops) |
| [harbor-cli](harbor-cli/) | CLI for Harbor container registry | [![AUR](https://img.shields.io/aur/version/harbor-cli)](https://aur.archlinux.org/packages/harbor-cli) |
| [oras-git](oras-git/) | OCI Registry As Storage (git version) | [![AUR](https://img.shields.io/aur/version/oras-git)](https://aur.archlinux.org/packages/oras-git) |
| [pack-cli-git](pack-cli-git/) | Cloud Native Buildpacks CLI (git version) | [![AUR](https://img.shields.io/aur/version/pack-cli-git)](https://aur.archlinux.org/packages/pack-cli-git) |
| [git-donkey](git-donkey/) | Git workflow automation tool | [![AUR](https://img.shields.io/aur/version/git-donkey)](https://aur.archlinux.org/packages/git-donkey) |

## Installation

```bash
# Using yay
yay -S <package-name>

# Using paru
paru -S <package-name>
```

## Contributing

1. Fork this repository
2. Make changes to the PKGBUILD
3. Update .SRCINFO: `makepkg --printsrcinfo > .SRCINFO`
4. Submit a pull request
