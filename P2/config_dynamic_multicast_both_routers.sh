# Delete the old VXLAN interface (if it exists):
ip link del vxlan10

# Recreate VXLAN with multicast
ip link add vxlan10 type vxlan id 10 dstport 4789 group 239.1.1.1 dev eth0 # Multicast group for dynamic discovery

# Reattach to br0
ip link set vxlan10 master br0
ip link set vxlan10 up

### Check ###
# ifconfig
# ip -d link show dev vxlan10
# brctl showmacs br0
# bridge fdb show br|macs br0