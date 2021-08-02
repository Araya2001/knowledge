# Instalación de Arch GNU/Linux :

Cambiar teclado a español LA:

```
root# loadkeys la-latin1
```

Verificar estado de red (Si es DHCP por cable, solo hacer ping):

```
root# ping 8.8.8.8
```

Actualizar el reloj del sistema:

```
root# timedatectl set-ntp true
root# timedatectl status
```

Particionar los discos:
*/dev/sdX no es un parámetro fijo, este cambia según este nombrado el dispositivo de almacenamiento a usar

```
root# lsblk
root# cfdisk /dev/sdX
```

Usar gpt
Crear partición de tipo "EFI System", "Linux filesystem" y swap en caso de ser necesario.

Una vez creado, instalar dosfstools
Crear FS para "EFI System" y "Linux filesystem":

```
root# mkfs.fat -F32 /dev/sdX1
root# mkfs.ext4 /dev/sdX2
```

**Adicional:**

```
root# mkswap /dev/sdX3
```

Montar dispositivos de almacenamiento:

```
root# mount /dev/sdX2 /mnt
```

**Adicional:**

```
root# swapon /dev/sdX3
```

Sincronizar repo:

```
root# pacman -Syy
```

Instalar reflector:

```
root# pacman -S reflector
```

Crear backup de mirrorlist:

```
root# cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
```

Actualizar el mirror list a US:

```
root# reflector -c "US" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist
```

Instalar linux:

```
root# pacstrat /mnt base linux linux-firmware intel-ucode
```

En caso de ser CPU AMD:

```
root# pacstrat /mnt base linux linux-firmware amd-ucode
```

Generar fstab

```
root# genfstab -U /mnt >> /mnt/etc/fstab
```

Cambiar root:

```
root# arch-chroot /mnt
```

Una vez dentro, cambiar zona horaria:

```
root# timedatectl list-timezones
root# timedatectl set-timezone America/Costa_Rica
```

Setear locale:

```
root# nano /etc/locale.gen
```

Quitar comentario del (los) locale(s) que se desee(n)

Generar locale:

```
root# locale-gen
root# echo LANG=[locale_name] > /etc/locale.conf
```

Setear hostname:

```
root# echo [hostname] > /etc/hostname
```

Crear y modificar el siguiente archivo:

```
root# nano /etc/hosts
```

En */etc/hosts*:

```
127.0.0.1       localhost
::1             localhost
127.0.1.1      [hostname].localhost [hostname]
```

DHCP en interfaz:

```
root# nano /etc/systemd/network/20-wired.network
```

En */etc/systemd/network/20-wired.network*:

```bash
[Match]
Name=enp60s0

[Network]
DHCP=yes
```

Verificar que el systemd-networkd.service este habilitado:

```
root# systemctl status systemd-networkd.service
```

Instalar binutils y fakeroot para usar makepkg (Ver documentación de AUR):

```
root# pacman -S binutils fakeroot
```

**No Secure-boot Grub:** 

Instalar grub, os-prober y efibootmgr:

```
root# pacman -S grub efibootmgr os-prober
```

Instalar grub en partición para efi:

```
root# mkdir /boot/efi; mount /dev/sdX1 /boot/efi
root# grub-install --target=x86_64-efi --bootloader-id=Arch --efi-directory=/boot/efi
root# grub-mkconfig -o /boot/grub/grub.cfg
```

**Systemd-boot:**

Crear copia de boot y montar partición de EFI en */boot*

```
root# mkdir /boot-backup; cp -r /boot/* /boot-backup
root# /etc/fstab
root# nano /etc/fstab
```

En *fstab*, agregar

Agregar el UUID de la partición donde se encuentra el EFI, revisar con *blkid*

```bash
UUID=XXXX                                /boot           vfat            rw,discard,relatime,noatime,errors=remount-ro   0 1
```

Montar partición:

```
root# mount /dev/sdX1 /boot
```

Instalar systemd-boot:

```
root# sudo bootctl --esp-path=/boot/efi
```

Copiar el antiguo /boot (/boot-backup) a la partición montada:

```
root# cp -r /boot-backup/* /boot
```

Actualizar initramfs:

```
root# mkinitpcio -P
```

