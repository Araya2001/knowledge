# FreeBSD Cheat-sheet

User/passwd

freebsd:freebsd
root:root

*** RECORDAR CAMBIAR Usuario y 

```
$ su root

# pkg update

# pkg install nano

# pkg install bash

# pkg install neofetch

# pkg install sudo

# cat /etc/group

# cat /etc/shells

# adduser Mi_usuario -s /usr/local/bin/bash -G wheel

# chmod 640 /usr/local/etc/sudoers

# nano /usr/local/etc/sudoers

-- En sudoers, agregar o cambiar los siguientes valores--

##

## User privilege specification

##
root ALL=(ALL) ALL
Mi_usuario  ALL=(ALL) NOPASSWD: ALL

## Uncomment to allow members of group wheel to execute any command

%wheel ALL=(ALL) ALL

...............................
```

watch(Linux)=cmdwatch(FreeBSD)
free(Linux)=freecolor(FreeBSD)

```
# pkg install cmdwatch
# pkg install freecolor
```

Ver memoria con cmdwatch:

```
$ cmdwatch "freecolor -tmo"
```

Agregar usuario existente a un grupo (wheel):

```
# pw usermod your_user -G wheel
```

Cambiar hostname:

```
# hostname your.hostname.com 

# nano /etc/rc.conf
-- /etc/rc.conf --
hostname="your.hostname.com"
-- rc.conf -- 

# nano /etc/hosts
-- /etc/hosts --
::1                     localhost your.hostname.com
127.0.0.1               localhost your.hostname.com
-- /etc/hosts --

# reboot
```

