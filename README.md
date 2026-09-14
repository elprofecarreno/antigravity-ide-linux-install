# Visual Code Linux Install

[English version](./README.en.md)

Este proyecto automatiza una instalacion local de Visual Studio Code en Linux sin usar el gestor de paquetes del sistema. El script descarga una version empaquetada de VS Code, la instala en `~/code`, agrega el binario al `PATH` y crea un lanzador de escritorio para poder abrirlo desde el menu de aplicaciones.

## Para que sirve

Sirve para:

- Instalar VS Code en el directorio personal del usuario.
- Evitar una instalacion global del sistema.
- Crear una entrada en el menu de aplicaciones.
- Permitir abrir VS Code desde terminal con el comando `code`.

## Que hace el script

Al ejecutar [install.sh](./install.sh), el proceso realiza estas acciones:

1. Verifica que `curl` este instalado.
2. Descarga una compilacion estable de VS Code para Linux x64 en formato `.tar.gz`.
3. Elimina instalaciones previas en `~/code` y copia ahi la nueva version.
4. Agrega `~/code/bin` al archivo `~/.bashrc` si todavia no existe.
5. Genera un archivo `.desktop` a partir de [code.desktop.template](./code.desktop.template).
6. Mueve ese lanzador a `~/.local/share/applications/`.
7. Actualiza la base de datos de accesos directos del escritorio.

## Requisitos

- Linux
- `curl`
- `tar`
- `grep`
- `sed`
- `update-desktop-database`

Si `update-desktop-database` no existe en tu sistema, normalmente viene en el paquete `desktop-file-utils`.

## Como usarlo

Desde la raiz del proyecto ejecuta:

```bash
chmod +x install.sh
./install.sh
```

## Despues de instalar

Puedes usar VS Code de dos formas:

- Desde el menu de aplicaciones, buscando `Visual Code`.
- Desde una terminal con el comando `code`.

Si el comando `code` no funciona inmediatamente, abre una terminal nueva o recarga tu configuracion de shell:

```bash
source ~/.bashrc
```

## Desinstalar

Para revertir la instalacion ejecuta:

```bash
chmod +x uninstall.sh
./uninstall.sh
```

El script elimina `~/code`, borra el lanzador `~/.local/share/applications/code.desktop` y limpia la linea agregada al `PATH` dentro de `~/.bashrc`.

## Capturas

Menu de aplicaciones:

![Visual Code en el menu de aplicaciones](./img/code-1.png)

Pantalla inicial de VS Code:

![Pantalla inicial de Visual Studio Code](./img/code-2.png)

## Notas importantes

- El script reemplaza por completo el contenido de `~/code` en cada ejecucion.
- La URL de descarga esta fija dentro del script, asi que instala esa version especifica de VS Code.
- Esta pensado para arquitecturas Linux x64.
- Incluye un script de desinstalacion para revertir los cambios principales.