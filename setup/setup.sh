#!/bin/bash

set -x

sudo su <<Here
#Update
yum update -y

#Install Docker
yum install -y docker-engine

#Enable docker
systemctl enable docker && systemctl start docker

#Allow user to execute docker
usermod -aG docker opc

#Install terraform
wget https://releases.hashicorp.com/terraform/0.12.20/terraform_0.12.20_linux_amd64.zip
unzip terraform/0.12.20/terraform_0.12.20_linux_amd64.zip
mv terraform /usr/local/bin

#Install kubectl
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