# Instalación de Arch-Linux en XPG xenia:

Cambiar teclado a español LA

```
# loadkeys la-latin1
```

Verificar estado de red (Si es DHCP por cable, solo hacer ping)

```
# ping 8.8.8.8
```

Actualizar el reloj del sistema

```
# timedatectl set-ntp true
# timedatectl status
```

Particionar los discos
*/dev/sdX no es un parámetro fijo, este cambia según este nombrado el dispositivo de almacenamiento a usar

```
# lsblk
# cfdisk /dev/sdX
```

Usar gpt
Crear partición de tipo "EFI System", "Linux filesystem" y swap en caso de ser necesario.

Una vez creado, instalar dosfstools
Crear FS para "EFI System" y "Linux filesystem":

```
# mkfs.fat -F32 /dev/sdX1
# mkfs.ext4 /dev/sdX2
```

**Adicional:**

```
# mkswap /dev/sdX3
```

Montar dispositivos de almacenamiento:

```
# mount /dev/sdX2 /mnt
```

**Adicional:**

```
# swapon /dev/sdX3
```

Sincronizar repo:

```
# pacman -Syy
```

Instalar reflector:

```
# pacman -S reflector
```

Crear backup de mirrorlist:

```
# cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
```

Actualizar el mirror list a US:

```
# reflector -c "US" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist
```

Instalar linux:

```
# pacstrat /mnt base linux linux-firmware
```

Generar fstab

```
# genfstab -U /mnt >> /mnt/etc/fstab
```

Cambiar root:

```
# arch-chroot /mnt
```

Una vez dentro, cambiar zona horaria

```
# timedatectl list-timezones
# timedatectl set-timezone America/Costa_Rica
```

Setear locale:

```
# nano /etc/locale.gen
```

Quitar comentario del (los) locale(s) que se desee(n)

generar locale

```
# locale-gen
# echo LANG=[locale_name] > /etc/locale.conf
```

Setear hostname:

```
# echo [hostname] > /etc/hostname
```

Crear y modificar el siguiente archivo:

```
# nano /etc/hosts
```

En /etc/hosts

```
127.0.0.1       localhost
::1             localhost
127.0.1.1      [hostname].localhost [hostname]
```

DHCP en interfaz:

```
# nano /etc/systemd/network/20-wired.network
```

en /etc/systemd/network/20-wired.network

```bash
[Match]
Name=enp60s0

[Network]
DHCP=yes
```

verificar que el systemd-networkd.service este habilitado

```
# systemctl status systemd-networkd.service
```

Instalar grub, os-prober y efibootmgr

```
# pacman -S grub efibootmgr os-prober
```

Instalar grub en partición para efi:

```
# mkdir /boot/efi; mount /dev/sdX1 /boot/efi
# grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
# grub-mkconfig -o /boot/grub/grub.cfg
```

Instalar binutils y fakeroot para usar makepkg (Ver documentación de AUR)

```
# pacman -S binutils fakeroot
```

Una vez esto este listo, reiniciar sistema y verificar la instalación.
En caso de que no aparezcan caracteres, buscar la respectiva fuente y asegurar que en locale.gen se encuentre los charsets deseados.
***Nota Importante: Seguir guía siendo un usuario experimentado. En caso de tener dudas contacte a algún conocido que tenga alto conocimiento para evitar complicaciones.***

