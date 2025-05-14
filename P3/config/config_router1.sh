# Interface config
ip addr add 1.1.1.1/32 dev lo
ip link set lo up

ip addr add 10.1.1.1/30 dev eth0  # to wil-2
ip addr add 10.1.1.5/30 dev eth1  # to wil-3
ip addr add 10.1.1.9/30 dev eth2  # to wil-4

ip link set eth0 up
ip link set eth1 up
ip link set eth2 up

# Start FRR (only needed if not done via entrypoint)

# FRR config
vtysh << EOF
configure terminal
router ospf
 network 10.1.1.0/24 area 0
 network 1.1.1.0/24 area 0

router bgp 65000
 bgp router-id 1.1.1.1

 neighbor 1.1.1.2 remote-as 65000
 neighbor 1.1.1.2 update-source lo

 neighbor 1.1.1.3 remote-as 65000
 neighbor 1.1.1.3 update-source lo

 neighbor 1.1.1.4 remote-as 65000
 neighbor 1.1.1.4 update-source lo

 address-family l2vpn evpn
  neighbor 1.1.1.2 activate
  neighbor 1.1.1.3 activate
  neighbor 1.1.1.4 activate

  neighbor 1.1.1.2 route-reflector-client
  neighbor 1.1.1.3 route-reflector-client
  neighbor 1.1.1.4 route-reflector-client
 exit-address-family
EOF
