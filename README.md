# free5GC Docker

This repository is a docker compose version of [free5GC](https://github.com/free5gc/free5gc) for stage 3. It's inspire by [free5gc-docker-compose](https://github.com/calee0219/free5gc-docker-compose) and also reference to [docker-free5GC](https://github.com/abousselmi/docker-free5gc).

You can change your own config in [config](./config) folder and [docker-compose.yaml](docker-compose.yaml)

## Pre-request

Due to the UPF issue, the host must using kernel `5.0.0-23-generic`. And it should contain `gtp5g` kernel module.

On you host OS:
```
git clone https://github.com/PrinzOwO/gtp5g.git
cd gtp5g
make
sudo make install
```

## NF

For my default setting.

| NF | IP | Exposed Ports | Dependencies | Dependencies URI |
|:-:|:-:|:-:|:-:|:-:|
| amf | 10.200.200.3 | 29518 | nrf | nrfUri: https://nrf:29510 |
| ausf | 10.200.200.4 | 29509 | nrf | nrfUri: https://nrf:29510 |
| n3iwf |
| nrf | 10.200.200.2 | 29510 | db | MongoDBUrl: mongodb://db:27017 |
| nssf | 10.200.200.5 | 29531 | nrf | nrfUri: https://nrf:29510gg/,<br/>nrfId: https://nrf:29510/nnrf-nfm/v1/nf-instances |
| pcf | 10.200.200.6 | 29507 | nrf | nrfUri: https://nrf:29510 |
| smf | 10.200.200.7 | 29502 | nrf, upf | nrfUri: https://nrf:29510,<br/>node_id: upf1, node_id: upf2, node_id: upf3 |
| udm | 10.200.200.8 | 29503 | nrf | nrfUri: https://nrf:29510 |
| udr | 10.200.200.9 | 29504 | nrf, db | nrfUri: https://nrf:29510,<br/>url: mongodb://db:27017 |
| upf1 | 10.200.200.101 | N/A | pfcp, gtpu, apn | pfcp: upf1, gtpu: upf1, apn: internet |
| upf2 | 10.200.200.103 | N/A | pfcp, gtpu, apn | pfcp: upf2, gtpu: upf2, apn: internet |
| upfb (ulcl) | 10.200.200.102 | N/A | pfcp, gtpu, apn | pfcp: upfb, gtpu: upfb, apn: intranet |
