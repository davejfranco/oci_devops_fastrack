# Create a virtual netowork

In this tutorial we are going to create a new virtual netowork to later create or compute resource to execute this workshop.

## Pre-requesites 

- Cuenta Oracle Cloud.

## Instructions

To get to the network service, left click in the button located in the top left of the home page, a menu will display on scroll down to "Networking" and left click again in "Virtual Cloud Networks"

![vcn_location](/img/setup/vcn_location.jpg)

Next thing, lef click in "Networking Quickstart" button.

![vcnquick](/img/setup/net_quick.jpg)

Make sure "VCN with Internet Connectivity" is selected a then left click in "Star Workflow button".

![workflow](/img/setup/vcn_option.jpg)

Fill the details with the following info.

vcn name: "demovcn"
vcn cidr block: 172.16.0.0/16
public subnet cidr block: 172.16.1.0/24
private subnet cidr block: 172.16.2.0/24

Note: In the compartment section you can use either the root compartment or any other of your preference as this resources will be temporary to execute the workshop.

![vcn fill](/img/setup/vcn_detail.jpg)

Click Next button at the bottom of the screen. You will get a review of all the resources that will be created; left click in "Create".

![create](/img/setup/vcn_review.jpg)

and you're ready!!

