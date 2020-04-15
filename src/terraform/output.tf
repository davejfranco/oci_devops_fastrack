output "vcnID" {
  value = oci_core_vcn.vcn.id
}

output "k8sID" {
  value = oci_containerengine_cluster.k8s_cluster.id
}

# Output the result
/* output "adnames" {
  value = data.oci_identity_availability_domains.ads.availability_domains.*.name
} */