Modificar entries y configuración de loader:

*Revisar previamente los UUIDs de cada partición con **blkid***

```
root# nano /boot/loader/loader.conf
```

En *loader.conf*

```bash
default  entries/arch.conf
timeout  1
console-mode max
editor   yes
```

Crear siguiente archivo:

```
root# nano /boot/loader/entries/arch.conf
```

En *arch.conf*

```bash
title   Arch Linux
linux   /vmlinuz-linux
initrd  /intel-ucode.img
initrd  /initramfs-linux.img
options root=PARTUUID="XXXX" rootfstype="ext4" rw add_efi_memmap loglevel=3 vt.color=0x02
# Nota: rootfstype no ha de ser obligatorio, si se usa otro filesystem, especificar el debido nombre en rootfstype
# vt.color es un valor en Hexadecimal, el splash en "verbose" se vuelve color verde. ver más en https://www.kernel.org/doc/html/v4.15/admin-guide/kernel-parameters.html
# En caso de ser amd, descargar amd-ucode
# El microcódigo debe ser cargado primero que el kernel en el caso de máquinas AMD.
```

Crear el archivo de fallback

```
root# nano /boot/loader/entries/arch-fallback.conf
```

En *arch-fallback.conf*

```bash
title   Arch Linux (fallback initramfs)
linux   /vmlinuz-linux
initrd  /intel-ucode.img
initrd  /initramfs-linux-fallback.img
options root=PARTUUID="XXXX" rootfstype="ext4" rw add_efi_memmap
# Nota: rootfstype no ha de ser obligatorio, si se usa otro filesystem, especificar el debido nombre en rootfstype
# En caso de ser amd, descargar amd-ucode
# El microcódigo debe ser cargado primero que el kernel en el caso de máquinas AMD.
```

Crear hook en pacman.d para actualizar systemd-boot:

```
root# nano /etc/pacman.d/hooks/100-systemd-boot-update.hook
```

En *100-systemd-boot-update.hook*

```bash
[Trigger]
Type = Package
Operation = Upgrade
Target = systemd

[Action]
Description = Updating systemd-boot
When = PostTransaction
Exec = /usr/bin/bootctl update
```

Para actualizar systemd-boot de forma manual:

```
root# bootctl update
```

**Otros comandos útiles:**

Verificar en que arranca con bootctl:

```
root# bootctl status
```

Ver entries con efibootmgr

```
root# efibootmgr -v
```

Borrar un entry con efibootmgr (Ver entries primero para verificar que sea el bootnum correcto):

```
root# efibootmgr -b XXXX -B
```

**Archivo personal de /etc/default/grub**

```bash
root# nano /etc/default/grub
...
GRUB_DEFAULT=0
GRUB_TIMEOUT=1
GRUB_DISTRIBUTOR="Arch"
# i8042.noaux=1 -> para que el teclado funcione post-sleep. 
# A diferencia de loglevel=3 y el mencionado anteriormente, el resto es para lograr PCIe passthrough
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 i8042.noaux=1 iommu=pt intel_iommu=on pcie_acs_override=downstream,multifunction" 
GRUB_CMDLINE_LINUX=""
GRUB_PRELOAD_MODULES="part_gpt part_msdos"
GRUB_TIMEOUT_STYLE=menu
GRUB_TERMINAL_INPUT=console
GRUB_GFXMODE="1920x1080x32"
GRUB_GFXPAYLOAD_LINUX=keep
GRUB_DISABLE_RECOVERY=true
GRUB_DISABLE_OS_PROBER=false
...
```

**Archivo personal de Arch.conf**

```bash
title   Arch Linux
linux   /vmlinuz-linux
initrd  /intel-ucode.img
initrd  /initramfs-linux.img
options root=PARTUUID="6cc45006-6311-ef4a-9f62-d263c6861a40" rootfstype="ext4" rw add_efi_memmap loglevel=3 i8042.noaux=1 iommu=pt intel_iommu=on pcie_acs_override=downstream,multifunction vt.color=0x02
```

Actualizar grub:

```
root# grub-mkconfig -o /boot/grub/grub.cfg
```

Actualizar initram:

```
root# sudo mkinitcpio -P
```

