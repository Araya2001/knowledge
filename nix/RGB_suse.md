Instalar el siguiente paquete con pip3, con permiso de super usuario para que este disponible para todo usuario

```bash
$ sudo pip3 install ite8291r3-ctl
```

Agregar la siguiente regla

```bash
$ nano /etc/udev/rules.d/99-ite8291.rules
SUBSYSTEMS=="usb", ATTRS{idVendor}=="048d", ATTRS{idProduct}=="ce00", MODE:="0666"
```
Aplicar los siguientes comandos

```bash
$ sudo udevadm control --reload
$ sudo udevadm trigger
```

Crear el siguiente servicio en systemd:

```bash
$ sudo vi /etc/systemd/system/rgb.service

[Unit]
Description=AAJ-RGB
After=multi-user.target

[Service]
ExecStart=/etc/rgb/rgb.sh

[Install]
WantedBy=default.target
```

```bash
$ sudo vi /etc/systemd/system/lightbar.service

[Unit]
Description=AAJ-LIGHTBAR-RGB
After=multi-user.target

[Service]
ExecStart=/etc/rgb/lightbar.sh

[Install]
WantedBy=default.target
```


Crear el siguiente directorio y archivo:

```bash
$ sudo mkdir -p /etc/rgb
$ sudo nano /etc/rgb/rgb.sh

#!/bin/bash
ite8291r3-ctl anim --file /etc/rgb/rgb.colors
```

```bash
$ sudo nano /etc/rgb/lightbar.sh

#!/bin/bash
rgb_static0="0"
get_rgb=$(cat /sys/class/leds/lightbar_animation::status/brightness)

if [ $get_rgb = $rgb_static0 ]; then
        echo 4 > /sys/class/leds/lightbar_animation::status/brightness
fi
```


Hacerlo ejecutable:

```bash
$ sudo chmod 775 /etc/rgb/rgb.sh
$ sudo chmod 775 /etc/rgb/lightbar.sh
```

Habilitar servicio para arranque:

```bash
$ systemctl enable rgb.service
```

Crear el siguiente archivo:

```bash
$ sudo nano /etc/rgb.colors

## Line 1 (bottom to top) #################################

brightness 50

# left control
pos 0 0 50,3,203

# fn
pos 0 2 50,3,203

# super key
pos 0 3 0,255,255

# left alt
pos 0 4 50,3,203

# space bar
pos 0 7 0,255,255

# alt gr
pos 0 10 50,3,203

# context key
pos 0 11 50,3,203

# right control
pos 0 12 50,3,203

# left key
pos 0 13 255,0,0

# down key
pos 0 14 255,0,0

# right key
pos 0 15 255,0,0

## Line 2 #################################################

# shift
pos 1 0 50,3,203

# < >
pos 1 2 62,132,223

# z
pos 1 3 255,0,0

# x
pos 1 4 255,0,0

# c
pos 1 5 255,0,0

# v
pos 1 6 255,0,0

# b
pos 1 7 255,0,0

# n
pos 1 8 255,0,0

# m
pos 1 9 255,0,0

# ,
pos 1 10 62,132,223

# .
pos 1 11 62,132,223

# -
pos 1 12 62,132,223

# shift (right)
pos 1 13 50,3,203

# up key
pos 1 14 255,0,0

# end key
pos 1 15 255,41,0

## Line 3 #################################################

# caps lock
pos 2 0 50,3,203

# a
pos 2 2 255,0,0

# s
pos 2 3 255,0,0

# d
pos 2 4 255,0,0

# f
pos 2 5 255,0,0

# g
pos 2 6 255,0,0

# h
pos 2 7 255,0,0

# j
pos 2 8 255,0,0

# k
pos 2 9 255,0,0

# l
pos 2 10 255,0,0

# ñ
pos 2 11 255,0,0

# {
pos 2 12 62,132,223

# }
pos 2 13 62,132,223

# page down
pos 2 15 255,41,0

## Line 4 #################################################

# tab
pos 3 0 50,3,203

# q
pos 3 2 255,0,0

# w
pos 3 3 255,0,0

# e
pos 3 4 255,0,0

# r
pos 3 5 255,0,0

# t
pos 3 6 255,0,0

# y
pos 3 7 255,0,0

# u
pos 3 8 255,0,0

# i
pos 3 9 255,0,0

# o
pos 3 10 255,0,0

# p
pos 3 11 255,0,0

# '
pos 3 12 62,132,223

# +
pos 3 13 62,132,223

# enter
pos 3 14 50,3,203

# page up
pos 3 15 255,41,0

## Line 5 #################################################

# |
pos 4 0 62,132,223

# 1
pos 4 1 255,41,0

# 2
pos 4 2 255,41,0

# 3
pos 4 3 255,41,0

# 4
pos 4 4 255,41,0

# 5
pos 4 5 255,41,0

# 6
pos 4 6 255,41,0

# 7
pos 4 7 255,41,0

# 8
pos 4 8 255,41,0

# 9
pos 4 9 255,41,0

# 0
pos 4 10 255,41,0

# '
pos 4 11 62,132,223

# ¿
pos 4 12 62,132,223

# backspace
pos 4 14 50,3,203

# begin
pos 4 15 255,41,0

## Line 6 #################################################

# esc
pos 5 0 0,255,0

# F1
pos 5 1 255,0,255

# F2
pos 5 2 255,0,255

# F3
pos 5 3 255,0,255

# F4
pos 5 4 255,0,255

# F5
pos 5 5 255,0,255

# F6
pos 5 6 255,0,255

# F7
pos 5 7 255,0,255

# F8
pos 5 8 255,0,255

# F9
pos 5 9 255,0,255

# F10
pos 5 10 255,0,255

# F11
pos 5 11 255,0,255

# F12
pos 5 12 255,0,255

# insert
pos 5 13 0,255,0

# print screen
pos 5 14 0,255,0

# delete
pos 5 15 0,255,0

apply
```
