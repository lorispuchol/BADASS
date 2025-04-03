##################################
### Configure Underlay Network ###
##################################

### Before VXLAN can function, the two routers need IP connectivity on their “underlay” interfaces (the physical or routed interfaces over which VXLAN packets will travel)
ip addr add 10.0.0.2/24 dev eth0
ip link set dev eth0 up
# dev=device, optional

### Check ###
# ip addr show
# ip link show
# ping 10.0.0.1 # when router 1 is configured

##############################
### Create VXLAN Interface ###
##############################

ip link add vxlan10 type vxlan id 10 dstport 4789 local 10.0.0.2 remote 10.0.0.1 dev eth0
# remote = Remote VTEP IP
# local = local VTEP IP
# Doing this enables unicast communication
ip link set vxlan10 up


### Check ###
# ip addr show dev vxlan10
# ping 10.0.0.1 # when router 1 is configured

################################
### Create and set up bridge ###
################################

ip link add br0 type bridge
ip link set vxlan10 master br0  # Attach VXLAN to bridge
ip link set eth1 master br0     # Attach host-facing interface (eth1) to bridge

ip link set eth1 up
# ip link set vxlan10 up ### Maybe no
ip link set br0 up

### Check ###
# ip addr show dev br0
# bridge fdb show br|macs br0
# brctl showmacs br0