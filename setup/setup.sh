#!/bin/bash

set -x

sudo su <<Here
#Install Docker

echo "Install docker"
yum install -y docker-engine

#Enable docker
systemctl enable docker && systemctl start docker

#Allow user to execute docker
usermod -aG docker opc

#Install terraform
echo "Install Terraform"
wget https://releases.hashicorp.com/terraform/0.13.3/terraform_0.13.3_linux_amd64.zip
unzip terraform_0.13.3_linux_amd64.zip
mv terraform /usr/local/bin

#Install packer
#echo "Install Packer"
#wget https://releases.hashicorp.com/packer/1.5.4/packer_1.5.4_linux_amd64.zip
#unzip packer_1.5.4_linux_amd64.zip 
#mv packer /usr/local/bin

#Install kubectl
echo "Install kubectl"
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
yum install -y kubectl

Here