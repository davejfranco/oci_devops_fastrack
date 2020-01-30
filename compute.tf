# #Autoscaling Resources
# resource "oci_core_instance_configuration" "ic" {
#     compartment_id = var.compartment_id
#     display_name   = "VM-demo-ic"
#     instance_details {
#         instance_type = "compute"
        
#         launch_details {
#             compartment_id = var.compartment_id
#             shape          = "VM.Standard2.1"
#             display_name   = "demoVM"
#             create_vnic_details {
#                 assign_public_ip       = true
#                 display_name           = "demo_ic_vnic"
#                 skip_source_dest_check = false
#             }
            

#             source_details { 
#                 source_type = "image" 
#                 image_id  = var.vmImgID
#             }

#             metadata = {
#                 ssh_authorized_keys = file(var.ssh_public_key)

#             }

#         }
#     }

# }

# resource "oci_core_instance_pool" "ipool" {
#   compartment_id            = var.compartment_id
#   instance_configuration_id = oci_core_instance_configuration.ic.id
#   size                      = 2
#   state                     = "RUNNING"
#   display_name              = "ipool-demo"

#   placement_configurations {
#     availability_domain = var.availability_domain
#     primary_subnet_id   = oci_core_subnet.pub_subnet.id
#   }

#   load_balancers  {
#     backend_set_name = oci_load_balancer_backend_set.lb-bset.name
#     load_balancer_id = oci_load_balancer.lb.id
#     port             = 80
#     vnic_selection   = "primaryvnic"
#   }
# }

# resource "oci_autoscaling_auto_scaling_configuration" "scalingConf" {
#     compartment_id       = var.compartment_id
#     cool_down_in_seconds = "300"
#     display_name         = "demo_scaling"
#     is_enabled           = "true"
#     policies {
#         display_name = "demo_policy"
#         policy_type  = "threshold"
#         capacity {
#             initial = "1"
#             max     = "4"
#             min     = "1"
#         }
    
#         rules {
#             display_name = "demo_rule_out"
#             action {
#                 type  = "CHANGE_COUNT_BY"
#                 value = "1"
#             }
        
#             metric {
#                 metric_type = "CPU_UTILIZATION"
#                 threshold {
#                     operator = "GT"
#                     value    = "80"
#                 }
#             }
#         }

#         rules {
#             display_name = "demo_rule_in"
#             action {
#                 type  = "CHANGE_COUNT_BY"
#                 value = "-1"
#             }
        
#             metric {
#                 metric_type = "CPU_UTILIZATION"
#                 threshold {
#                     operator = "LT"
#                     value    = "40"
#                 }
#             }
#         }
#     }

#     auto_scaling_resources {
#         id   = oci_core_instance_pool.ipool.id
#         type = "instancePool"
#     }
# }