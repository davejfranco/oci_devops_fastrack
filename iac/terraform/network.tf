
#Virtual Network
resource "oci_core_vcn" "vcn" {
    #Required
    cidr_block = var.vcn_cidr
    compartment_id = var.compartment_id

    #Optional
    display_name = "demo_vcn"

}

#Public Access
#Internet Gateway
resource "oci_core_internet_gateway" "igw" {
    #Required
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.vcn.id

    #Optional
    display_name = "igw"
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

resource "oci_core_security_list" "web_sec_list" {
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.vcn.id
    display_name = "web_sec_list"


    ingress_security_rules {
        source = "0.0.0.0/0"
        protocol = "6"
        tcp_options {
            min = "80"
            max = "80"
        }
    }
}
#Public Subnets
resource "oci_core_subnet" "pub_subnet" {
    #Required
    cidr_block = var.pub_cidr
    compartment_id = var.compartment_id
    security_list_ids = [oci_core_vcn.vcn.default_security_list_id, oci_core_security_list.web_sec_list.id]
    vcn_id = oci_core_vcn.vcn.id

    #Optional
    display_name = "Public Subnet"
    route_table_id = oci_core_route_table.pub_route_table.id
}

#Private Access
resource "oci_core_nat_gateway" "ngw" {
    #Required
    compartment_id = var.compartment_id
    vcn_id = oci_core_vcn.vcn.id

    #Optional
    display_name = "ngw"

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

resource "oci_core_subnet" "priv_subnet" {
    #Required
    cidr_block = var.priv_cidr
    compartment_id = var.compartment_id
    security_list_ids = [oci_core_vcn.vcn.default_security_list_id, oci_core_security_list.web_sec_list.id]
    vcn_id = oci_core_vcn.vcn.id

    #Optional
    prohibit_public_ip_on_vnic = true
    display_name = "Private Subnet"
    route_table_id = oci_core_route_table.priv_route_table.id
}

#LoadBalancer Resources
resource "oci_load_balancer" "lb" { 
    shape = "100Mbps" 
    compartment_id = var.compartment_id
    subnet_ids = [oci_core_subnet.pub_subnet.id]
    is_private = false 
    display_name = "demo-lb" 
}

resource "oci_load_balancer_backend_set" "lb-bset" {
    name = "lb-demo" 
    load_balancer_id = oci_load_balancer.lb.id
    policy = "ROUND_ROBIN"

    health_checker { 
        port = "80" 
        protocol = "HTTP" 
        response_body_regex = ".*" 
        url_path = "/" 
    } 
}

resource "oci_load_balancer_listener" "lb-listener" { 
    load_balancer_id = oci_load_balancer.lb.id
    name = "http" 
    default_backend_set_name = oci_load_balancer_backend_set.lb-bset.name
    port = 80 
    protocol = "HTTP"
    connection_configuration { idle_timeout_in_seconds = "2" } 
}



