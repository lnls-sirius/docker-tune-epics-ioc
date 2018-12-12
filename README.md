Docker image to run the Noise Source Soft EPICS IOC
==================================================================

This repository contains the Dockerfile used to create the Docker image to run the
[Noise Source Soft EPICS IOC](https://github.com/lnls-dig/tune-epics-ioc).

## Running the IOC

The simples way to run the IOC is to run:

    docker run --rm -it --net host lnlsdig/tune-epics-ioc -t TELNET_PORT -d DEVICE_TYPE -n NOISE_GEN -c CARRIER_GEN -s TUNE_PROC -a AMPLIFIER -P PREFIX_AREA -R PREFIX_DEV

where `NOISE_GEN`, `CARRIEN_GEN`, `TUNE_PROC` and `AMPLIFIER`
are the PV prefixes used for the Noise Generator, Carrier
Frequency Generator, Tune Processor and Amplifier IOCs, respectively.
The options you can specify (after `lnlsdig/tune-epics-ioc`) are:

- `-t TELNET_PORT`: the telnet port used to access the IOC shell
- `-n NOISE_GEN`: PV prefix of the Noise Generator IOC (required)
- `-c CARRIER_GEN`: PV prefix of the Carrier Frequency Generator IOC (required)
- `-s TUNE_PROC`: PV prefix of the Tune Processor IOC (required)
- `-a AMPLIFIER`: PV prefix of the Amplifier IOC (required)
- `-d DEVICE_TYPE`: device type, Storage Ring (SI) or Booster (BO) (required)
- `-P PREFIX1`: the value of the EPICS `$(P)` macro used to prefix the PV names
- `-R PREFIX2`: the value of the EPICS `$(R)` macro used to prefix the PV names

## Creating a Persistent Container

If you want to create a persistent container to run the IOC, you can run a
command similar to:

    docker run -it --net host --restart always --name CONTAINER_NAME lnlsdig/tune-epics-ioc -t TELNET_PORT -d DEVICE_TYPE -n NOISE_GEN -c CARRIER_GEN -s TUNE_PROC -a AMPLIFIER -P PREFIX_AREA -R PREFIX_DEV

where `NOISE_GEN`, `CARRIEN_GEN`, `TUNE_PROC` and `AMPLIFIER` are as in the previous
section and `CONTAINER_NAME` is the name given to the container. You can also use
the same options as described in the previous section.

## Building the Image Manually

To build the image locally without downloading it from Docker Hub, clone the
repository and run the `docker build` command:

    git clone https://github.com/lnls-dig/docker-tune-epics-ioc
    docker build -t lnlsdig/tune-epics-ioc docker-tune-epics-ioc
