# Track Packaging
This repository contains the resources to provision a Ubuntu 14.04(trusty) virtual machine capable of rendering tiles in the style of [OpenStreetMap.org](http://www.openstreetmap.org)

## Vagrant 
The virtual machine  is managed by [Vagrant](https://www.vagrantup.com), a tool for provisioning and managing virtual machines. The files in this repository should be used to build the machine automatically from a default image. To use the virtual machine, download the newest version of vagrant [here](https://www.vagrantup.com/downloads.html).

This vagrant repository is configured to use [VirtualBox](https://www.virtualbox.org) as a provider for the virtual machine. Currently, the newest versions of Vagrant and VirtualBox are not compatible, so you will have to install one of the [old VirtualBox builds](https://www.virtualbox.org/wiki/Download_Old_Builds_4_3) (*4.3.34 recommended*).

<br/>

## Running the VM
To run this virtual machine, you have two options: you can either run the source code from this repository to build the machine from scratch, or you can use the pre-packaged box file.

*Warning: Building the virtual machine from scratch is a long running process. We recommend using the packaged version*

If you wish to use the machine that has already been built, use the **bikelomatic.box** file currently available on the google drive account

### Vagrant Commands

To start the machine with vagrant, use the following command in the root of the repo:
```
vagrant up <machine_name>
```

<br/>

Once the machine has been provisioned, it can be accessed with the following command:
```
vagrant ssh <machine_name>
```
This allows you access to the virtual machine via the command line.

<br/>

If you need to teardown the virtual machine, use one of the following commands from the host machine:
```
vagrant halt <machine_name>
vagrant destroy -f <machine_name>
```
Running halt will gracefully power down the machine, while running destroy will forcibly remove the machine from VirtualBox

<br/>

To start a box that has been powered down, use the --no-provision flag:
```
vagrant up --no-provision <machine_name>
```
This will start the machine without attempting to run any provisioning scripts

<br/>

### Building from Source
Building the machine from source uses the **Vagrantfile** in this repository, along with the **scripts/bootstrap.sh** file
*As mentioned above, this is expected to take over 10 minutes to complete*

The name of the virtual machine when built in this repository is "bikelomatic".

<br/>

### Using the pre-packaged box
This box has already been provisioned, which allows it to be started much faster. However, because we are using this custom box, we require a few extra steps of setup.

First, you will need to register the bikelomatic box with vagrant
```
vagrant box add bikelomatic /path/to/bikelomatic.box
```
Next, we will initialize a directory to run our box
```
vagrant init bikelomatic
```
Now we are ready to run our virtual machine with
```
vagrant up default
```

<br/>

## Rendering tiles on the machine
The machine already has all of the necessary dependencies installed to render tiles. All that is required for the user is to import any .pbf files to the PostGIS database, and to run polytiles.py to generate the tile images.

Information on how to import .pbf files can be found [here](https://switch2osm.org/loading-osm-data/)

Information on polytiles.py can be found [here](https://github.com/bikelomatic-complexity/node-server/wiki/Rendering-Tiles-with-Mapnik) and [here](https://github.com/openstreetmap/mapnik-stylesheets/blob/master/README)

Once polytiles.py has finished rendering tiles, they will be placed in the /tiles directory. In order to get these tiles onto the host machine, move them from this directory to the /vagrant directory on the VM. This directory is shared between the VM and the host, which means the tiles files there will be accesible on the host machine.

These tiles can be packaged and hosted in any manner you prefer.
