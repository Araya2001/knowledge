**/usr/sbin export**

Recordar que hay sistemas operativos que requieren de un export para acceder a los comandos sin necesidad de tener que ingresar el path completo.

Para evitar dicha situación ingresar el siguiente comando:

```
-- bash --
$ echo export PATH="$PATH:/usr/sbin" >> .bashrc

-- zsh --
$ echo export PATH="$PATH:/usr/sbin" >> .zshrc
```

