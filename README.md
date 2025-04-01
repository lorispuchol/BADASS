# BADASS
Bgp At Doors of Autonomous Systems: The purpose of this project is to expand our knowledge of networking by simulating multiple networks (VXLAN and BGP-EVPN) in GNS3

## P1

```bash
cd P1
docker build -t frrouting:lpuchol -f Dockerfile.router .
docker build -t alpine:lpuchol -f Dockerfile.host .
gns3
```

Then use these new images to create the router and the host in GNS3:
- Add template: settings of GNS3: `edit > preferences > docker containers > new`. Remember to rename templates (without the `-X` suffix and without underscore `_`)
- define `8` network adapters for the router and `1` for the host.
- Once applied, `Browse End Devices > frrouting:lpuchol > configure template > symbol > browse > classic > route_switch_processor` and `classic > docker_guest` for the host
- Drag and drop the router and host to the workspace and rename
- Click play

Then entrer in the container with terminal or with UI:
```bash
docker ps
docker exec -it <container_id/name> sh
```

> Reminder: For evaluation, don't forget to save before export and include base images.