# POC: Traefik

It demonstrates how to use [Traefik](https://github.com/containous/traefik) to route requests to multiple [Node.js](https://github.com/nodejs) servers running on [Docker](https://github.com/docker) containers.

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
           Name                          Command               State            Ports         
----------------------------------------------------------------------------------------------
poc-devops-traefik_proxy_1    /entrypoint.sh --log.level ...   Up      0.0.0.0:4000->80/tcp   
poc-devops-traefik_server_1   docker-entrypoint.sh node  ...   Up      0.0.0.0:32810->3000/tcp
poc-devops-traefik_server_2   docker-entrypoint.sh node  ...   Up      0.0.0.0:32812->3000/tcp
poc-devops-traefik_server_3   docker-entrypoint.sh node  ...   Up      0.0.0.0:32813->3000/tcp
poc-devops-traefik_server_4   docker-entrypoint.sh node  ...   Up      0.0.0.0:32811->3000/tcp
poc-devops-traefik_server_5   docker-entrypoint.sh node  ...   Up      0.0.0.0:32814->3000/tcp
```

```
audited 2 packages in 1.062s
found 0 vulnerabilities

Creating network "poc-devops-traefik_default" with the default driver
Building server
Step 1/6 : FROM node:alpine
 ---> 0854fcfc1637
Step 2/6 : WORKDIR /application
 ---> Using cache
 ---> 6303181eba3a
Step 3/6 : ENV PORT 3000
 ---> Using cache
 ---> a77ba85570a7
Step 4/6 : COPY dist/index.js .
 ---> 036ec9ca8ec2
Step 5/6 : EXPOSE 3000
 ---> Running in 01f221da2262
Removing intermediate container 01f221da2262
 ---> fb0a7d5173ce
Step 6/6 : CMD [ "node", "index.js" ]
 ---> Running in d58ca2ef4501
Removing intermediate container d58ca2ef4501
 ---> 0c2bee211b66

Successfully built 0c2bee211b66
Successfully tagged server:latest
Creating poc-devops-traefik_proxy_1  ... done
Creating poc-devops-traefik_server_1 ... done
Creating poc-devops-traefik_server_2 ... done
Creating poc-devops-traefik_server_3 ... done
Creating poc-devops-traefik_server_4 ... done
Creating poc-devops-traefik_server_5 ... done
```

```
server_1  | Server running on port 3000
server_2  | Server running on port 3000
server_3  | Server running on port 3000
server_5  | Server running on port 3000
server_4  | Server running on port 3000
```

## Tests

```
processor      Intel(R) Core(TM) i7-7500U CPU @ 2.70GHz
memory         16GiB System memory
```

### 2 containers

```
Running 30s test @ http://localhost:4000
30 connections

┌─────────┬──────┬──────┬───────┬───────┬─────────┬─────────┬──────────┐
│ Stat    │ 2.5% │ 50%  │ 97.5% │ 99%   │ Avg     │ Stdev   │ Max      │
├─────────┼──────┼──────┼───────┼───────┼─────────┼─────────┼──────────┤
│ Latency │ 0 ms │ 2 ms │ 8 ms  │ 10 ms │ 2.58 ms │ 2.23 ms │ 75.02 ms │
└─────────┴──────┴──────┴───────┴───────┴─────────┴─────────┴──────────┘
┌───────────┬────────┬────────┬─────────┬─────────┬─────────┬────────┬────────┐
│ Stat      │ 1%     │ 2.5%   │ 50%     │ 97.5%   │ Avg     │ Stdev  │ Min    │
├───────────┼────────┼────────┼─────────┼─────────┼─────────┼────────┼────────┤
│ Req/Sec   │ 5259   │ 5259   │ 9975    │ 10143   │ 9730.6  │ 888.55 │ 5259   │
├───────────┼────────┼────────┼─────────┼─────────┼─────────┼────────┼────────┤
│ Bytes/Sec │ 747 kB │ 747 kB │ 1.42 MB │ 1.44 MB │ 1.38 MB │ 126 kB │ 747 kB │
└───────────┴────────┴────────┴─────────┴─────────┴─────────┴────────┴────────┘

Req/Bytes counts sampled once per second.

292k requests in 30.05s, 41.5 MB read
```

### 5 containers

```
Running 30s test @ http://localhost:4000
30 connections

┌─────────┬──────┬──────┬───────┬───────┬─────────┬─────────┬──────────┐
│ Stat    │ 2.5% │ 50%  │ 97.5% │ 99%   │ Avg     │ Stdev   │ Max      │
├─────────┼──────┼──────┼───────┼───────┼─────────┼─────────┼──────────┤
│ Latency │ 0 ms │ 2 ms │ 10 ms │ 13 ms │ 2.97 ms │ 2.82 ms │ 71.33 ms │
└─────────┴──────┴──────┴───────┴───────┴─────────┴─────────┴──────────┘
┌───────────┬────────┬────────┬─────────┬─────────┬─────────┬─────────┬────────┐
│ Stat      │ 1%     │ 2.5%   │ 50%     │ 97.5%   │ Avg     │ Stdev   │ Min    │
├───────────┼────────┼────────┼─────────┼─────────┼─────────┼─────────┼────────┤
│ Req/Sec   │ 4531   │ 4531   │ 9079    │ 9303    │ 8652.94 │ 1074.77 │ 4531   │
├───────────┼────────┼────────┼─────────┼─────────┼─────────┼─────────┼────────┤
│ Bytes/Sec │ 644 kB │ 644 kB │ 1.29 MB │ 1.32 MB │ 1.23 MB │ 153 kB  │ 643 kB │
└───────────┴────────┴────────┴─────────┴─────────┴─────────┴─────────┴────────┘

Req/Bytes counts sampled once per second.

260k requests in 30.05s, 36.9 MB read
```

### 10 containers

```
Running 30s test @ http://localhost:4000
30 connections

┌─────────┬──────┬──────┬───────┬───────┬─────────┬─────────┬──────────┐
│ Stat    │ 2.5% │ 50%  │ 97.5% │ 99%   │ Avg     │ Stdev   │ Max      │
├─────────┼──────┼──────┼───────┼───────┼─────────┼─────────┼──────────┤
│ Latency │ 0 ms │ 3 ms │ 12 ms │ 16 ms │ 3.44 ms │ 3.31 ms │ 88.66 ms │
└─────────┴──────┴──────┴───────┴───────┴─────────┴─────────┴──────────┘
┌───────────┬────────┬────────┬─────────┬─────────┬─────────┬─────────┬────────┐
│ Stat      │ 1%     │ 2.5%   │ 50%     │ 97.5%   │ Avg     │ Stdev   │ Min    │
├───────────┼────────┼────────┼─────────┼─────────┼─────────┼─────────┼────────┤
│ Req/Sec   │ 3755   │ 3755   │ 8083    │ 8495    │ 7619.7  │ 1123.78 │ 3754   │
├───────────┼────────┼────────┼─────────┼─────────┼─────────┼─────────┼────────┤
│ Bytes/Sec │ 534 kB │ 534 kB │ 1.15 MB │ 1.21 MB │ 1.08 MB │ 160 kB  │ 533 kB │
└───────────┴────────┴────────┴─────────┴─────────┴─────────┴─────────┴────────┘

Req/Bytes counts sampled once per second.

229k requests in 30.05s, 32.5 MB read
```
