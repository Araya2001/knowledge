Ingresar lo siguiente en la terminal

```
# mkdir /mnt/capsule
# sudo mount -t cifs //192.168.0.1/Capsule /mnt/capsule -o password='Mi_Contraseña',sec=ntlm,uid=1000,vers=1.0
```

Una vez ingresado, verificar que los datos se encuentren ahí.

Para desmontar:

```
# umount /mnt/capsule
```

Crear alias en .bashrc o .zshrc :

Verificar shell:

```
$ echo $SHELL
```

Una vez verificado, modificar el .bashrc, .zshrc o el profile que su shell use

```
$ echo "alias mnt_capsule=sudo mount -t cifs //192.168.0.1/Capsule /mnt/capsule -o password='Mi_Contraseña',sec=ntlm,uid=1000,vers=1.0" >> ~/.zshrc
$ source ~/.zshrc

-- O en el caso de bash --

$ echo "alias mnt_capsule=sudo mount -t cifs //192.168.0.1/Capsule /mnt/capsule -o password='Mi_Contraseña',sec=ntlm,uid=1000,vers=1.0" >> ~/.bashrc
$ source ~/.bashrc
```

