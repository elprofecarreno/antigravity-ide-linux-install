# Antigravity IDE Linux Install

[English version](./README.en.md)

Este proyecto automatiza una instalación local de Antigravity IDE en Linux sin usar el gestor de paquetes del sistema. El script descarga una versión empaquetada de Antigravity IDE, la instala en `~/antigravity-ide`, agrega el binario al `PATH` y crea un lanzador de escritorio para poder abrirlo desde el menú de aplicaciones.

## Para qué sirve

Sirve para:

- Instalar Antigravity IDE en el directorio personal del usuario.
- Evitar una instalación global del sistema.
- Crear una entrada en el menú de aplicaciones.
- Permitir abrir Antigravity IDE desde la terminal con el comando `antigravity-ide`.

## Qué hace el script

Al ejecutar [install.sh](./install.sh), el proceso realiza estas acciones:

1. Verifica que `curl` esté instalado.
2. Descarga la compilación estable de Antigravity IDE para Linux x64 en formato `.tar.gz`.
3. Elimina instalaciones e instalaciones previas de datos (`~/antigravity-ide`, `~/.antigravity-ide`, `~/.gemini`) y copia la nueva versión en `~/antigravity-ide`.
4. Agrega `~/antigravity-ide/bin` al archivo `~/.bashrc` si todavía no existe.
5. Genera un archivo `.desktop` a partir de [antigravity-ide.desktop.template](./antigravity-ide.desktop.template).
6. Mueve ese lanzador a `~/.local/share/applications/antigravity-ide.desktop`.
7. Concede permisos de ejecución al lanzador y actualiza la base de datos de accesos directos del escritorio (`update-desktop-database`).

## Requisitos

- Linux
- `curl`
- `tar`
- `grep`
- `sed`
- `update-desktop-database`

Si `update-desktop-database` no existe en tu sistema, normalmente viene en el paquete `desktop-file-utils`.

## Cómo usarlo

Desde la raíz del proyecto ejecuta:

```bash
chmod +x install.sh
./install.sh
```

## Después de instalar

Puedes usar Antigravity IDE de dos formas:

- Desde el menú de aplicaciones, buscando `Antigravity IDE`.
- Desde una terminal con el comando `antigravity-ide`.

Si el comando `antigravity-ide` no funciona inmediatamente, abre una terminal nueva o recarga tu configuración de shell:

```bash
source ~/.bashrc
```

## Desinstalar

Para revertir la instalación ejecuta:

```bash
chmod +x uninstall.sh
./uninstall.sh
```

El script elimina `~/antigravity-ide`, `~/.antigravity-ide` y `~/.gemini`, borra el lanzador `~/.local/share/applications/antigravity-ide.desktop` y limpia la línea agregada al `PATH` dentro de `~/.bashrc`.

## Notas importantes

- El script reemplaza por completo el contenido de `~/antigravity-ide`, `~/.antigravity-ide` y `~/.gemini` en cada ejecución.
- La URL de descarga está fija dentro del script, así que instala esa versión específica de Antigravity IDE.
- Está pensado para arquitecturas Linux x64.
- Incluye un script de desinstalación para revertir los cambios principales.
