# Justfile for nix-config management across hosts

default:
    @just --list

# Switch configuration automatically based on host/environment
switch:
    #!/usr/bin/env bash
    set -euo pipefail
    os="$(uname -s)"
    if [ "$os" = "Darwin" ]; then
        echo "==> Detected macOS (apfel)"
        nh darwin switch
    elif grep -qi microsoft /proc/version 2>/dev/null; then
        echo "==> Detected WSL"
        nh os switch -H wsl
    else
        echo "==> Detected Linux (debian / server):"
        nh home switch
    fi

# Explicit target recipes
wsl:
    nh system switch -H wsl

darwin:
    nh darwin switch

home:
    nh home switch

# Update herdr flake input and switch
update-herdr:
    nix flake update herdr

# Commit and sync nix-config
update:
    git commit -a -m "update: flake" && git push && git pull
