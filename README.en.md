# Antigravity IDE Linux Install

[Versión en español](./README.md)

This project automates a local installation of Antigravity IDE on Linux without using the system package manager. The script downloads a packaged Antigravity IDE build, installs it into `~/antigravity-ide`, adds the binary to your `PATH`, and creates a desktop launcher so you can open it from the applications menu.

## What it is for

This project is useful if you want to:

- Install Antigravity IDE inside your home directory.
- Avoid a system-wide installation.
- Create an applications menu entry.
- Launch Antigravity IDE from the terminal with the `antigravity-ide` command.

## What the script does

When you run [install.sh](./install.sh), it performs these steps:

1. Checks that `curl` is installed.
2. Downloads a stable Linux x64 `.tar.gz` build of Antigravity IDE.
3. Removes previous installation folders (`~/antigravity-ide`, `~/.antigravity-ide`, `~/.gemini`) and copies the new version into `~/antigravity-ide`.
4. Adds `~/antigravity-ide/bin` to `~/.bashrc` if it is not already present.
5. Generates a `.desktop` file from [antigravity-ide.desktop.template](./antigravity-ide.desktop.template).
6. Moves that launcher into `~/.local/share/applications/antigravity-ide.desktop`.
7. Sets execution permissions on the launcher and updates the desktop shortcut database (`update-desktop-database`).

## Requirements

- Linux
- `curl`
- `tar`
- `grep`
- `sed`
- `update-desktop-database`

If `update-desktop-database` is missing on your system, it usually comes from the `desktop-file-utils` package.

## How to use it

From the project root, run:

```bash
chmod +x install.sh
./install.sh
```

## After installation

You can use Antigravity IDE in two ways:

- From the applications menu by searching for `Antigravity IDE`.
- From a terminal with the `antigravity-ide` command.

If the `antigravity-ide` command does not work immediately, open a new terminal or reload your shell configuration:

```bash
source ~/.bashrc
```

## Uninstall

To revert the installation, run:

```bash
chmod +x uninstall.sh
./uninstall.sh
```

The script removes `~/antigravity-ide`, `~/.antigravity-ide`, and `~/.gemini`, deletes the launcher at `~/.local/share/applications/antigravity-ide.desktop`, and removes the `PATH` entry that was added to `~/.bashrc`.

## Important notes

- The script fully replaces the contents of `~/antigravity-ide`, `~/.antigravity-ide`, and `~/.gemini` every time it runs.
- The download URL is hardcoded in the script, so it installs that specific Antigravity IDE version.
- It is intended for Linux x64 systems.
- It includes an uninstall script to revert the main changes.
