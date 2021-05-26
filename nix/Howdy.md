Instalación de Howdy en OpenSUSE, Intel Laptop QC7

Agregar el siguiente repositorio

```
# zypper addrepo https://ftp.lysator.liu.se/pub/opensuse/repositories/security/openSUSE_Tumbleweed/ security-x86_64
```

Instalar los siguientes paquetes

```
# zypper install pam-python
# zypper in python3-opencv
# zypper install python3-dlib
# python3 -m pip install numpy
```

Agregar el siguiente repositorio e instalar el siguiente paquete

```
# zypper addrepo --refresh http://download.opensuse.org/repositories/home:/dmafanasyev/openSUSE_Tumbleweed/ howdy
# zypper in howdy
```

Modificar los siguientes valores en el archivo /usr/lib64/security/howdy/config.ini

```
# vi /usr/lib64/security/howdy/config.ini

-- Archivo -- 

device_path = /dev/video2
max_height = 360
```

En los siguientes archivos de autenticación

```
# vi /usr/etc/pam.d/sudo
# vi /etc/pam.d/gdm
# vi /etc/pam.d/gdm-password
# vi /etc/pam.d/gnomesu-pam
# vi /etc/pam.d/gdm-launch-environment
# vi /etc/pam.d/common-auth
```

Agregar la siguiente linea

```
auth     sufficient     pam_python.so /usr/lib64/security/howdy/pam.py
```

Crear modelos

```
$ howdy add
```

Copiar los modelos de Mi_usuario a root, en caso de que sea el propietario de la computadora

```
# cd /usr/lib64/security/howdy/models && cp Mi_usuario.dat root.dat
```

