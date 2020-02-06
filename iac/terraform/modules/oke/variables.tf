#Cluster vars
variable "compartment_id" {}
variable "k8s_version" {type  = string }
variable "vcn_id" {}
variable "cluster_name" { default = "k8s_devops_demo"}
variable "k8s_service_subnets" { type = list(string) }
variable "is_dashboard_enabled" { default = true }
variable "is_tiller_enabled" {default = false }

#NodePool  
variable "node_image_id" { default = "ocid1.image.oc1.phx.aaaaaaaadjnj3da72bztpxinmqpih62c2woscbp6l3wjn36by2cvmdhjub6a" }
variable "ads" { default = ["dvEY:PHX-AD-1", "dvEY:PHX-AD-2", "dvEY:PHX-AD-3"] }
variable "np_node_shape" { default = "VM.Standard2.1"}
variable "np_subnet_id" {}
variable "nodes_per_net" { default = 1}
variable "np_ssh_public_key" {}