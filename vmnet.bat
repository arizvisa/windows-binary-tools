cd "c:\Program Files\VMware\VMware Workstation"
c:

.\vnetlib.exe -- stop net
.\vnetlib.exe -- stop dhcp

.\vnetlib.exe -- set vnet vmnet1 mask 255.255.255.0
.\vnetlib.exe -- set vnet vmnet1 addr 172.16.0.1

.\vnetlib.exe -- update dhcp vmnet1
.\vnetlib.exe -- update adapter vmnet1

.\vnetlib.exe -- set vnet vmnet8 mask 255.255.255.0
.\vnetlib.exe -- set vnet vmnet8 addr 172.31.0.1

.\vnetlib.exe -- update dhcp vmnet8
.\vnetlib.exe -- update nat vmnet8
.\vnetlib.exe -- update adapter vmnet8

.\vnetlib.exe -- start dhcp
.\vnetlib.exe -- start nat