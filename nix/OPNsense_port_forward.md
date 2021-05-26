Verificar que la configuración de port forward (NAT:PAT), tenga los siguientes parámetros:

```
Interface: WAN
TCP/IP: IPv4
Protocol: TCP/UDP
Destination: WAN address
Dest port: from ssh to ssh
redirect target IP: 192.168.100.2/32 --> IP "Deseada"
redirect target port: ssh --> Puerto "Deseado"
pool options: default
nat reflection: disable
filter rule association: none
```

Recordar que en el firewall, permitir lo deseado en las interfaces deseadas, Tener cuidado con las ACL.

