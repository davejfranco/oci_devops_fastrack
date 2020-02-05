#Global
variable "compartment_id" {}  
#VCN variables
variable "vcn_cidr_block" { default = "192.168.1.0/24"}
variable "vcn_display_name" {}
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


