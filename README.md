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
