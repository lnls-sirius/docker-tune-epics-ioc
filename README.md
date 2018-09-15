Docker image to run the Noise Source Soft EPICS IOC
==================================================================

This repository contains the Dockerfile used to create the Docker image to run the
[Noise Source Soft EPICS IOC](https://github.com/lnls-dig/noise-src-epics-ioc).

## Running the IOC

The simples way to run the IOC is to run:

    docker run --rm -it --net host lnlsdig/noise-src-epics-ioc -n NOISE_GEN -c CARRIER_GEN -P PREFIX1 -R PREFIX2

where `NOISE_GEN` and `CARRIER_GEN` are the PV prefixes used, respectively,
for the Noise and Carrier Frequency generators IOCs, and `PREFIX1`
and `PREFIX2` are the prefixes to be added before the PV name.
The options you can specify (after `lnlsdig/noise-src-epics-ioc`) are:

- `-n NOISE_GEN`: PV prefix of the Noise Generator IOC (required)
- `-c CARRIER_GEN`: PV prefix of the Carrier Frequency Generator IOC (required)
- `-P PREFIX1`: the value of the EPICS `$(P)` macro used to prefix the PV names
- `-R PREFIX2`: the value of the EPICS `$(R)` macro used to prefix the PV names
- `-t TELNET_PORT`: the telnet port used to access the IOC shell

## Creating a Persistent Container

If you want to create a persistent container to run the IOC, you can run a
command similar to:

    docker run -it --net host --restart always --name CONTAINER_NAME lnlsdig/noise-src-epics-ioc -n NOISE_GEN -c CARRIER_GEN -P PREFIX1 -R PREFIX2

where `NOISE_GEN`, `CARRIER_GEN`, `PREFIX1`, and `PREFIX2` are as in the previous
section and `CONTAINER_NAME` is the name given to the container. You can also use
the same options as described in the previous section.

## Building the Image Manually

To build the image locally without downloading it from Docker Hub, clone the
repository and run the `docker build` command:

    git clone https://github.com/lnls-dig/docker-noise-src-epics-ioc
    docker build -t lnlsdig/noise-src-epics-ioc docker-noise-src-epics-ioc
