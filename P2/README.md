# P2

## Theory
__1. Local Area Network (LAN)__: A network that connects computers and devices in a limited geographical area such as a home, school, office buildin
- Small Geographic Coverage
- wired (ethernet) or wireless (Wi-Fi -> WLAN)

__2. Wide Area Network (WAN)__: A network that connects computers and devices over a large geographical area such as a country or the world
- Large Geographic Coverage
- The Internet itself is a type of WAN
- Can be ISP (Internet Service Provider) / Government

__3. Internet__: A global network of networks that connects millions of private, public, academic, business, and government networks

__4. Router (Layer 3: Network)__: A device designed to connect and route traffic between different networks
- Forwards packets between different networks (LAN → WAN, VLAN → VLAN).
- Most routers pass data between LANs and WANs.

[See router schema](../routing-diagram.jpeg)


__5. Modulator-Demodulator(Modem)__: A device that modulates and demodulates signals to convert digital data into analog signals for transmission over telephone lines (DSL) or cable lines (Cable) or Fiber Optic lines (Fiber).
- Serves as the bridge between your local network and your ISP
- Many modern devices are "modem-router combos."

__6. Switch (Layer 2: MAC)__: A device that connects multiple devices (computers, printers, servers) within a LAN and intelligently forwards data to the correct destination using MAC addresses
- spine-and-leaf topology (leaf = top of rack switch, spine = core switch)

__7. Virtual LAN (VLAN)__: A logically segmented network within a physical LAN that groups devices together (even if they are connected to the same switch)
- Limits broadcast traffic to only devices within the same VLAN
- Isolates sensitive departments (e.g., Finance, HR)  

[See VLAN schema](../VLAN_Concept.svg.png)  
(cf. https://www.fs.com/blog/differences-between-router-and-switch-14729.html)  
(cf. https://www.fs.com/blog/differences-between-router-and-switch-14729.html)

__8. Virtual Extensible LAN (VXLAN)__: A network virtualization technology consider as next-generation of VLAN. But not only that, it is fundamentally a different technology. definition: Virtual eXtensible Local Area Network (VXLAN) is a tunneling protocol that tunnels Ethernet (layer 2) traffic over an IP (layer 3) network.
| VLAN | VXLAN |
| --- | --- |
| Layer 2 (Ethernet)| Layer 2 over Layer 3 (IP/UDP) |
| 12-bit VID (VLAN ID) | 24-bit VNI (VXLAN Network Identifier) |
| 4,094 IDs (Insufficient for cloud providers with thousands of tenants) | 16 million segments |
| Ethernet encapsulation (Layer 2) | MAC-in-UDP encapsulation (layer 3) |

[See cast schema](../overlay-underlay-network.png)  
https://networklessons.com/cisco/ccnp-encor-350-401/introduction-to-virtual-extensible-lan-vxlan



__9. MAC Address__: A MAC address is a unique hardware identifier assigned to every network interface (Ethernet, Wi-Fi, Bluetooth...) by the manufacturer. It operates at Layer 2 (Data Link Layer) of the OSI model and is essential for communication within a LAN. (IP is layer 3: Network Layer)
- Format: 6-byte hexadecimal number (e.g., 00:1A:2B:3C:4D:5E)
- First 3 bytes (OUI) = Manufacturer ID (e.g., 00:1A:2B = Cisco).
- Last 3 bytes = Device-specific (assigned by the vendor).
- Globally unique (in theory, but can be spoofed/changed). Whereas IP addresses are dynamic and assigned by the network administrator
- ARP (Address Resolution Protocol) Maps IP addresses to MAC addresses (e.g., 192.168.1.10 → 00:1A:2B:3C:4D:5E), Devices use ARP to find each other in a LAN.

> Linux:
> - `ifconfig` or `ip r` (see the `ether` or `link/ether` field)
> - `brctl showmacs <bridgename>`
> - `ip link show type bridge`


__10. Cast__:
1. Unicast: One-to-One communication
3. Multicast: One-to-Many communication
2. Broadcast: One-to-All communication  

[See cast schema](../Screenshot-from-2025-04-01-14-53-03.png)


__11. Static cast vs Dynamic cast__:
- Static cast: fixed set of receivers (e.g., security cameras).
- Dynamic cast: Many receivers joining/leaving (e.g., live streaming). Uses protocols like IGMP/PIM for automatic group management

__12. Bridge (Layer 2: MAC)__: A networking device or software component that connects multiple network segments (like Ethernet LANs). It forwards traffic between connected interfaces based on MAC addresses (not IP addresses, like a router).
 - Connects	Segments of the same network (e.g., merging switches into one LAN: `eth0` + `wlan0`).
 - Connect two network in one network
 - Doesn’t route traffic between subnets
 - Even if two segments are logically part of the same network, they might be physically separated (e.g., different switches, cables, or interfaces). A bridge merges them into a single broadcast domain so devices can communicate seamlessly.
 - A switch is essentially a multi-port bridge.
 - Today, "bridging" is mostly used in software (e.g., Linux bridges for VMs/containers).
 - If your "segments" are already on the same switch, you don’t need a bridge—the switch handles it.

[See bridge schema](../Network_Bridging.png)

__13. Segment:__ A logical or physical subdivision of a network where devices can communicate directly without passing through a router.


> VTEP—VXLAN= Virtual/VXLAN Tunnel EndPoint

## Walkthrough
