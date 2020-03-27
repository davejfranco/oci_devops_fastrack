# DevOps Day Fasttrack

This project aims to serve as a workshop material to learn basic concepts of DevOps practice using opensource tools on Oracle Cloud Infrastructure.

## Agenda

This DevOps workshop will cover the following topics:

- Cloud Shell and Oracle Command Line Tool (oci-cli).
- Oracle Resource Manager (Terraform deployment plattform).
- Oracle Kubernetes Engine (OKE).

### Pre-requisite

In order to follow this workshop the first thing is to have an OCI account, if you don't have one you can visit https://www.oracle.com/cloud/free/ and follow the steps to complete the registration process. Once you have access to your account go to https://console.us-ashburn-1.oraclecloud.com/ where you'll be prompt to providethe name of your tenant follow by your username and password.


### 1. OCI command line tool

The "DevOps way" of doing stuff is using terminal, in this regard Oracle Cloud has two amazing tool; first is the cloud shell that allows you to have a shell on your browser with some usefull tools already installed to work on, the second one is de oci command line tool (oci-cli) which allow you to perform operation throught the terminal. In this step wil work with both to familiarize with OCI using the terminal, move to de "ocicli" directory where you can find the steps on this lab.

### 3.  Infrastructure as Code.

DevOps is all about automation which of course includes infrastructure provisioning. There are many tools that can helps us on this task but Terraform is the world most known Infrastructure as Code tool and with the convine solution such as Oracle Resource Manger we can have a centralized platform to deploy and monitor our Infrastructure lifecycle changes. 

After completing the previous step we now move to the directory called "resourcemanager" where we are going to use oci-cli tool to call Oracle Resource Manager to execute Terraform code; the idea of this lab is to understand the Infrastructure as Code concept and how easy it is to deploy resources using this solution. 

### 4. Oracle Kubernetes Engine (OKE)

Once we finished the previous lab we now move to "oke" directory. In this step we will generate a kubeconfig from a previous Oracle Kubernetes cluster created, we will learn how to connect to Oracle Container registry and how to deploy a sample aplication into our OKE. 

### Bonus

Inside the "iac" directory there are two more directories; one is the terraform code used in the "resourcemanager lab" and the other one is a lab to create a vm template using "Packer".

![keepcalm](/img/keep-calms-and-do-devops.png)





