Pivxd for Docker
================

[![Docker Stats](http://dockeri.co/image/yannik95/pivxd)](https://hub.docker.com/r/yannik95/pivxd/)

Docker image that runs the Pivx pivxd node in a container for easy deployment.


Requirements
------------

* Physical machine, cloud instance, or VPS that supports Docker (i.e. Vultr, Digital Ocean, KVM or XEN based VMs) running Ubuntu 14.04 or later (*not OpenVZ containers!*)
* At least 4 GB to store the block chain files
* At least 1 GB RAM + 2 GB swap file

Recommended and tested on Vultr 1024 MB RAM/320 GB disk instance @ $8/mo.  Vultr also *accepts Bitcoin payments*!  May run on the 512 MB instance, but took *forever* (1+ week) to initialize due to swap and disk thrashing.


Really Fast Quick Start
-----------------------

One liner for Ubuntu 14.04 LTS machines with JSON-RPC enabled on localhost and adds upstart init script:

    curl https://raw.githubusercontent.com/yannik995/docker-pivxd/master/bootstrap-host.sh | sh -s trusty


Quick Start
-----------

1. Create a `pivxd-data` volume to persist the pivxd blockchain data, should exit immediately.  The `pivx-data` container will store the blockchain when the node container is recreated (software upgrade, reboot, etc):

        docker volume create --name=pivx-data
        docker run -v pivx-data:/pivx --name=pivxd-node -d \
            -p 51472:51472 \
            -p 127.0.0.1:51473:51473 \
            yannik95/pivxd

2. Verify that the container is running and pivxd node is downloading the blockchain

        $ docker ps
        CONTAINER ID        IMAGE                         COMMAND             CREATED             STATUS              PORTS                                              NAMES
        d0e1076b2dca        dashpay/dashd:latest          "dash_oneshot"      2 seconds ago       Up 1 seconds        127.0.0.1:9998->9998/tcp, 0.0.0.0:9999->9999/tcp   dashd-node

3. You can then access the daemon's output thanks to the [docker logs command]( https://docs.docker.com/reference/commandline/cli/#logs)

        docker logs -f pivxd-node

4. Install optional init scripts for upstart and systemd are in the `init` directory.


Documentation
-------------

* To run in testnet, add environment variable `TESTNET=1` to `docker run` as such:

        docker run -v pivx-data:/pivx --name=pivxd-node -d \
            --env TESTNET=1 \
            -p 51474:51474 \
            -p 127.0.0.1:51475:51475 \
            yannik95/pivxd

* Additional documentation in the [docs folder](docs).

Credits
-------

Original work by Kyle Manna [https://github.com/kylemanna/docker-bitcoind](https://github.com/kylemanna/docker-bitcoind).
Modified by Holger Schinzel to use Dash Core instead of Bitcoin Core.
Modified to use Pivx Core instead of Bitcoin Core.

