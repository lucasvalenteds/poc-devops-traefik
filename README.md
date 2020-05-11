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
poc-node-traefik_server_1   docker-entrypoint.sh node  ...   Up      0.0.0.0:32868->3000/tcp
poc-node-traefik_server_2   docker-entrypoint.sh node  ...   Up      0.0.0.0:32869->3000/tcp
poc-node-traefik_server_3   docker-entrypoint.sh node  ...   Up      0.0.0.0:32870->3000/tcp
poc-node-traefik_server_4   docker-entrypoint.sh node  ...   Up      0.0.0.0:32871->3000/tcp
poc-node-traefik_server_5   docker-entrypoint.sh node  ...   Up      0.0.0.0:32867->3000/tcp
poc-node-traefik_proxy_1         /entrypoint.sh --log.level ...   Up      0.0.0.0:4000->80/tcp   
```

```
audited 1204528 packages in 5.675s

32 packages are looking for funding
  run `npm fund` for details

found 1525 low severity vulnerabilities
  run `npm audit fix` to fix them, or `npm audit` for details
Building server
Step 1/6 : FROM node:alpine
 ---> 0854fcfc1637
Step 2/6 : WORKDIR /server
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
Successfully tagged server:latest
Recreating poc-node-traefik_proxy_1       ... done
Recreating poc-node-traefik_server_1 ... done
Recreating poc-node-traefik_server_2 ... done
Recreating poc-node-traefik_server_3 ... done
Recreating poc-node-traefik_server_4 ... done
Recreating poc-node-traefik_server_5 ... done
```

```
server_1  | Server running on port 3000
server_3  | Server running on port 3000
server_4  | Server running on port 3000
server_2  | Server running on port 3000
server_5  | Server running on port 3000
server_2  | 2020-05-02T18:39:43.017Z: Request received
server_4  | 2020-05-02T18:39:43.019Z: Request received
server_3  | 2020-05-02T18:39:43.020Z: Request received
server_2  | 2020-05-02T18:39:43.046Z: Request received
server_4  | 2020-05-02T18:39:43.047Z: Request received
server_4  | 2020-05-02T18:39:43.047Z: Request received
server_4  | 2020-05-02T18:39:43.048Z: Request received
server_4  | 2020-05-02T18:39:43.049Z: Request received
server_2  | 2020-05-02T18:39:43.049Z: Request received
server_4  | 2020-05-02T18:39:43.050Z: Request received
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
│ Latency │ 0 ms │ 3 ms │ 11 ms │ 14 ms │ 3.97 ms │ 2.98 ms │ 67.14 ms │
└─────────┴──────┴──────┴───────┴───────┴─────────┴─────────┴──────────┘
┌───────────┬────────┬────────┬────────┬─────────┬────────┬────────┬────────┐
│ Stat      │ 1%     │ 2.5%   │ 50%    │ 97.5%   │ Avg    │ Stdev  │ Min    │
├───────────┼────────┼────────┼────────┼─────────┼────────┼────────┼────────┤
│ Req/Sec   │ 3531   │ 3531   │ 7003   │ 7255    │ 6711.9 │ 769.84 │ 3531   │
├───────────┼────────┼────────┼────────┼─────────┼────────┼────────┼────────┤
│ Bytes/Sec │ 502 kB │ 502 kB │ 994 kB │ 1.03 MB │ 953 kB │ 109 kB │ 501 kB │
└───────────┴────────┴────────┴────────┴─────────┴────────┴────────┴────────┘

Req/Bytes counts sampled once per second.

201k requests in 30.05s, 28.6 MB read
```

### 5 containers

```
Running 30s test @ http://localhost:4000
30 connections

┌─────────┬──────┬──────┬───────┬───────┬─────────┬────────┬──────────┐
│ Stat    │ 2.5% │ 50%  │ 97.5% │ 99%   │ Avg     │ Stdev  │ Max      │
├─────────┼──────┼──────┼───────┼───────┼─────────┼────────┼──────────┤
│ Latency │ 1 ms │ 4 ms │ 15 ms │ 19 ms │ 5.01 ms │ 3.7 ms │ 64.97 ms │
└─────────┴──────┴──────┴───────┴───────┴─────────┴────────┴──────────┘
┌───────────┬────────┬────────┬────────┬────────┬─────────┬─────────┬────────┐
│ Stat      │ 1%     │ 2.5%   │ 50%    │ 97.5%  │ Avg     │ Stdev   │ Min    │
├───────────┼────────┼────────┼────────┼────────┼─────────┼─────────┼────────┤
│ Req/Sec   │ 3101   │ 3101   │ 5679   │ 6199   │ 5451.44 │ 681.63  │ 3101   │
├───────────┼────────┼────────┼────────┼────────┼─────────┼─────────┼────────┤
│ Bytes/Sec │ 441 kB │ 441 kB │ 806 kB │ 880 kB │ 774 kB  │ 96.8 kB │ 440 kB │
└───────────┴────────┴────────┴────────┴────────┴─────────┴─────────┴────────┘

Req/Bytes counts sampled once per second.

164k requests in 30.05s, 23.2 MB read
```

### 10 containers

```
Running 30s test @ http://localhost:4000
30 connections

┌─────────┬──────┬──────┬───────┬───────┬─────────┬────────┬──────────┐
│ Stat    │ 2.5% │ 50%  │ 97.5% │ 99%   │ Avg     │ Stdev  │ Max      │
├─────────┼──────┼──────┼───────┼───────┼─────────┼────────┼──────────┤
│ Latency │ 1 ms │ 5 ms │ 17 ms │ 23 ms │ 5.81 ms │ 4.5 ms │ 97.56 ms │
└─────────┴──────┴──────┴───────┴───────┴─────────┴────────┴──────────┘
┌───────────┬────────┬────────┬────────┬────────┬─────────┬─────────┬────────┐
│ Stat      │ 1%     │ 2.5%   │ 50%    │ 97.5%  │ Avg     │ Stdev   │ Min    │
├───────────┼────────┼────────┼────────┼────────┼─────────┼─────────┼────────┤
│ Req/Sec   │ 2645   │ 2645   │ 5071   │ 5395   │ 4760.47 │ 660.93  │ 2644   │
├───────────┼────────┼────────┼────────┼────────┼─────────┼─────────┼────────┤
│ Bytes/Sec │ 376 kB │ 376 kB │ 720 kB │ 766 kB │ 676 kB  │ 93.9 kB │ 375 kB │
└───────────┴────────┴────────┴────────┴────────┴─────────┴─────────┴────────┘

Req/Bytes counts sampled once per second.

143k requests in 30.05s, 20.3 MB read
```
