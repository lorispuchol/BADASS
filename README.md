# BADASS
Bgp At Doors of Autonomous Systems: The purpose of this project is to expand our knowledge of networking by simulating multiple networks (VXLAN and BGP-EVPN) in GNS3

## P1

```bash
cp P1
docker build -t frrouting:lpuchol -f Dockerfile.router .
docker build -t alpine:lpuchol -f Dockerfile.host .
```

Then use these new images to create the router and the host in GNS3:
- Add template: in the project window `edit > preferences > docker containers > new`. Remember to rename templates (with the `-X` suffix and underscore `_`)
- define `8` network adapters for the router and `1` for the host.
- Once applied, `Browse End Devices > frrouting:lpuchol > configure template > symbol > browse > classic > route_switch_processor`
- Drag and drop the router and host to the workspace and rename
- Click play

Then entrer in the container with teminal:

```bash
docker ps
docker exec -it <container_id/name> sh
```

Reminder for evalution: Don't forget to save before export 