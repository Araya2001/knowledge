# Instalación de Arch GNU/Linux :

Cambiar teclado a español LA:

```
# loadkeys la-latin1
```

Verificar estado de red (Si es DHCP por cable, solo hacer ping):

```
# ping 8.8.8.8
```

Actualizar el reloj del sistema:

```
# timedatectl set-ntp true
# timedatectl status
```

Particionar los discos:
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

Una vez dentro, cambiar zona horaria:

```
# timedatectl list-timezones
# timedatectl set-timezone America/Costa_Rica
```

Setear locale:

```
# nano /etc/locale.gen
```

Quitar comentario del (los) locale(s) que se desee(n)

Generar locale:

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

En /etc/hosts:

```
127.0.0.1       localhost
::1             localhost
127.0.1.1      [hostname].localhost [hostname]
```

DHCP en interfaz:

```
# nano /etc/systemd/network/20-wired.network
```

En /etc/systemd/network/20-wired.network:

```bash
[Match]
Name=enp60s0

[Network]
DHCP=yes
```

Verificar que el systemd-networkd.service este habilitado:

```
# systemctl status systemd-networkd.service
```

Instalar binutils y fakeroot para usar makepkg (Ver documentación de AUR):

```
# pacman -S binutils fakeroot
```

**No Secure-boot:** 

Instalar grub, os-prober y efibootmgr:

```
# pacman -S grub efibootmgr os-prober
```

Instalar grub en partición para efi:

```
# mkdir /boot/efi; mount /dev/sdX1 /boot/efi
# grub-install --target=x86_64-efi --bootloader-id=Arch --efi-directory=/boot/efi
# grub-mkconfig -o /boot/grub/grub.cfg
```

**Secure-boot:**

Instalar los siguientes paquetes:

```
# pacman -S grub efibootmgr os-prober sbsigntools efitools
```

Crear directorio en el cual se monta la partición de EFI e instalar grub en dicha partición con las siguientes opciones:

```
# mkdir /boot/efi; mount /dev/sdX1 /boot/efi
# grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=Arch --modules="tpm" --disable-shim-lock
```

Instalar el siguiente paquete con AUR: 

```
# git clone https://aur.archlinux.org/shim-signed.git
# cd shim-signed
# makepkg -si
```

Copiar los siguientes archivos desde /usr/share hasta la partición del EFI:

```
# cp /usr/share/shim-signed/shimx64.efi /boot/efi/EFI/Arch/shimx64.efi
# cp /usr/share/shim-signed/mmx64.efi /boot/efi/EFI/Arch
```

Crear entry para Secure-boot: 

```
# efibootmgr --verbose --disk /dev/sdX1 --create --label "Arch Secure-Boot" --loader /EFI/Arch/shimx64.efi
```

Una vez esto este listo, reiniciar sistema y hacer el enroll de la llave MOK:

```
**MOK Manager -> Enroll hash from disk -> EFI/Arch/grubx64.efi**
```

Para efectos de prueba, una vez realizada la instalación, se puede crear un entry para el MOK manager: 

```
# efibootmgr --verbose --disk /dev/sdX1 --create --label "MOK manager" --loader /EFI/Arch/mmx64.efi
```

**Otros comandos útiles:**

Verificar en que arranca con bootctl:

```
# bootctl status
```

Ver entries con efibootmgr

```
# efibootmgr -v
```

Borrar un entry con efibootmgr (Ver entries primero para verificar que sea el bootnum correcto):

```
# efibootmgr -b XXXX -B
```

**Archivo personal de /etc/default/grub**

```bash
# nano /etc/default/grub
...
GRUB_DEFAULT=0
GRUB_TIMEOUT=1
GRUB_DISTRIBUTOR="Arch"
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 i8042.noaux=1 iommu=pt intel_iommu=on pcie_acs_override=downstream,multifunction" # i8042.noaux=1 -> para que el teclado funcione post-sleep. A diferencia de loglevel=3 y el mencionado anteriormente, el resto es para lograr PCIe passthrough
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

Actualizar grub:

```
# grub-mkconfig -o /boot/grub/grub.cfg
```

Actualizar initram:

```
# sudo mkinitcpio -P
```

