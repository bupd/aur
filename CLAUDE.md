# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This repository manages Arch User Repository (AUR) packages maintained by bupd. Each subdirectory represents an AUR package containing PKGBUILD files and related configuration.

## Structure

- Each package lives in its own directory (e.g., `kitops/`, `dagger-git/`, `harbor-cli/`)
- Some packages are git submodules pointing to AUR remotes (defined in `.gitmodules`)
- Non-submodule directories (`dagger-bin/`, `dagger-main/`, `orasbin/`, `orasgitt/`, `slack-desktop/`) are local copies

## Key Files Per Package

- `PKGBUILD` - Package build script (Arch Linux format)
- `.SRCINFO` - Generated package metadata (run `makepkg --printsrcinfo > .SRCINFO`)
- `.nvchecker.toml` - Version checking config for nvchecker tool

## Common Commands

### Build a package locally
```bash
cd <package-dir>
makepkg -si          # Build and install
makepkg -s           # Build only
makepkg -f           # Force rebuild
```

### Check for upstream version updates
```bash
./newver-checker     # Runs nvchecker across all packages
```

### Generate .SRCINFO after PKGBUILD changes
```bash
makepkg --printsrcinfo > .SRCINFO
```

### Push changes to AUR (for submodule packages)
```bash
cd <package-dir>
git add PKGBUILD .SRCINFO
git commit -m "feat: update <pkgname> v<version>"
git push
```

## PKGBUILD Patterns

Binary packages (e.g., `kitops`) download pre-built binaries using architecture-specific sources:
- `source_x86_64`, `source_i686`, `source_aarch64`

Git packages (e.g., `dagger-git`) build from source:
- `makedepends` includes `git` and build tools
- Uses `prepare()`, `build()`, and `package()` functions

## CI/CD

GitHub Actions workflow (`.github/workflows/check_updates.yml`) runs daily to:
1. Check version updates using nvchecker
2. Create PRs when updates are detected

## Commit Message Format

Use titlecase for PR titles. Commit messages follow: `feat: update <pkgname> v<version>`
