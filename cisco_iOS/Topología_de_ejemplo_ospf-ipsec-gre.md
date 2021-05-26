**Topología de ejemplo ospf-ipsec-gre**

RT-4:
ISP:

```
en
conf t
hostname ISP

interface GigabitEthernet 0/0/0
ip add 200.100.100.1 255.255.255.252
no shutdown
exit

interface GigabitEthernet 0/1/0
ip add 200.101.101.1 255.255.255.252
no shutdown
exit

interface GigabitEthernet 0/2/0
ip add 200.101.101.5 255.255.255.252
no shutdown
exit

interface GigabitEthernet 0/3/0
ip add 200.100.100.5 255.255.255.252
no shutdown
exit

router ospf 1
router-id 1.1.1.1
net 200.100.100.0 0.0.0.3 area 0
net 200.101.101.0 0.0.0.3 area 0
net 200.100.100.4 0.0.0.3 area 0
net 200.101.101.4 0.0.0.3 area 0
passive-interface g0/0/0
passive-interface g0/1/0
passive-interface g0/2/0
passive-interface g0/3/0
exit
do wr
```



```
RT-2:
RTA:

en
conf t
hostname RTA

interface GigabitEthernet 0/0/0
ip add 200.100.100.2 255.255.255.252
no shutdown
exit

interface GigabitEthernet 0/1/0
ip add 200.100.100.6 255.255.255.252
no shutdown
exit

interface fa 0/0
ip add 10.24.10.1 255.255.255.252
no shutdown
exit

access-list 1 permit 192.160.0.0 0.15.255.255
ip nat inside source list 1 interface GigabitEthernet 0/0/0 overload
interface g0/0/0
ip nat outside
interface fa0/0
ip nat inside

router ospf 1
router-id 2.1.1.1
net 200.100.100.0 0.0.0.3 area 0
net 10.24.10.0 0.0.0.3 area 0
distance ospf external 100
default-information originate
passive-interface g0/0/0
passive-interface g0/1/0
exit

ip route 0.0.0.0 0.0.0.0 200.100.100.1
do wr
```

RTB:

```
en
conf t
hostname RTB

interface GigabitEthernet 0/0/0
ip add 200.101.101.2 255.255.255.252
no shutdown
exit

interface GigabitEthernet 0/1/0
ip add 200.101.101.6 255.255.255.252
no shutdown
exit

interface fa 0/0
ip add 11.24.11.1 255.255.255.252
no shutdown
exit

access-list 1 permit 192.160.0.0 0.15.255.255
ip nat inside source list 1 interface GigabitEthernet 0/0/0 overload
interface g0/0/0
ip nat outside
interface fa0/0
ip nat inside

router ospf 1
router-id 3.1.1.1
net 200.101.101.0 0.0.0.3 area 0
net 11.24.11.0 0.0.0.3 area 0
distance ospf external 100
default-information originate
passive-interface g0/0/0
passive-interface g0/1/0
exit

ip route 0.0.0.0 0.0.0.0 200.101.101.1
do wr
```

MLS-A:

```
en
conf t
ip routing
hostname MLS-A

interface GigabitEthernet 0/1
no switchport
ip add 10.24.10.2 255.255.255.252
no shutdown
exit

interface vlan 10
ip add 192.168.10.1 255.255.255.0
no shutdown
exit

interface vlan 20
ip add 192.168.20.1 255.255.255.0
no shutdown
exit

interface fa0/1
switchport mode access
switchport access vlan 10
no shutdown
exit

interface fa0/2
switchport mode access
switchport access vlan 20
no shutdown
exit

router ospf 1
router-id 2.1.1.2
net 10.24.10.0 0.0.0.3 area 0
net 192.168.10.0 0.0.0.255 area 10
net 192.168.20.0 0.0.0.255 area 10
passive-interface vlan 10
passive-interface vlan 20
exit
do wr
```

MLS-B:

```
en
conf t
ip routing
hostname MLS-B

interface GigabitEthernet 0/1
no switchport
ip add 11.24.11.2 255.255.255.252
no shutdown
exit

interface vlan 30
ip add 192.168.30.1 255.255.255.0
no shutdown
exit

interface vlan 40
ip add 192.168.40.1 255.255.255.0
no shutdown
exit

interface fa0/1
switchport mode access
switchport access vlan 30
no shutdown
exit

interface fa0/2
switchport mode access
switchport access vlan 40
no shutdown
exit

router ospf 1
router-id 2.1.1.2
net 11.24.11.0 0.0.0.3 area 0
net 192.168.30.0 0.0.0.255 area 10
net 192.168.40.0 0.0.0.255 area 10
passive-interface vlan 30
passive-interface vlan 40
exit
do wr
```

Agregación de tunel GRE-IPsec sobre OSPF

```
en
conf t
license boot module c2900 technology-package securityk9
do wr
do reload
```

USAR 2811********

RTA:

```
int tunnel 0
ip add 10.0.0.1 255.255.255.252
tunnel source g0/1/0
tunnel destination 200.101.101.6
no shut
exit

router ospf 2
router-id 10.10.10.10
network 10.0.0.0 0.0.0.3 area 0
distance ospf external 200
redistribute ospf 1 subnets
exit

router ospf 1
redistribute ospf 2 subnets
exit

ip route 200.101.101.6 255.255.255.255 g0/1/0

crypto isakmp policy 1
encryption aes 256
hash sha
authentication pre-share
group 5
exit

crypto isakmp key redes333 address 200.101.101.6
access-list 101 permit gre host 200.100.100.6 host 200.101.101.6
crypto ipsec transform-set GRE_IPSEC ah-sha-hmac esp-aes 256
crypto map VPN 1 ipsec-isakmp
set peer 200.101.101.6
set transform-set GRE_IPSEC
set security-association lifetime seconds 72000
match address 101
exit

int g0/1/0
crypto map VPN

do wr
```

RTB:

```
int tunnel 0
ip add 10.0.0.2 255.255.255.252
tunnel source g0/1/0
tunnel destination 200.100.100.6
no shut
exit

router ospf 2
router-id 11.11.11.11
network 10.0.0.0 0.0.0.3 area 0
distance ospf external 200
redistribute ospf 1 subnets
exit

router ospf 1
redistribute ospf 2 subnets
exit

ip route 200.100.100.6 255.255.255.255 g0/1/0

crypto isakmp policy 1
encryption aes 256
hash sha
authentication pre-share
group 5
exit

crypto isakmp key redes333 address 200.100.100.6
access-list 101 permit gre host 200.101.101.6 host 200.100.100.6
crypto ipsec transform-set GRE_IPSEC ah-sha-hmac esp-aes 256
crypto map VPN 1 ipsec-isakmp
set peer 200.100.100.6
set transform-set GRE_IPSEC
set security-association lifetime seconds 72000
match address 101
exit

int g0/1/0
crypto map VPN

do wr
```

**Los Grupos Diffie-Hellman deben ser cambiados en una situación de vida real**