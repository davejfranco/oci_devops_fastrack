
# variable "tenancy_ocid" {}
# variable "user_ocid" {}
# variable "fingerprint" {}
# variable "private_key_path" {}
#Global
variable "region" { default = "us-phoenix-1" }

#Network
variable "compartment_id" {
    default = "ocid1.compartment.oc1..aaaaaaaav6pdooaarurousblty4koterxpcyu3llelogqqueunopmii4j7lq"
}

variable "vmImgID" { default = "ocid1.image.oc1.phx.aaaaaaaatrfqygi3lwy3xjqhfgqhxxoas73ewa2edg27pu3w62m2achojt7a"}

variable "availability_domain" { default = "dvEY:PHX-AD-1"}
variable "ssh_key_location" { default = "id_rsa.pub" }

#Network
variable "vcn_cidr_block" { default = "192.168.1.0/24"}
variable "vcn_display_name" { default = "devops_fasttrack_vcn" }
variable "igw_name" { default = "igw" }
variable "pub_nets_cidr" { 
    type = list(string)
    default = ["192.168.1.0/27", "192.168.1.32/27"]    
}
variable "priv_nets_cidr" { 
    type = list(string)
    default = ["192.168.1.64/27", "192.168.1.96/27"]    
}
variable "ngw_name" { default = "ngw" }

#OKE
#Cluster vars
#variable "k8s_version" {type  = string }
variable "cluster_name" { default = "k8s_devops_demo"}

variable "is_dashboard_enabled" { default = true }
variable "is_tiller_enabled" {default = false }

#NodePool  
variable "node_image_id" { default = "ocid1.image.oc1.phx.aaaaaaaadjnj3da72bztpxinmqpih62c2woscbp6l3wjn36by2cvmdhjub6a" }
variable "ads" { default = ["dvEY:PHX-AD-1", "dvEY:PHX-AD-2", "dvEY:PHX-AD-3"] }
variable "np_node_shape" { default = "VM.Standard2.1"}

variable "nodes_per_net" { default = 1}
variable "np_ssh_public_key" { default = "~/.ssh/authorized_keys" }