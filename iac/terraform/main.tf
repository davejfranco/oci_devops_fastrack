/* provider "oci" {
    tenancy_ocid = var.tenancy_ocid
    user_ocid = var.user_ocid
    fingerprint = var.fingerprint
    private_key_path = var.private_key_path
    region = var.region
} */
provider "oci" {
  region = var.region
  
}


data "oci_containerengine_cluster_option" "k8s_latest" {
    #Required
    cluster_option_id = "all"
}


/* module "Network" {
    source = "./modules/network"
    
    compartment_id = var.compartment_idS
    vcn_display_name = "devops_fasttrack_vcn"
}

module "OKE" {
    source = "./modules/oke"

    compartment_id = var.compartment_id
    k8s_version = data.oci_containerengine_cluster_option.k8s_latest.kubernetes_versions[1]
    vcn_id = module.Network.vcnID
    k8s_service_subnets = [module.Network.public_subnets_ids[0]]
    np_subnet_id = module.Network.public_subnets_ids[1]
    np_ssh_public_key = file(var.ssh_key_location)
} */





