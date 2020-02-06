
variable "tenancy_ocid" {}
variable "user_ocid" {}
variable "fingerprint" {}
variable "private_key_path" {}

variable "region" {}

#Network
variable "compartment_id" {
    default = "ocid1.compartment.oc1..aaaaaaaav6pdooaarurousblty4koterxpcyu3llelogqqueunopmii4j7lq"
}

variable "vmImgID" { default = "ocid1.image.oc1.phx.aaaaaaaatrfqygi3lwy3xjqhfgqhxxoas73ewa2edg27pu3w62m2achojt7a"}

variable "availability_domain" { default = "dvEY:PHX-AD-1"}
variable "ssh_public_key" { default = "~/.ssh/id_rsa.pub" }
