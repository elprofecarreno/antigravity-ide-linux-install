#!/bin/sh
SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
CONFIG_FILE="$SCRIPT_DIR/antigravity.conf"

if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: no se encontró el archivo de configuración $CONFIG_FILE." >&2
    exit 1
fi

. "$CONFIG_FILE"

if [ -z "$ANTIGRAVITY_VERSION" ]; then
    echo "Error: ANTIGRAVITY_VERSION no está definida en $CONFIG_FILE." >&2
    exit 1
fi

ANTIGRAVITY_URL="https://edgedl.me.gvt1.com/edgedl/release2/j0qc3/antigravity/stable/$ANTIGRAVITY_VERSION/linux-x64/Antigravity%20IDE.tar.gz"

is_ubuntu() {
    if [ ! -r /etc/os-release ]; then
        return 1
    fi

    if grep -qi '^ID=ubuntu$' /etc/os-release; then
        return 0
    fi

    grep -qi '^ID_LIKE=.*ubuntu' /etc/os-release
}

is_apparmor_enabled() {
    [ -r /sys/module/apparmor/parameters/enabled ] && grep -q '^[Yy]' /sys/module/apparmor/parameters/enabled
}

configure_apparmor_if_needed() {
    if ! is_ubuntu || ! is_apparmor_enabled; then
        return
    fi

    if ! command -v sudo >/dev/null 2>&1; then
        echo "Advertencia: AppArmor está activo, pero no se encontró sudo para configurar el perfil de antigravity-ide." >&2
        return
    fi

    echo "CONFIGURE APPARMOR PROFILE"
    if sudo tee /etc/apparmor.d/antigravity-ide >/dev/null <<EOF
abi <abi/4.0>,
include <tunables/global>

profile antigravity-ide $HOME/antigravity-ide/antigravity-ide flags=(unconfined) {
  userns,

  # Site-specific additions and overrides.
  include if exists <local/antigravity-ide>
}
EOF
    then
        if command -v apparmor_parser >/dev/null 2>&1; then
            sudo apparmor_parser -r /etc/apparmor.d/antigravity-ide
        fi
        echo "AppArmor profile configured at /etc/apparmor.d/antigravity-ide"
    else
        echo "Advertencia: no se pudo escribir el perfil de AppArmor." >&2
    fi
}

if ! command -v curl >/dev/null 2>&1; then
    echo "Error: curl no está instalado." >&2
    echo "Instálalo e intenta nuevamente." >&2
    exit 1
fi

echo "INSTALL ANTIGRAVITY IDE"
FILE=Antigravity-IDE
rm -rf "$FILE" "$FILE.tar.gz"
curl -o "$FILE.tar.gz" "$ANTIGRAVITY_URL"
tar -xvf "$FILE.tar.gz"
rm -rf $HOME/antigravity-ide
rm -rf $HOME/.antigravity-ide
rm -rf $HOME/.gemini
rm -rf $HOME/.config/Antigravity
mkdir -p $HOME/antigravity-ide
mv "Antigravity IDE"/* $HOME/antigravity-ide/
rm -rf "Antigravity IDE"
rm -rf "$FILE" "$FILE.tar.gz"

if ! grep -q 'export PATH="$HOME/antigravity-ide/bin:$PATH"' "$HOME/.bashrc"; then
    echo '' >> "$HOME/.bashrc"
    echo '# Antigravity IDE' >> "$HOME/.bashrc"
    echo 'export PATH="$HOME/antigravity-ide/bin:$PATH"' >> "$HOME/.bashrc"
fi

echo "CREATE ICON"
mkdir -p "$HOME/.local/share/applications"
cp "$SCRIPT_DIR/antigravity-ide.desktop.template" "$SCRIPT_DIR/antigravity-ide.desktop"
sed -i "s|__HOME__|$HOME|g" "$SCRIPT_DIR/antigravity-ide.desktop"
mv "$SCRIPT_DIR/antigravity-ide.desktop" "$HOME/.local/share/applications/"

echo "PERMISSION ICON"
chmod +x "$HOME/.local/share/applications/antigravity-ide.desktop"

echo "UPDATE DESKTOP ICON"
update-desktop-database "$HOME/.local/share/applications/"

configure_apparmor_if_needed