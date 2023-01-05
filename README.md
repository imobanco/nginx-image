# Resumo
Esse repositório possui o maquinário necessário para construir e dar push em imagens nginx.

> https://hub.docker.com/_/nginx

No momento estão sendo construídas as imagens/versões:
- imobanco/nginx:1.23

> todas as imagens utilizam a versão bullseye-slim

# Utilização

## Arquivo de conf.local
```
server {
    listen 80;
    listen 443 ssl;
    ssl_certificate /etc/ssl/certs/nginx-selfsigned.crt;
    ssl_certificate_key /etc/ssl/private/nginx-selfsigned.key;
}
```

## Docker
```shell
??
```

## Docker-compose
```
version: "3.7"

services:
  nginx:
    container_name: service-nginx
    image: imobanco/nginx:latest
    volumes:
      - ./conf.local:/etc/nginx/conf.d/conf.local
    ports:
      - 80:80
      - 443:443
    restart: on-failure
```

## Podman/Kube
```
??
```