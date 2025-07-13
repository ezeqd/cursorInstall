# 🧠 Script de Instalación Automática de Cursor para Ubuntu Linux

Este script instala **Cursor** en sistemas **Ubuntu Linux**, utilizando la versión más reciente disponible en línea.

Cursor es un editor de código basado en VS Code, optimizado con inteligencia artificial, ideal para desarrolladores que desean una experiencia de desarrollo potenciada.

---

## 🚀 Funcionamiento

Este script automatiza los siguientes pasos:

- ✅ Descarga la última versión de Cursor `.AppImage` desde el repositorio oficial
- ✅ Le da permisos de ejecución
- ✅ Lo instala en el directorio `~/.local/bin/`
- ✅ Crea un alias en tu terminal para poder lanzarlo simplemente escribiendo `cursor`
- ✅ Crea un acceso directo de escritorio (`.desktop`) para integrarlo con el menú de aplicaciones
- ✅ Asocia un ícono personalizado

---

## 💡 Requisitos previos

- Ubuntu 20.04, 22.04, 24.04 o compatible
- Conexión a internet
- Tener `curl`, `grep`, `bash`, `chmod` disponibles

---

## 📦 Cómo usar este script

1. Cloná este repositorio o descargá este archivo

```bash
git clone https://github.com/ezeqd/cursorInstall.git 
cd cursorInstall
```

2. Ejecutá el script de instalación

```bash
chmod +x cursor.sh
./cursor.sh
```

---

## 📥 Fuente de las versiones

Este script **no utiliza GitHub Releases**, ya que el proyecto Cursor **no publica las versiones de Linux allí**.

En su lugar, utiliza el archivo JSON [`version-history.json`](https://github.com/oslook/cursor-ai-downloads/blob/main/version-history.json) del repositorio:

🔗 https://github.com/oslook/cursor-ai-downloads

Ese archivo mantiene un historial actualizado de versiones y enlaces de descarga.  
El script toma el **primer enlace `.AppImage`** de ese archivo para instalar la versión más reciente.

---

## 🚀 Cómo ejecutar Cursor

### 📌 Desde la terminal:

```bash
cursor
```

---

## 🧹 Cómo desinstalar Cursor

Para eliminar Cursor y todo lo que instaló este script, podés ejecutar los siguientes comandos:

```bash
rm ~/.local/bin/cursor
rm ~/.local/share/applications/cursor.desktop
rm ~/.local/share/icons/cursor.png
sed -i '/alias cursor=/d' ~/.bashrc && source ~/.bashrc
```

⚠️ Si usás Zsh, reemplazá `.bashrc` por `.zshrc`.
