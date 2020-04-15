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

data "oci_identity_availability_domains" "ads" {
  compartment_id = var.compartment_id
}


