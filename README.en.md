# Visual Code Linux Install

[Version en espanol](./README.md)

This project automates a local installation of Visual Studio Code on Linux without using the system package manager. The script downloads a packaged VS Code build, installs it into `~/code`, adds the binary to your `PATH`, and creates a desktop launcher so you can open it from the applications menu.

## What it is for

This project is useful if you want to:

- Install VS Code inside your home directory.
- Avoid a system-wide installation.
- Create an applications menu entry.
- Launch VS Code from the terminal with the `code` command.

## What the script does

When you run [install.sh](./install.sh), it performs these steps:

1. Checks that `curl` is installed.
2. Downloads a stable Linux x64 `.tar.gz` build of VS Code.
3. Removes any previous installation in `~/code` and copies the new version there.
4. Adds `~/code/bin` to `~/.bashrc` if it is not already present.
5. Generates a `.desktop` file from [code.desktop.template](./code.desktop.template).
6. Moves that launcher into `~/.local/share/applications/`.
7. Updates the desktop shortcut database.

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

You can use VS Code in two ways:

- From the applications menu by searching for `Visual Code`.
- From a terminal with the `code` command.

If the `code` command does not work immediately, open a new terminal or reload your shell configuration:

```bash
source ~/.bashrc
```

## Uninstall

To revert the installation, run:

```bash
chmod +x uninstall.sh
./uninstall.sh
```

The script removes `~/code`, deletes the launcher at `~/.local/share/applications/code.desktop`, and removes the `PATH` entry that was added to `~/.bashrc`.

## Screenshots

Applications menu:

![Visual Code in the applications menu](./img/code-1.png)

VS Code welcome screen:

![Visual Studio Code welcome screen](./img/code-2.png)

## Important notes

- The script fully replaces the contents of `~/code` every time it runs.
- The download URL is hardcoded in the script, so it installs that specific VS Code version.
- It is intended for Linux x64 systems.
- It includes an uninstall script to revert the main changes.