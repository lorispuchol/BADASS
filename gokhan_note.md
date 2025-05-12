BADASS

-> repartion of the volume, made by launching my vm with a gparted disq. Becaues the partitions are not mounted yet, you can modify them. So we can move them
we let 1 go of free space for the swap memory. we have to mount swap in a new partition.

Bgp ( border gateway protocole ) 

OSPF:opon shortest path first
- interior gateway protocole
- Link state routing protocole
 the goal so is to learn routes.
OSPF does this by learning every information of the routers on the network. the results is all the routers have the same knowledge/data in the network.
the way it knows this is by exchanging LSA (Link state advertisement)(information about routers, subnets and other)
LSA is registed in the LSDB (link state database )
Once informations are exchanged, each router choose the best path to add to it's LSDB information.

	1) Neighboor relationships.

exchange of packet type HELLO
- sending RID ( routeur id ) 
Status of the routers: Down to init to 2-way
DR - BDR are elected. because there will be too much information exchanged if a router goes down.
if a router goes down, only the BR is learning from the information and sending informations to the others

one it is finished, it enters exstart state state.
router selecte the slave and master, based on the router ID.
state changed to exchange state. exchange in LSA -> DBD ( data base description )
-> LSR (link state resquest ) for unknown host
-> LSU (link state update )
-> LSAck (link state aknowlodgement)   

Then there is a cost calculation, in kbps, the lest it cost, the better. The winner is aded to the routing table

two type of routing protocols:
- Interior gateway protocol (IGP)
- Exterior Gateway protocol (EGP)
cf classification of routing protocole

IS to IS (intermediate system)
less common than OSPF
becuse
- OSPF = better performance and efficiency
- Relatively easy to configure and manages
- Supporting variable lenght subnet masks (VLSMs)
- Supporting multiple areasem wich allows for more hierarchical routing and improved scalabilyty

 VXLAN Key Components
Concept	Description
VNI (VXLAN Network Identifier)	: Like a VLAN ID, but 24-bit (supports ~16 million networks).
VTEP (VXLAN Tunnel Endpoint)	: A device (like a switch, router, or server) that encapsulates/decapsulates VXLAN traffic.
Underlay Network		: The physical IP network VXLAN runs over (your actual routers/switches).
Overlay Network			: The virtual Layer 2 network created by VXLAN.

the configuration involves:
- setting up the underlay up network.
- creating the VXLAN interfaces
- bridging to the host interfaces

Address Resolution Protocol

💬 Summary: Protocols Involved
Layer	Protocol	Role
L2	ARP		Resolve router's IP to MAC address
L2	Ethernet	Frame to physically send the packet
L3	IP		The packet itself (e.g., to 8.8.8.8)
L4	ICMP / TCP / UDP	Depends on what you're doing (ping, HTTP, etc.)

bridge is a virtual switch. 

what is broadcast / gateway ?
how it knows it should go on the vxlan ?
Linux use the routing table to decide in wich interface to send the packet

cf screenshot dynamic cast - static cast.

-----------------------------------------------------------
Part 2:
Step-by-Step Guide: VXLAN Lab in GNS3 (Beginner-Friendly)
-----------------------------------------------------------

suivre cette merde:
https://www.cisco.com/c/en/us/support/docs/switches/nexus-9000-series-switches/118978-config-vxlan-00.html

PART 3 :
VPN : A VPN (Virtual Private Network) is a technology that creates a secure, encrypted tunnel over a public or untrusted network — like the internet — so you can send private traffic as if you were on a private network.

PART 3 :
EVPN: is a technology for carrying layer 2 Ethernet traffic as a private using wide area network protocols.
EVPN technologies include ehternet over MPLS and ethernet over VXLAN.

MPLS: is a routing technique in telecommunications networks that directs data from one node to the text based on labels rather than network adresses. Whereas network adresses identify endpoints, the labels identify established paths between endpoints.

Controller will learn Mac Adress.

WAN - wide area network. != lan local.

RR: route reflection. est un composant utilise par certains protocoles de routage comme BGP. Solution for the full mesh: (chaque routeur communique avec tous les autres).
it create a hub to reflect routes between peers.

