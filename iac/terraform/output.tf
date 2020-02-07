output "vcnID" {
  value = oci_core_vcn.vcn.id
}

output "k8sID" {
  value = oci_containerengine_cluster.k8s_cluster.id
}
