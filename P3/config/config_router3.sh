# Linux shell
ip addr add 1.1.1.3/32 dev lo
ip addr add 10.1.1.6/30 dev eth0  # to wil-1
ip link set eth0 up

vtysh << EOF
router ospf
 network 10.1.1.0/24 area 0
 network 1.1.1.0/24 area 0

router bgp 65000
 bgp router-id 1.1.1.3

 neighbor 1.1.1.1 remote-as 65000
 neighbor 1.1.1.1 update-source lo

 address-family l2vpn evpn
  neighbor 1.1.1.1 activate
  advertise-all-vni
 exit-address-family
EOF

# VXLAN + bridge
ip link add vxlan10 type vxlan id 10 dstport 4789 local 1.1.1.3 nolearning
ip link set vxlan10 up

ip link add br0 type bridge
ip link set br0 up

ip link set vxlan10 master br0
ip link set eth0 master br0  # to host
ip link set eth0 up
