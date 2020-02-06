#Network Resources
/*
data "oci_identity_availability_domains" "ads" {
  compartment_id = var.tenancy_ocid
}
*/

#Virtual Network
resource "oci_core_vcn" "vcn" {
    #Required
    cidr_block = var.vcn_cidr_block
    compartment_id = var.compartment_id

    #Optional
    display_name = var.vcn_display_name
}

#Public Access
#Internet Gateway
resource "oci_core_internet_gateway" "igw" {
    #Required
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.vcn.id

    #Optional
    display_name = var.igw_name

}

#Route Table
resource "oci_core_route_table" "pub_route_table" {
    #Required
    compartment_id = var.compartment_id
    route_rules {
        #Required
        network_entity_id = oci_core_internet_gateway.igw.id
        #Optional
        destination = "0.0.0.0/0"
    }
    vcn_id = oci_core_vcn.vcn.id
    #Optional
    display_name = "Public Route Table"

}

#Public Subnet
resource "oci_core_subnet" "pub_subnets" {

    count = length(var.pub_nets_cidr)
    #Required
    cidr_block = element(var.pub_nets_cidr, count.index)
    compartment_id = var.compartment_id
    security_list_ids = [oci_core_vcn.vcn.default_security_list_id]
    vcn_id = oci_core_vcn.vcn.id

    #Optional
    display_name = format("pub_subnet_%d_", count.index + 1)
    route_table_id = oci_core_route_table.pub_route_table.id
}

#Private Access
resource "oci_core_nat_gateway" "ngw" {
    #Required
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.vcn.id

    #Optional
    display_name = var.ngw_name
}


resource "oci_core_route_table" "priv_route_table" {
    #Required
    compartment_id = var.compartment_id
    route_rules {
        #Required
        network_entity_id = oci_core_nat_gateway.ngw.id
        #Optional
        destination = "0.0.0.0/0"
    }
    vcn_id = oci_core_vcn.vcn.id

    #Optional
    display_name = "Private Route Table"
}

resource "oci_core_subnet" "priv_subnets" {
    count = length(var.priv_nets_cidr)
    #Required
    cidr_block = element(var.priv_nets_cidr, count.index)
    compartment_id = var.compartment_id
    security_list_ids = [oci_core_vcn.vcn.default_security_list_id]
    vcn_id = oci_core_vcn.vcn.id

    #Optional
    prohibit_public_ip_on_vnic = true
    display_name = format("priv_subnet_%d_", count.index + 1)
    route_table_id = oci_core_route_table.priv_route_table.id

}