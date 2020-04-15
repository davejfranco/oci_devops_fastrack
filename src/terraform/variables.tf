/* variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {} */

#Change me according to your tenant
variable "region" { default = "" }
variable "compartment_id" {
    default = ""
}
variable "node_image_id" { 
    default = "" 
}

#Network
variable "vcn_cidr_block" { default = "192.168.1.0/24"}
variable "vcn_display_name" { default = "demoVCN" }
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
variable "np_node_shape" { default = "VM.Standard2.1"}
variable "nodes_per_net" { default = 1}