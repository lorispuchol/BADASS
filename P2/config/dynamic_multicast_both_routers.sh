######################################
### Delete the old VXLAN interface ###
######################################

ip link del vxlan10

###########################################
### Recreate VXLAN Interface with group ###
###########################################

ip link add vxlan10 type vxlan id 10 dstport 4789 group 239.1.1.1 dev eth0 # Multicast group for dynamic discovery
ip link set vxlan10 up

#######################
### Reattach to br0 ###
#######################

ip link set vxlan10 master br0

### Check ###
# ifconfig
# ip -d link show dev vxlan10
# brctl showmacs br0
# bridge fdb show br|macs br0


### UP all ###
# ip link set eth0 up
# ip link set eth1 up
# ip link set vxlan10 up
# ip link set br0 up