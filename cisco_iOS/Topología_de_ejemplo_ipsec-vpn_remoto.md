**Ejemplo topología: VPN REMOTO**

ISP:

```
interface g0/0
ip add 200.101.101.9 255.255.255.252
no shut
exit

router ospf 1
network 200.101.101.8 0.0.0.3 area 0
exit
```

RTC

```
en
conf t
hostname RTC

interface g0/0
ip add 200.101.101.10 255.255.255.252
no shut
exit

interface g0/1
ip add 12.24.12.1 255.255.255.252
no shut
exit

router ospf 1
network 200.101.101.8 0.0.0.3 area 0
network 12.24.12.0 0.0.0.3 area 0
defaultinformation originate
passiveinterface g0/0
exit

ip route 0.0.0.0 0.0.0.0 200.101.101.9
```

MLSB

```
en
conf t

interface g0/2
ip add 12.24.12.1 255.255.255.252
no shut
exit

router ospf 1
network 12.24.12.0 0.0.0.3 area 0
exit
```

IPSec-VPN Remoto

```
aaa newmodel
aaa authentication login VPN_USER local
aaa authorization network VPN_GROUP local

crypto isakmp policy 1
encryption aes 256
hash sha
authentication preshare
group 5
exit

ip local pool VPN_POOL 13.24.13.10 13.24.13.100

username VPN secret vpn123

crypto isakmp client configuration group VPNCLIENT
key ciscovpn
pool VPN_POOL
ex

crypto ipsec transformset VPN_REMOTO espaes 256 espmd5hmac

crypto dynamicmap DYNAMAP 1
set transformset VPN_REMOTO
reverseroute
ex

crypto map CLIENT_MAP client authentication list VPN_USER
crypto map CLIENT_MAP isakmp authorization list VPN_GROUP
crypto map CLIENT_MAP client configuration address respond
crypto map CLIENT_MAP 1 ipsecisakmp dynamic DYNAMAP

int g0/0
crypto map CLIENT_MAP
ex
```

