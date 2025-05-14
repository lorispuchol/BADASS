##################################
### Configure Underlay Network ###
##################################

# Before VXLAN can function, the two routers need IP connectivity on their “underlay” interfaces (the physical or routed interfaces over which VXLAN packets will travel)
# dev=device

ip addr add 10.0.0.1/24 dev eth0
ip link set dev eth0 up

### Check ###
# ip addr show
# ip -d link show
# ping 10.0.0.2 # when router 2 is configured

##############################
### Create VXLAN Interface ###
##############################

# remote = Remote VTEP IP
# local = local VTEP IP
# Doing this enables unicast communication

ip link add vxlan10 type vxlan id 10 dstport 4789 local 10.0.0.1 remote 10.0.0.2 dev eth0
ip link set vxlan10 up

### Check ###
# ip -d link show dev vxlan10
# ip addr show dev vxlan10
# ping 10.0.0.2 # when router 2 is configured

# New 
# ip addr add 20.1.1.1/24 dev vxlan10
# ip link set vxlan10 up

#####################
### Create bridge ###
#####################

ip link add br0 type bridge
ip link set br0 up

### Check ###
# ifconfig
# ip addr show dev br0
# bridge fdb show br|macs br0
# brctl showmacs br0

#####################
### Config bridge ###
#####################

# Attach VXLAN to bridge
# Attach host-facing interface (eth1) to bridge

ip link set vxlan10 master br0
ip link set eth1 master br0

ip link set eth1 up
ip link set vxlan10 up
ip link set br0 up

# New 
##### utiliser ca la place et changer la conf pour les dynamic (group) egalement ?
# brctl addif br0 eth1
# brctl addif br0 vxlan10

### UP all ###
# ip link set eth0 up
# ip link set eth1 up
# ip link set vxlan10 up
# ip link set br0 up