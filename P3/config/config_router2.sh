# LOOPBACK (used for VTEP and BGP Router-ID)
ip addr add 1.1.1.2/32 dev lo
ip addr add 10.1.1.2/30 dev eth0  # to wil-1
ip link set lo up
ip link set eth0 up

vtysh << EOF
router ospf
 network 10.1.1.0/24 area 0
 network 1.1.1.0/24 area 0

router bgp 65000
 bgp router-id 1.1.1.2

 neighbor 1.1.1.1 remote-as 65000
 neighbor 1.1.1.1 update-source lo

 address-family l2vpn evpn
  neighbor 1.1.1.1 activate
  advertise-all-vni
 exit-address-family
EOF

ip link add vxlan10 type vxlan id 10 dstport 4789 local 1.1.1.2 nolearning
ip link set vxlan10 up

ip link add br0 type bridge
ip link set br0 up

ip link set vxlan10 master br0
ip link set eth1 master br0  # to host
ip link set eth1 up

# UNDERLAY LINK to next router(s)
# Examples shown below in per-router configs.
