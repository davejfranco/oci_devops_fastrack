output "vcnID" {
  value = oci_core_vcn.vcn.id
}

output "igwID" {
  value = oci_core_internet_gateway.igw.id
}

output "ngwID" {
  value = oci_core_nat_gateway.ngw.id
}


output "public_subnets_ids" {
  value = oci_core_subnet.pub_subnets.*.id
}

output "private_subnets_ids" {
  value = oci_core_subnet.priv_subnets.*.id
}