resource "oci_containerengine_cluster" "k8s_cluster" {
    #Required
    compartment_id = var.compartment_id
    kubernetes_version = data.oci_containerengine_cluster_option.k8s_latest.kubernetes_versions[1]
    name = var.cluster_name
    vcn_id = oci_core_vcn.vcn.id

    #Optional
    options {
        #Optional
        add_ons {
            #Optional
            is_kubernetes_dashboard_enabled = var.is_dashboard_enabled
            is_tiller_enabled = var.is_tiller_enabled
        }

        service_lb_subnet_ids = [oci_core_subnet.pub_subnets[0].id]
    }
}

resource "oci_containerengine_node_pool" "demo_node_pool" {
    #Required
    cluster_id = oci_containerengine_cluster.k8s_cluster.id
    compartment_id = var.compartment_id
    kubernetes_version = data.oci_containerengine_cluster_option.k8s_latest.kubernetes_versions[1]
    name = format("%s_np_1", var.cluster_name)
    node_shape = var.np_node_shape
    node_image_id = var.node_image_id
    
    node_config_details {

        dynamic "placement_configs" {
            iterator = ad
            for_each = var.ads
            content {
                availability_domain = ad.value
                subnet_id           = oci_core_subnet.pub_subnets[1].id
            }
    }
    
    size = var.nodes_per_net
  }
    
    ssh_public_key = file(var.ssh_key_location)
}
