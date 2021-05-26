**Comandos docker:**

Ver contenedores:

```
# docker ps -a
```

arrancar contenedor:

```
# docker exec -it <id> /bin/bash
```

Generar backup de un contenedor

Crear snapshot

```
$ sudo docker commit -p <id> <nombre_backup>

$ sudo docker image save -o ~/<nombre_backup>.tar <nombre_backup>

# docker image load -i ~/<nombre_backup>.tar
```

Eliminar contenedor:

```
# docker rm <id>
```

