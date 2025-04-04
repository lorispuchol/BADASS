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