Dynamic relations:
Leafs techno leaf and spine. -> permit a better communication beetween ouest and est.
ECMP (Equal-Cost Multipath)

loopback in network : ?
what is the purpose of that ?

setup bgp.

Software-Defined Networking (SDN)
https://www.perplexity.ai/page/computer-network-types-explain-utOkDqSqRH69zvGJmOe_1Q

---------------
PART 3
VXLAN EVPN Lab in GNS3 with FRRouting: Step-by-Step Guide
-----------------
Autonymous systeme ?

IGP : interior gateway protocole. to exchange routing tables.

border router: router supposed to speak with router of other AS

Article for bgp.
https://www.kentik.com/kentipedia/bgp-routing/
 network 10.0.0.3/32 area 0
https://www.catchpoint.com/dynamic-routing-protocols/bgp-vs-ospf#:~:text=Differences%20between%20OSPF%20and%20BGP,-There%20are%20a&text=To%20start%20with%2C%20OSPF%20is,domains%20(inter%2Ddomain).

wil-1
ip addr add 10.0.0.1/32 dev lo
ip addr add 10.0.1.1/30 dev eth0
ip addr add 10.0.1.5/30 dev eth1
ip addr add 10.0.1.9/30 dev eth2

vtysh
configure terminal
router ospf
 network 10.0.0.1/32 area 0
 network 10.0.1.0/30 area 0
 network 10.0.1.4/30 area 0
 network 10.0.1.8/30 area 0
end
write memory

configure terminal

router bgp 65000
 bgp router-id 10.0.0.1
 neighbor 10.0.0.3 remote-as 65000
 neighbor 10.0.0.3 update-source lo

 address-family l2vpn evpn
  neighbor 10.0.0.3 activate
  neighbor 10.0.0.3 route-reflector-client
 exit-address-family

end
write memory

------------------------------------------
wil-2
ip addr add 10.0.0.2/32 dev lo
ip addr add 10.0.1.2/30 dev eth0

vtysh
configure terminal
router ospf
 network 10.0.0.2/32 area 0
 network 10.0.1.0/30 area 0
end
write memory

vtysh
configure terminal

router bgp 65000
 bgp router-id 10.0.0.2
 neighbor 10.0.0.1 remote-as 65000
 neighbor 10.0.0.1 update-source lo

 address-family l2vpn evpn
  neighbor 10.0.0.1 activate
  advertise-all-vni
 exit-address-family

end
write memory


------------------------------------------
wil-3
ip addr add 10.0.0.3/32 dev lo
ip addr add 10.0.1.6/30 dev eth1

vtysh
configure terminal
router ospf
 network 10.0.0.3/32 area 0
 network 10.0.1.4/30 area 0
end
write memory
------------------------------------------
wil-4
ip addr add 10.0.0.4/32 dev lo
ip addr add 10.0.1.10/30 dev eth2

router ospf
 network 10.0.0.4/32 area 0
 network 10.0.1.8/30 area 0
 end
write memory
--------------------------------------------
 test with
show ip ospf neighbor
show ip route

show bgp l2vpn evpn summary
show bgp l2vpn evpn

show evpn mac vni 100: ✅ This shows the MAC address table learned over VXLAN VNI 100.
---------------------------------------------

🎯 FINAL MAPPING

Real World	Networking Equivalent
Building	Leaf Router / VTEP
Road system	IP Underlay / OSPF
Package		Ethernet frame
Truck		VXLAN tunnel (encapsulation)
Address book	EVPN MAC/IP database
Mailman		BGP carrying EVPN to share the address book beetween building
Mail hub	Route Reflector (BGP RR)

final script :
Absolutely! Here's your complete VXLAN EVPN lab configuration with:

🧠 1 Spine (wil-1) acting as the Route Reflector

🌿 3 Leafs: wil-2, wil-3, wil-4 (each with one host)

🔧 OSPF underlay, BGP EVPN, VXLAN with VNI 100


⚙️ GENERAL SETUP PER ROUTER

Workflow : ->