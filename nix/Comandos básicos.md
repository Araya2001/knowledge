# Comandos básicos:

<p style="color:#606060";>Hecho por Alejandro Araya Jiménez</p>

<p style="color:#606060";>Consultar manpages en caso de que no quede claro o no este correcto un comando. Múltiples comandos solo funcionan en distros</p>

Mostrar el camino o directorio en donde uno se encuentra. 

```
$ pwd
```

Muestra el contenido de un directorio especificado

```
$ ls /path/to/dir 
```

Cambiar de directorio

```
$ cd /path/to/dir
$ cd ..
$ cd
```

Permisos de super usuario

```
$ sudo
```

Crear un archivo de texto

```
$ touch
```

Leer el output de un texto

```
$ cat /path/to/file
```

Crear un directorio

```
$ mkdir /path/to/dir
```

Mover un archivo o dato

```
$ mv /path/to/file /other/path/to/file
```

Remover un archivo o un directorio

```
$ rm /path/to/file
$ rm -r /path/to/dir
```

Manual de comando

```
$ man command
```

Editor de texto o archivo compuesto por texto 

```
$ nano /path/to/file
```

Crear un link a un archivo o directorio

```
$ ln /path/to/target /path/to/dir
```

Administrador de paquetes o archivos por medio de terminal. (Distros derivados de Debian)

```
$ sudo apt install
$ sudo apt update && sudo apt upgrade -y
$ sudo apt dist-upgrade
```

Output de las primeras 10 líneas de un archivo

```
$ head /path/to/file
```

Output de las últimas 10 líneas de un archivo

```
$ tail /path/to/file
$ tail -f /var/log/apache2/error.log
```

Muestra el estado de los dispositivos de almacenamiento

```
$ lshw -class disk -class storage
```

Compilar en java desde terminal.

```
$ javac /path/to/file
```

Abrir archivos .jar.

```
$ java -jar /path/to/file
```

Abrir sin interfaz gráfica en java.

```
$ java ... Nogui
```

Cantidad de bytes inicial de RAM y Cantidad máxima

```
$ java -Xms:1024 -Xmx:4096
```

Muestra el archivo que se va a compilar.

```
$ javap 
```

Va a crear un programa ejecutable.

```
$ chmod a+x /path/to/file
```

Información de NICs

```
$ ifconfig 
```

Desempacar archivo en formato .tar.gz

```
$ tar -zxvf
```

Desempacar archivo en formato .tar

```
$ tar -xvf
```

Es para actualizar software alternativo de un directorio alterno al bin.

```
$ update-alternatives --install /usr/bin/programa programa  / <#> 
```

Ajustar la configuración de un programa alterno.

```
$ update-alternatives --config
```

Mantiene vivo una instancia o programa de fondo.

```
$ screen
```

Le asigna un título al programa.

```
$ screen -S
```

Devuelve a la aplicación abierta.

```
$ screen -r
```

Direcciones MAC en una red local.

```
$ arp -a 
```

Archivo de usuarios sudo.

```
$ sudo nano /etc/sudoers
```

Va a cambiar el Shell del usuario.

```
$ chsh -s /usr/bin/zsh user
```

Da la información de cual Shell se encuentra en uso.

```
$ echo $SHELL
```

Recursos que usa la computadora.

```
$ htop 
```

Dispositivos conectados.

```
$ dmesg 
```

Empieza el servidor virtual para escritorio remoto.

```
$ vncserver
```

Muestra los dispositivos de almacenamiento.

```
$ lsblk | grep -v loop
```

Montar un dispositivo.

```
$ sudo mount /dev/xxx /media/usb 
```

Desmontar un dispositivo.

```
$ sudo umount /media/usb
```

Va a poder crear una imagen.

```
$ hdiutil makehybrid -iso -joliet -o image.iso /path/to/source
```

Información del puerto serial.

```
$ lsof | grep usbserial
```

Sonido de la MacBook.

```
$ sudo nvram StartupMute=%00
```

Da la IP de un servidor con un dominio.

```
$ nslookup 
```

Cambia el Hostname de la computadora.

```
$ hostnamectl set-hostname new_host_name
```

Descomprimir con 7Zip.

```
$ 7z <command> <path>
```

Muestra toda línea escrita con las iniciales.

```
$ grep -iInHor aaj /path/* 
```

Reinicia el servicio de apache para aplicar cambios.

```
$ apachectl restart 
```

Aquí se aplica los cambios para el sitio en la página.

```
$ nano wp-config.php 
```

Cambia el URL.

```
$ wp-options site url 
```

Da la versión instalada de un programa.

```
$ comando --version 
```

Mueve todo el contenido de una carpeta al lugar en el que se encuentra (.).

```
$ mv directorio/* .
```

Estima el tamaño del archivo.

```
$ du /path
```

Cambiar de usuario a root.

```
$ sudo -i
```

El export PATH=//:$PATH sirve para añadir una versión o un paquete al PATH.

```
$ export PATH=/Library/Java/JavaVirtualMachines/adoptopenjdk-11.jdk/Contents/Home/bin:$PATH: 
```

Observa archivos y el espacio que consumen.

```
$ watch "du -ahc /path/to/dir"
```

Muestra la IP pública.

```
$ dig +short myip.opendns.com @resolver1.opendns.com 
```

Mostrar Dispositivo de wlan

```
# lspci -vvnn | grep Network 
```

Agregar usuario a grupo wheel (O sudo en algunas distribuciones)

```
# useradd -G wheel -m user
# passwd user
```

Herramientas Útiles:

```
ncdu
wavemon
```

Ver espacio disponible

```
# df -h | grep -v loop | grep -v tmpfs
```

Ver consumo de memoria con free y watch, para evitar un consumo elevado de recursos como con htop

```
$ watch "free -h"
```

Ver que daemon de inicialización se encuentra corriendo actualmente

```
$ ps -e | head -n 2
```

Ver que proceso está usando un puerto en específico:

```
`$ lsof -i :8080
```