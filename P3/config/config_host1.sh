ip addr add 30.1.1.1/24 dev eth1
ip link set eth0 up

### check
# ip addr show dev eth1
# ip link show dev eth1
# ifconfig

### replace 'add' with 'del' to revert
