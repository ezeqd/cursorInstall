#!/bin/bash

set -e

# 📁 Variables
CURSOR_DIR="$HOME/.local/bin"
DESKTOP_FILE="$HOME/.local/share/applications/cursor.desktop"
ICON_TARGET="$HOME/.local/share/icons/cursor.png"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ICON_SOURCE="$SCRIPT_DIR/cursor.png"
VERSION_JSON="https://raw.githubusercontent.com/oslook/cursor-ai-downloads/main/version-history.json"

echo "🚀 Instalando Cursor para Linux (.AppImage)..."

# 1. Crear carpetas necesarias
mkdir -p "$CURSOR_DIR" "$HOME/.local/share/icons" "$HOME/.local/share/applications"

# 2. Obtener URL del AppImage desde el JSON version-history
echo "🔍 Descargando version-history.json..."
APPIMAGE_URL=$(curl -s "$VERSION_JSON" | grep -oP 'https.*?Cursor-.*?\.AppImage' | head -n 1)

if [[ -z "$APPIMAGE_URL" ]]; then
    echo "❌ No se pudo obtener el archivo AppImage desde version-history.json. Abortando."
    exit 1
fi

echo "📥 Descargando AppImage:"
echo "$APPIMAGE_URL"

# 3. Descargar AppImage
curl -L "$APPIMAGE_URL" -o "$CURSOR_DIR/cursor"
chmod +x "$CURSOR_DIR/cursor"

# 4. Copiar ícono si existe
if [ -f "$ICON_SOURCE" ]; then
    echo "🎨 Copiando ícono desde $ICON_SOURCE"
    cp "$ICON_SOURCE" "$ICON_TARGET"
    ICON_PATH="$ICON_TARGET"
else
    echo "⚠️ No se encontró cursor.png junto al script. Ícono no se establecerá."
    ICON_PATH=""
fi

# 5. Crear archivo .desktop
echo "🧩 Creando archivo .desktop en $DESKTOP_FILE"
cat > "$DESKTOP_FILE" <<EOF
[Desktop Entry]
Name=Cursor
Exec=$CURSOR_DIR/cursor --no-sandbox
Icon=$ICON_PATH
Type=Application
Categories=Development;IDE;
Terminal=false
EOF

# 6. Crear alias
SHELL_RC="$HOME/.bashrc"
if [[ "$SHELL" =~ "zsh" ]]; then
    SHELL_RC="$HOME/.zshrc"
fi

if ! grep -q "alias cursor=" "$SHELL_RC"; then
    echo "🔗 Agregando alias a $SHELL_RC"
    echo "alias cursor=\"$CURSOR_DIR/cursor --no-sandbox\"" >> "$SHELL_RC"
else
    echo "✔️ Alias ya existe en $SHELL_RC"
fi

# 7. Recargar entorno
echo "🔄 Recargando configuración de shell..."
source "$SHELL_RC"

echo "✅ Cursor instalado correctamente."
echo "👉 Podés ejecutarlo desde terminal con: cursor"
echo "🎉 También lo tenés disponible desde el menú de aplicaciones."
