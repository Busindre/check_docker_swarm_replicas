# check_docker_swarm_replicas
Simple Nagios/Icinga plugin that checks that the number of configured and active replicas matches.
Simple Nagios/Icinga plugin that checks that the number of configured and active replicas matches.

The script lists all the services with their corresponding replica status in their three states, OK/Warning/Critical.

It warns by Warning / Critical when the number of replicas do not match. Critical when any service has 0 active replicas and Warning for any other service that has more than one active replica but does not match the configured ones. Example output

**OK**
```
OK: 0 replicas with problems.

portainer_portainer: 1/1 OK
portainer_portainer_agent: 5/5 OK
traefik_docker-socket-proxy: 3/3 OK
traefik_traefik: 3/3 OK
```
**Warning**
```
Warning: 2 service with problems.
 
portainer_portainer: 1/1 OK
portainer_portainer_agent: 4/5 Warning
traefik_docker-socket-proxy: 1/3 Warning
traefik_traefik: 3/3 OK
```
**Critical**
```
Critical: 1 service with 0 replicas activ and 1 in warning.
 
portainer_portainer: 1/1 OK
portainer_portainer_agent: 4/5 Warning
traefik_docker-socket-proxy: 0/3 Critical
traefik_traefik: 3/3 OK
```
