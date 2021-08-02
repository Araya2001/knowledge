# Configuración Básica XPG Xenia NVIDIA-GPU en Arch GNU/Linux

instalar los siguientes paquetes:

```
$ sudo pacman -S nvidia nvidia-utils nvidia-settings nvidia-prime
```

Instalar optimus-manager:

```
$ git clone https://aur.archlinux.org/optimus-manager.git
$ cd optimus-manager; makepgk -si
```

*Usar makepkg requiere de binutils y fakeroot*

```
$ sudo nano /etc/modprobe.d/90-nvsettings.conf
```

En *90-nvsettings.conf*:

```
blacklist nouveau
```

En caso de usar gnome con gdm:

```
$ sudo nano /etc/gdm/custom.conf
```

En *custom.conf*:

```
[daemon]
# Uncomment the line below to force the login screen to use Xorg
WaylandEnable=false
```

Agregar variables y un script a */etc/profile*:

```
$ sudo nano /etc/profile
```

En *profile*:

```bash
...
/usr/bin/sh /etc/nvsettings/force-composition-pipeline.sh
export CLUTTER_DEFAULT_FPS=144
export __GL_SYNC_TO_VBLANK=1
export __GL_SYNC_DISPLAY_DEVICE=eDP-1-1
export VDPAU_NVIDIA_SYNC_DISPLAY_DEVICE=eDP-1-1
```

Crear directorio nvsettings y agregar un archivo para activar el Force full composition pipeline de nvidia:

```
$ sudo mkdir /etc/nvsettings; sudo nano /etc/nvsettings/force-composition-pipeline.sh
```

En *force-composition-pipeline.sh*

```bash
#!/bin/bash
s="$(nvidia-settings -q CurrentMetaMode -t)"

if [[ "${s}" != "" ]]; then
  s="${s#*" :: "}"
  nvidia-settings -a CurrentMetaMode="${s//\}/, ForceFullCompositionPipeline=On\}}"
fi
```

Para cambiar de discreta a integrada, usar optimus-manager

```
$ optimus-manager --switch integrated
```

De integrada a discreta:

```
$ optimus-manager --switch nvidia
```

Ver más de ***optimus-manager*** en: https://github.com/Askannz/optimus-manager