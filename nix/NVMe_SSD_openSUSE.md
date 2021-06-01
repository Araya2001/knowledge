**Maximizar rendimiento y Durabilidad de SSD NVMe en OpenSUSE**

*La documentación ha sido proveída por opensuse.org*

Verificar el estado de fstrim con systemctl

```
# systemctl status fstrim
```

Crear un filesystem de TMPFS

Verificar los paths que muestra el siguiente man page y asegurar que contengan el tmp.mount

```
$ man systemd.unit
```

Montar /tmp en ese filesystem (El path de tmp.mount puede variar)

```
# ln -s /usr/lib/systemd/system/tmp.mount /etc/systemd/system/
```

```
# nano /etc/systemd/system/tmp.mount
```

```bash
# Cambiar size de 50% a 30%
Options=mode=1777,strictatime,nosuid,nodev,size=30%,nr_inodes=400k
```

Realizar un snapshot antes de proceder y reinicar

```
# snapper create --read-write && reboot
```

Cambiar los parametros y agregar "noatime" en fstab, ejemplo tiene que ser especificamente la unidad que se encuentra en el sistema como volumen, no un subvolume

```bash
/dev/sda1    /  ext4   noatime,defaults  0       1
```

Optimizar el kernel

Ingresar el siguiente comando:

```
# cat /sys/block/nvme0n1/queue/scheduler
```

Si none es seleccionado, y se encuentra seleccionado mq-deadline, se encuentra en buen estado, en caso de que no sea así, seguir el siguiente ejemplo:

```
# nano /etc/udev/rules.d/60-sched.rules
```

```bash
#set noop scheduler for non-rotating disks
ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="0", ATTR{queue/scheduler}="deadline"

# set cfq scheduler for rotating disks
ACTION=="add|change", KERNEL=="sd[a-z]", ATTR{queue/rotational}=="1", ATTR{queue/scheduler}="cfq"
```

* Se deben cambiar, para los dispositivos de almacenamiento no rotantes, el cfq a deadline

Deshabilitar readahead si no hay discos rotantes y el servicio se encuentra disponible.

```
# systemctl disable systemd-readahead-collect.service
```

```
# systemctl disable systemd-readahead-replay.service
```

Deshabilitar swap

```
# nano /etc/sysctl.d/99-sysctl.conf
```

```bash
vm.swappiness=1
vm.vfs_cache_pressure=50
```

Realizar un reboot

```
# reboot
```

__Fuente__: https://en.opensuse.org/SDB:SSD_performance

