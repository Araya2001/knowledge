Instalar llave en host para ingresar sin password:

```
ssh-keygen -t rsa -b 4096 -v
: /home/user/.ssh/id_laptop_rsa
ssh-copy-id -i /home/user/.ssh/id_laptop_rsa user@192.168.0.10
```

