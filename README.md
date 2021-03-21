# Error Pages Container

Used to provide customer error pages to traefik.

## docker-compose.yml

```yaml
version: '3.7'

networks:
  proxy:
    external: yes

services:
  errorpages:
    image: registry.deploy.opusvl.net/opusvl/errorpages
    deploy:
      mode: global
      placement:
        constraints:
        - node.role == manager
      update_config:
        delay: 15s
        order: start-first
        parallelism: 1      
      labels:
        traefik.enable: "true"
        traefik.http.services.errorpages.loadbalancer.server.port: 8080
        traefik.http.routers.errorpages.rule: HostRegexp(`{host:.+}`)
        traefik.http.routers.errorpages.priority: 10
        traefik.http.routers.errorpages.middlewares: errorpages@docker
        traefik.http.routers.errorpages.entrypoints: websecure
        traefik.http.routers.errorpages.tls: "true"
        traefik.http.middlewares.errorpages.errors.status: 400-599
        traefik.http.middlewares.errorpages.errors.service: errorpages@docker
        traefik.http.middlewares.errorpages.errors.query: "/{status}.html"
    networks:
      - proxy
```

Add the middleware to you containers deploy label:

```yaml
    deploy:
      labels:
        ...
        traefik.http.routers.traefik.middlewares: errorpages@docker        
```
