

resource "oci_containerengine_cluster" "k8s_cluster" {
    #Required
    compartment_id = var.compartment_id
    kubernetes_version = var.k8s_version
    name = var.cluster_name
    vcn_id = var.vcn_id

    #Optional
    options {
        #Optional
        add_ons {
            #Optional
            is_kubernetes_dashboard_enabled = var.is_dashboard_enabled
            is_tiller_enabled = var.is_tiller_enabled
        }

        service_lb_subnet_ids = var.k8s_service_subnets
    }
}

resource "oci_containerengine_node_pool" "demo_node_pool" {
    #Required
    cluster_id = oci_containerengine_cluster.k8s_cluster.id
    compartment_id = var.compartment_id
    kubernetes_version = var.k8s_version
    name = format("%s_np_1", var.cluster_name)
    node_shape = var.np_node_shape
    #subnet_ids = var.np_subnet_ids
    node_image_id = var.node_image_id
    
    node_config_details {

        dynamic "placement_configs" {
            iterator = ad
            for_each = var.ads
            content {
                availability_domain = ad.value
                subnet_id           = var.np_subnet_id
            }
    }
    
    size = var.nodes_per_net
  }
    
    ssh_public_key = var.np_ssh_public_key
}
