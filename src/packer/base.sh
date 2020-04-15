#!/bin/bash

set -x

sudo su <<Here
#Update
yum update -y

#Update Motd with custom message
yes | cp /tmp/motd /etc/motd
Here
