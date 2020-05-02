# POC: Traefik

It demonstrates how to use [Traefik](https://github.com/containous/traefik) to route requests to multiple [Node.js](https://nodejs.org) servers running on [Docker](https://github.com/docker) containers.

We want Traefik to redirect HTTP requests to `http://localhost:4000` to any running container.

## How to run

| Description | Command |
| :--- | :--- |
| Provision | `make up` |
| Destroy | `make down` |
| Show logs | `make logs` |
| Run tests | `make test` |

> Running `SCALE=N make up` will run N containers (e.g.: `SCALE=10 make up` will run 10 containers)

## Preview

```
             Name                           Command               State            Ports         
-------------------------------------------------------------------------------------------------
poc-node-traefik_application_1   docker-entrypoint.sh node  ...   Up      0.0.0.0:32868->3000/tcp
poc-node-traefik_application_2   docker-entrypoint.sh node  ...   Up      0.0.0.0:32869->3000/tcp
poc-node-traefik_application_3   docker-entrypoint.sh node  ...   Up      0.0.0.0:32870->3000/tcp
poc-node-traefik_application_4   docker-entrypoint.sh node  ...   Up      0.0.0.0:32871->3000/tcp
poc-node-traefik_application_5   docker-entrypoint.sh node  ...   Up      0.0.0.0:32867->3000/tcp
poc-node-traefik_proxy_1         /entrypoint.sh --log.level ...   Up      0.0.0.0:4000->80/tcp   
```

```
audited 1204528 packages in 5.675s

32 packages are looking for funding
  run `npm fund` for details

found 1525 low severity vulnerabilities
  run `npm audit fix` to fix them, or `npm audit` for details
Building application
Step 1/6 : FROM node:alpine
 ---> 0854fcfc1637
Step 2/6 : WORKDIR /application
 ---> Using cache
 ---> 3ebe5043dbc4
Step 3/6 : ENV PORT 3000
 ---> Using cache
 ---> 6e83a7b12729
Step 4/6 : COPY dist/index.js .
 ---> Using cache
 ---> 8856a276e638
Step 5/6 : EXPOSE 3000
 ---> Using cache
 ---> 222c2974c154
Step 6/6 : CMD [ "node", "index.js" ]
 ---> Using cache
 ---> ee70b978b6af

Successfully built ee70b978b6af
Successfully tagged application:latest
Recreating poc-node-traefik_proxy_1       ... done
Recreating poc-node-traefik_application_1 ... done
Recreating poc-node-traefik_application_2 ... done
Recreating poc-node-traefik_application_3 ... done
Recreating poc-node-traefik_application_4 ... done
Recreating poc-node-traefik_application_5 ... done
```

```
application_1  | Server running on port 3000
application_3  | Server running on port 3000
application_4  | Server running on port 3000
application_2  | Server running on port 3000
application_5  | Server running on port 3000
application_2  | 2020-05-02T18:39:43.017Z: Request received
application_4  | 2020-05-02T18:39:43.019Z: Request received
application_3  | 2020-05-02T18:39:43.020Z: Request received
application_2  | 2020-05-02T18:39:43.046Z: Request received
application_4  | 2020-05-02T18:39:43.047Z: Request received
application_4  | 2020-05-02T18:39:43.047Z: Request received
application_4  | 2020-05-02T18:39:43.048Z: Request received
application_4  | 2020-05-02T18:39:43.049Z: Request received
application_2  | 2020-05-02T18:39:43.049Z: Request received
application_4  | 2020-05-02T18:39:43.050Z: Request received
```
