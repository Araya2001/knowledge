Instalar docker y docker compose

```
# zypper in docker python3-docker-compose

# systemctl enable docker
```

Meter usuario a grupo

```
# usermod -G docker -a Mi_usuario
```

Crear docker-compose.yml

```
# mkdir /opt/oracle11g

# cd /opt/oracle11g

# vi docker-compose.yml

version: '3'

services: 
  oracle-db:
    image: oracleinanutshell/oracle-xe-11g:latest
    ports:

   - 1521:1521
     5500:5500

en el mismo directorio hacer:

# docker-compose up
```

Abrir con bash:

```
# docker -ps a
# docker exec -it <id> /bin/bash
```

Buena Práctica: Crear usuarios sin privilegios, luego se le va otorgando permisos de poco a poco y cada vez que escala con un mayor poder, debe justificar su respuesta.

Crear usuario sql

```
SQL> create user alfa
  2  identified by alfa
  3  default tablespace users
  4  quota unlimited on users;
```

Mostrar usuario

```
SQL> show user
USER is "SYSTEM"
```

Mostrar usuarios con un query

```
SQL> select username from dba_users;

USERNAME
------------------------------

SYS
SYSTEM
ANONYMOUS
ALFA
APEX_PUBLIC_USER
APEX_040000
OUTLN
XS$NULL
FLOWS_FILES
MDSYS
CTXSYS

USERNAME
------------------------------

XDB
HR

13 rows selected.
```

Otorgar permisos a un usuario:

```
SQL> grant connect, resource to alfa;

Grant succeeded.
```

Remover permisos a un usuario:

```
SQL> revoke connect, resource to alfa;

Revoke succeeded.
```

Forma de entrar a usuario

```
SQL> conn user/pass
Connected.
```

Cargar script desde terminal

```
SQL> start creadb
```

Query de tablas del sistema

```
SQL> select * from cat;
```

Guardar cambios

```
SQL> commit;
```

