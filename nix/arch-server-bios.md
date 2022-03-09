# Arch Server - VM (BIOS - Intel host)
#### Creado por AAJ

- - -
Cargar layout del teclado en español:
```bash
root# loadkeys la-latin1
```
Verificar conectividad:
``` bash
root# ping 8.8.8.8
root# ip -br a
```
Actualizar reloj del sistema:
``` bash
root#  timedatectl set-ntp true
root#  timedatectl status
```
Validar almacenamiento:
``` bash  
root# fdisk -l
```
Crear particiones (GPT)
``` bash
root# cfdisk /dev/sda
```
Las particiones, idealmente serían las siguientes:
* `sda1` -> /boot
* `sda2` -> /
* `sda3` -> swap

_Los tamaños son preferencia de quien proceda con la instalación_

Generar filesystems:
``` bash
root# mkfs.ext4 /dev/sda2
root# mkswap /dev/sda3
```

Montar filesystems:
``` bash
root# mount /dev/sda2 /mnt
root# swapon /dev/sda3
```

Instalar Base:
``` bash
root# pacstrap /mnt/ base base-devel linux-lts linux-firmware intel-ucode openssh
```

```
Generar fstab:

``` bash
root# genfstab -U /mnt >> /mnt/etc/fstab
```
Cambiar root:
``` bash
root# arch-chroot /mnt
``` 
Configurar zona horaria:
``` bash
root# timedatectl list-timezones
root# timedatectl set-timezone America/Costa_Rica
```
> En ciertos casos este valor puede cambiar, dependiendo del lugar en el que se encuentre ubicado el servidor.

Configurar locale:
``` bash
root# nano /etc/locale.gen
> Descomentar locale desaeado
root# locale-gen
root# echo LANG=[locale_name] > /etc/locale.conf
```

Configurar Hostname:
``` bash
root# echo [hostname] > /etc/hostname
root# nano /etc/hosts
> 127.0.0.1       localhost
> ::1             localhost
> 127.0.1.1      [hostname].localhost [hostname]
```

Cambiar password de root:
``` bash
root# passwd
```

Instalar Grub:

``` bash
root# pacman -S grub
root# grub-install /dev/sda
root# grub-mkconfig -o /boot/grub/grub.cfg
```

Configurar red fija con systemd: 
``` bash
root# ip -br a
> obtener el nombre de la interfaz
root# nano /etc/systemd/network/[nombre_interfaz].network
```
En el archivo `[nombre_interfaz].network` escribir lo siguiente:
``` bash
[Match]
Name=[nombre_interfaz]

[Network]
Address=[dirección_ip]/[bit_máscara]
Gateway=[dirección_gateway]
DNS=8.8.8.8
DNS=8.8.4.4
```

Habilitar `systemd-networkd`
``` bash
root# systemctl enable systemd-networkd
``` 

Reiniciar:
``` bash
root# reboot
```
