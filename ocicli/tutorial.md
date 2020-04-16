# Oracle Command Line Interface Tool 

In this Lab we will interact with the oci-cli tool, for this you will have two options either throught installing the oci-cli tool on your machine or in a VM on the same OCI account as its describe in the "setup" section of this workshop respository; you will find the instructions following this [link](./ocicli_install.md) or using the Oracle Cloud Shell which you can find the instrucction next to this intro.

## Oracle Cloud Shell

Oracle Cloud Infrastructure Cloud (OCI) Shell is a web browser-based terminal accessible from the Oracle Cloud Console Cloud Shell is free to use (within monthly tenancy limits), and provides access to a Linux shell, with a pre-authenticated Oracle Cloud Infrastructure CLI and other useful tools. You can see more details following this [link](https://docs.cloud.oracle.com/en-us/iaas/Content/API/Concepts/cloudshellintro.htm).

## Oci-cli

The CLI is a small footprint tool that you can use on its own or with the Console to complete Oracle Cloud Infrastructure tasks. The CLI provides the same core functionality as the Console, plus additional commands. Some of these, such as the ability to run scripts, extend the Console's functionality. 

## Prerequisites 

To make use of Oracle cloud shell the first thing to have is a valid Oracle Cloud account and the required access to this service. For more information please visit the following [link](https://docs.cloud.oracle.com/en-us/iaas/Content/API/Concepts/cloudshellintro.htm) and navigate to the "Required IAM Policy" section. 

## Instructions

Locate the cloud shell icon in the upper right side of the home. Left click an that's it! 

![cloudshell](/src/img/ocicli/cloudshell.jpg)

Once we have our cloud shell loaded up the first thing we will do is to type ```help``` and it will display useful information about what cloud shell includes, limitations and how to copy paste if your using windows or Mac.

![cloud_shell](/src/img/ocicli/cloudshell_help.jpg)

One of the advantage of using cloud shell is that the oci-cli is already setup and ready to use, but if you need to use oci-cli outside cloudshell you'll have to follow the steps on this [link](ocicli_install.md) to install and configure it.

Additionally includes the following tools.

- Git
- Java 
- Python (2 and 3)
- SQL Plus
- kubectl
- helm
- maven
- gradle
- terraform
- ansible

So your good to go. Please go to the [next](./ocicli_ops.md) step of this workshop.

To install anc configure oci-cli tool follow this [tutorial](./ocicli_install.md) (Optional)