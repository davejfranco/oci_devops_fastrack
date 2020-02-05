#!/bin/bash

set -e

#Update and install basics
sudo yum update -y 

#Update Motd with custom message
yes | sudo cp /tmp/motd /etc/motd

