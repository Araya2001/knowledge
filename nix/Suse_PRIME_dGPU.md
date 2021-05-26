Cargar aplicaciones con la discreta en Wayland con nouveau:

Verificar que DRI_PRIME=1 retorne la dGPU (En este caso nvidia):

```
# DRI_PRIME=1 glxinfo | grep "OpenGL renderer"
```

Luego de verificar, correr un programa con el siguiente comando

```
$ DRI_PRIME=1 google-chrome
```


