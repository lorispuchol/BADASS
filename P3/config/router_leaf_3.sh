ip addr add 1.1.1.4/32 dev lo
ip link set lo up

ip addr add 10.1.1.10/30 dev eth2  # to wil-1
ip link set eth2 up

# VXLAN + bridge
ip link add vxlan10 type vxlan id 10 dstport 4789 local 1.1.1.4 nolearning
ip link set vxlan10 up

ip link add br0 type bridge
ip link set br0 up

ip link set eth0 master br0  # to host
ip link set vxlan10 master br0
ip link set eth0 up

vtysh << EOF
configure terminal
router ospf
 network 1.1.1.0/24 area 0
 network 10.1.1.0/24 area 0

router bgp 65000
 bgp router-id 1.1.1.4

 neighbor 1.1.1.1 remote-as 65000
 neighbor 1.1.1.1 update-source lo

 address-family l2vpn evpn
  neighbor 1.1.1.1 activate
  advertise-all-vni
 exit-address-family
exit
EOF