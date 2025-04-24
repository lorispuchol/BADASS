# P1

## Theory

### Graphical Network Simulator-3 (GNS3)
Is an open-source network software emulator that allows users to simulate complex networks. It is used for designing, testing, and troubleshooting network configurations in a virtual environment before deploying them in real-world scenarios (alternatives: EVE-NG ...)
 - Emulators: VMware, VirtualBox, QEMU, Docker, Cisco

### Cisco Internetwork Operating System (IOS) 
Is a proprietary operating system used on most Cisco Systems routers and switches. (alternatives: Juniper -> Junos OS)

### Dynamips
Is a Cisco router emulator that allows users to run real Cisco IOS images on standard PCs without needing physical hardware. It is widely used in network labs

### FRRouting (FRR)
Is a free and open source Internet routing protocol suite for Linux and Unix platforms. It implements BGP, OSPF, RIP, IS-IS, PIM... (FRR is a fork of Quagga, which was a fork of Zebra which are no longer maintained)
- CLI: `vtysh`
- open-source alternative to Cisco IOS or others

### Border Gateway Protocol (BGP)
Is the core routing protocol of the Internet that enables data routing between autonomous systems (ASes). Here's a concise overview:
- __Path Vector Protocol__: Makes routing decisions based on paths, network policies and rule-sets
- __Exterior Gateway Protocol (EGP)__: Used for routing between different autonomous systems
- __TCP-Based__: Uses TCP port 179 for reliable connections
- __Incremental Updates__: Only sends updates when routes change


### Open Shortest Path First (OSPF)
OSPF is a link-state routing protocol used primarily in enterprise networks and large-scale IP networks. It is an Interior Gateway Protocol (IGP), meaning it operates within a single Autonomous System (AS).

### Autonomous System (AS)
Is a collection of IP networks and routers under the control of a single organization (e.g., an ISP, enterprise, or cloud provider) that operates under a unified routing policy.
- Assigned a unique AS number (ASN) by IANA or regional registries (RIRs).
- Uses BGP (Border Gateway Protocol) to exchange routing information with other ASes.
- Can run IGPs internally (e.g., OSPF, IS-IS, EIGRP).
- Defines routing policies (e.g., preferring one transit provider over another).


### Intermediate System to Intermediate System (IS-IS)
Is a link-state routing protocol similar to OSPF, but with key differences in design and operation. It was originally developed for OSI (CLNP) networks but was later extended for IP routing (Integrated IS-IS).

## Walkthrough

```bash
cd P1
docker build -t frrouting:lpuchol -f Dockerfile.router .
docker build -t alpine:lpuchol -f Dockerfile.host .
gns3
```

Then use these new images to create the router and the host in GNS3:
- Add template: settings of GNS3: `edit > preferences > docker containers > new`. Remember to rename templates (without the `-X` suffix and without underscore `_`)
- set `8` network adapters for the router and `4` for the host.
- set `telnet` for auxiliary console type
- Once applied, `Browse End Devices > frrouting:lpuchol > configure template > symbol > browse > classic > route_switch_processor` and `classic > docker_guest` for the host
- Drag and drop the router and host to the workspace and rename
- Click play

Then entrer in the container with terminal or with UI:
```bash
docker ps
docker exec -it <container_id/name> sh
```
```sh
ps
```

we can see that the requires services (daemons) are running

> Reminder: For evaluation, don't forget to save before export. And include base images.