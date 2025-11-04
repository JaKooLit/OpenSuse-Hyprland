# WARP.md

This file provides guidance to WARP (warp.dev) when working with code in this repository.

## Essential commands

- Install (interactive)
  - chmod +x install.sh && ./install.sh
- Install with a preset file
  - ./install.sh --preset presets/my-desktop.preset
  - Example preset (ON/OFF strings are read via `source`):
    ```bash
    gtk_themes="ON"
    bluetooth="OFF"
    thunar="ON"
    ags="ON"
    sddm="OFF"
    sddm_theme="OFF"
    xdph="ON"
    zsh="ON"
    pokemon="OFF"
    rog="OFF"
    dots="ON"
    input_group="OFF"
    nvidia="OFF"
    ```
- Re-run a specific module (from repo root; do not cd into install-scripts)
  - ./install-scripts/<script-name>.sh
  - Examples: ./install-scripts/gtk_themes.sh, ./install-scripts/sddm.sh, ./install-scripts/04-Final-Check.sh
- Auto installer (local wrapper)
  - ./auto-install.sh
- Uninstall (guided)
  - chmod +x uninstall.sh && ./uninstall.sh
- Logs
  - All runs write timestamped logs to Install-Logs/
  - Tail last log: ls -t Install-Logs | head -n1 | xargs -I{} tail -n 200 -f Install-Logs/{}

Notes from README that affect usage
- Do not run as root; run from a directory where you have write permissions (e.g., your home).
- If a login manager like GDM/LightDM is active, SDDM install options will be disabled until you stop/disable them and reboot.
- On NVIDIA systems, the script can configure the G06 driver when you select the NVIDIA option.
- In VMs, enable 3D acceleration or Hyprland may not start.

## High-level architecture

This repo is a modular Bash installer for Hyprland on openSUSE Tumbleweed. There is no build or test suite; development involves editing shell modules and running them.

- Entry point: install.sh
  - Guards: not-root, ensures `whiptail`/`pciutils` exist, logs to Install-Logs/.
  - Interactive flow (whiptail) selects features; supports `--preset <file>` by sourcing ON/OFF flags.
  - Environment detection: active login managers (disables SDDM path), NVIDIA GPU prompt.
  - Orchestration order (core): adds Packman repo → installs base deps → fonts → Hyprland core → ecosystem → forced installs → OBS/opi pkgs → wallust → optional selections → final cleanup → final package check.
  - Executes modules via a helper that keeps paths and executability consistent.

- Module library: install-scripts/
  - Global_functions.sh: shared helpers used by all modules
    - zypper/opi install variants (normal, no-recommends, force, auto-agree), cargo install, package removal
    - progress spinner, colorized output, central logging
  - Core modules (representative)
    - 00-add-repo.sh (Packman), 01-dependencies.sh (patterns + opi), hyprland.sh (Hyprland packages)
    - 02-hypr-pkgs.sh (main and secondary desktop packages, no-recommends list, uninstall conflicts), 03-opi-pkgs.sh (OBS via `opi`)
    - force-install.sh (reinstall edge cases), 04-Final-Check.sh (verifies essential packages and /usr/local tools)
  - Optional feature modules (selected in install.sh)
    - Examples: sddm.sh and sddm_theme.sh, gtk_themes.sh, xdph.sh (xdg-desktop-portal-hyprland), bluetooth.sh, thunar.sh (+ thunar_default.sh), ags.sh (builds AGS v1.9.0 via git/npm/meson and installs wrapper in /usr/local/bin), nvidia.sh, rog.sh, dotfiles-main.sh, wallust.sh, InputGroup.sh, zsh.sh, zsh_pokemon.sh

- Automation/maintenance
  - auto-install.sh: clone-or-update then run install.sh
  - uninstall.sh: interactive package and config removal (zypper removes, deletes ~/.config/* selections)

## Repository documents considered

- README.md: usage, prerequisites, uninstall availability, and operational caveats (NVIDIA, SDDM, VM acceleration, re-running modules from repo root).
- CONTRIBUTING.md and .github/PULL_REQUEST_TEMPLATE.md: contribution flow; no repo-defined lint/typecheck/test commands.

## What’s not here

- No configured linter, formatter, or test suite in this repo. If you need linting, run your preferred shell tools locally (e.g., shellcheck, shfmt) but there are no project scripts for them.
