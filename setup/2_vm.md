# VM workshop

In this tutorial we are lunching a VM to use it during the execution of this workshop.

## 1. VM creation

Locate the menu in the top left, click and then click again in "Compute" then select "Instances".

![console](/img/setup/compute.jpg)

Click in the "Create Instance" button and fill the details.

![serverName](/img/setup/vm_name.jpg)

In the "Virtual cloud network compartment" make sure you slect the compartment used int he previous section.

![net](/img/setup/vcnypublicip.jpg)

Also make sure you select a subnet type public and "Assign a public IP" so we can access the VM later on.

![ssh](/img/setup/sshkey.jpg)

Select your ssh public key or we can just paste its content and the click "Create".

Note: There is a keypair already in the ssh directory within this section.

Once the instance is in green state, lets test connection.

```shell
ssh -i <ssh location >/id_rsa opc@<public ip>
```

Next lets install git.

```shell
sudo yum install -y git
```

## 2. Download workshop source code

Now the we have git, lets clone the workshop repository.

```shell
git clone https://github.com/davejfranco/oci_devops_fastrack.git
```

Once the repo was downloaded, move the setup directory and execute the setup.sh script.

```shell
cd oci_devops_fastrack/setup && chmod +x setup.sh && ./setup.sh
```

This will install docker and kubectl we will need in other labs.

now we are ready to start this workshop.