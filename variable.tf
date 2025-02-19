 variable "project" {
   default = "csye6225tarundev"
 }

 variable "credentials_file" {
   default = "credentials.json"
 }

 variable "region" {
    type = string
   default = "us-central1"
   description = "value of the region"
 }

 variable "zone" {
   default = "us-central1-a"
 }

 variable "os_image" {
   default = "cos-cloud/cos-stable"
 }

variable "network" {
  default = "csye6225-network"
}

variable "subnetwork_webapp" {
  default = "webapp-subnetwork-1"
}

variable "subnetwork_db" {
  default = "db-subnetwork-1"
}

variable "route_hop" {
  default = "network-route-1"
}

variable "vmInstance" {
  default = "csye6225-terraform-instance"
}

variable "vpc_routing_mode" {
  default = "REGIONAL"
}

variable "vpc_auto_create_subnetworks" {
  default = "false"
}

variable "vpc_delete_default_routes_on_create" {
  default = "true"
}

variable "webapp_subnetwork_ip_cidr_range" {
  default = "10.20.0.0/24"
}

variable "db_subnetwork_ip_cidr_range" {
  default = "10.20.1.0/24"
}

variable "dest_range_route" {
  default = "0.0.0.0/0"
}

variable "next_hop_gateway_route" {
  default = "default-internet-gateway"
  
}

variable "vpc_region" {
  default = "us-central1"
}

variable "sourse_range_firewall" {
  default = "0.0.0.0/0"
}

variable "allow_port_3000_name" {
  default = "allow-port-3000"
}

variable "allow_port_5432_name" {
  default = "allow-port-5432"
}

variable "deny_port_22_name" {
  default = "deny-port-22"
}

variable "allow_port_3000" {
  default = "3000"
}

variable "allow_port_5432" {
  default = "5432"
}

variable "allow_tcp_port_protocol" {
  default = "tcp"
}


variable "deny_port_22" {
  default = "22"
}

variable "webapp_vm_name" {
  default = "webapp-instance-csye6225"
}

variable "machine_type" {
  default = "e2-standard-2"
  
}

variable "base_image_name" {
  default = "csye6225-image-a8"
}


variable "base_image_type" {
  default = "pd-balanced"
}


variable "boot_disk_size" {
  default = "100"
}

variable "allow_postgres" {
  default = "postgrestag"
}

variable "global_address_name" {
  default = "global-psconnect-ip-2"
}

variable "global_address_purpose" {
  default = "VPC_PEERING"
}


variable "global_address_network_tier" {
  default = "PREMIUM"
}

variable "global_address_address" {
  default = "10.193.0.0"
}

variable "global_forwarding_rule_name" {
  default = "globalrule"
}

variable "target_global_forwarding_rule" {
  default = "all-apis"
}

variable "load_balancing_scheme" {
  default = ""
}

variable "webapp_DB_Name" {
  default = "webapp"
}

variable "webapp_USER_Name" {
  default = "webapp"
}

variable "firewall_rules_policy"  {
  type = list(object({
    rule_type     = string
    name          = string
    port_protocol = string
    port          = number
    source_range  = string
  }))
  default = [ {
    rule_type     = "allow"
    name          = "allow-port-3000"
    port_protocol = "tcp"
    port          = 3000
    source_range  = "0.0.0.0/0"
  },
  {
    rule_type     = "deny"
    name          = "deny-port-22"
    port_protocol = "tcp"
    port          = 22
    source_range  = "0.0.0.0/0"
  }]
}

variable "firewall_policy_to_apply_name" {
  type = list(string)
  default =[ "allow-port-3000", "deny-port-22","load-balancer-backend"]
  
}

variable "allow" {
  default = "allow"
}

variable "deny" {
  default = "deny"
}

variable "service_account_email" {
  default = "738558818349-compute@developer.gserviceaccount.com"
}
variable "service_account_scopes" {
  type = list(string)
  default = ["https://www.googleapis.com/auth/devstorage.read_only", "https://www.googleapis.com/auth/logging.write", "https://www.googleapis.com/auth/monitoring.write", "https://www.googleapis.com/auth/service.management.readonly", "https://www.googleapis.com/auth/servicecontrol", "https://www.googleapis.com/auth/trace.append"]
}

variable "service_account_scopes_csye_vm" {
  type = list(string)
  default = ["logging-write", "monitoring", "monitoring-read", "monitoring-write","cloud-kms-admin"]
}
variable "vpc_network_list" {
  type = list(string)
  default = ["csye6225-network-08"]
}

variable "database_version" {
  default = "MYSQL_8_0"
}

variable "database_tier" {
  default = "db-n1-standard-1"
}

variable "database_edition" {
  default = "ENTERPRISE"
}

variable "database_disk_autoresize"{
  type = bool
  default = false
}

variable "database_disk_size" {
  type = number
  default = 100
}

variable "database_disk_type" {
  type = string
  default = "PD_SSD"
}

variable "database_availability_type" {
  default = "REGIONAL"
  
}

variable "global_address_type" {
  default = "INTERNAL"
  
}

variable "private_vpc_connection_service" {
  default = "servicenetworking.googleapis.com"
}

variable "metadata_startup_script" {
  default = "metadata_script.tpl"
  
}

variable "dns_record_type" {
  default = "A"
}

variable "dns_record_zone" {
  default = "csye-6225-zone"
}

variable "dns_record_set_name" {
  default = "tarunsankhla.me."
}

variable "webapp_domain_name" {
  default = "tarunsankhla.me"
  
}

variable "dns_record_set_ttl" {
  default = "60"
}

variable "service_account_scopes_logging" {
  type = list(string)
  default = ["logging-write","monitoring-read","monitoring-write","cloud-platform"]

}

variable "csye_service_account_logging_role" {
  default = "roles/logging.admin"
}

variable "csye_service_account_metric_writer_role" {
  default = "roles/monitoring.metricWriter"
}

variable "google_service_account_name" {
  default = "webapp-service-account"
}

variable "deletion_policy" {
  default = "ABANDON"
  
}

variable "serverless_connector_name" {
  default = "serverless-connector-1"

}

variable "pubsub_role" {
  default = "roles/pubsub.publisher"  
}

variable "pubsub_role_subscriber" {
  default = "roles/pubsub.subscriber"

}

variable "abandon_deletion_policy" {
  default = "ABANDON"
}

variable "topic_name" {
  default = "verify_email"
}

variable "google_pubsub_subscription_iam_binding_members" {
  type = list(string)
  default = ["allUsers"]  
}

variable "google_pubsub_subscription_name" {
  default = "cloud_function_subscription"

}

variable "google_storage_bucket_location" {
  default = "us-central1"
}
 
variable "google_storage_bucket_object_name" {
  default = "serverless-bucket"
}

variable "google_storage_bucket_object_source" {
  default = "./serverless.zip"
}

variable "google_compute_subnetwork_name" {
  default = "vpc-connector-webapp"

}

variable "google_compute_subnetwork_ip_cidr_range" {
  default = "10.2.0.0/28"

}

variable "google_project_service_name" {
  default = "vpcaccess.googleapis.com"

}

variable "google_vpc_access_connector_ip_cidr_range" {
  default = "10.8.0.0/28"

}

variable "google_vpc_access_connector_min_instances" {
  default = 2
}

variable "google_vpc_access_connector_max_instances" {
  default = 3 
}

variable "google_vpc_access_connector_machine_type" {
  default = "f1-micro"
}

variable "google_cloudfunctions2_function_name" {
  default = "cloud-funcation-process-new-user-message"
}

variable "google_cloudfunctions2_function" {
  default = "Process new user messages from Pub/Sub"
}

variable "google_cloudfunctions2_runtime" {
  default = "nodejs18"
}

variable "google_cloudfunctions2_function_entry_point" {
  default = "processNewUserMessage"
}

variable "google_cloudfunctions2_function_service_config_availability" {
  default = "256M"
}

variable "google_cloudfunctions2_function_service_config_SERVICE_CONFIG_TEST" {
  default = "config_test"
}

variable "google_cloudfunctions2_function_event_trigger_event_type" {
  default = "google.cloud.pubsub.topic.v1.messagePublished"
}

variable "google_cloudfunctions2_function_event_trigger_retry_policy" {
  default = "RETRY_POLICY_RETRY"
}

variable "DB_USER" {
  default = "webapp"
}

variable "google_pubsub_subscription_message_retention_duration" {
  default = "604800s"
}

variable "google_pubsub_subscription_expiration_policy_ttl" {
  default = "604800s"

}


variable "webapp_vm_instance_template_name" {
  default = "webapp-vm-instance-template"
}

variable "webapp_instance_group_manager_name" {
  default = "webapp-instance-group-manager-1"
}

variable "webapp_base_instance_name" {
  default = "webapp-instance" 
}

variable "google_compute_instance_group_manager_named_ports_name" {
  default = "http"
  
}

variable "google_compute_instance_group_manager_named_ports_port" {
  default = 3000
  
}

variable "instance_group_autohealing_policy_initial_delay_sec" {
  default = 60
  
}

variable "google_compute_managed_ssl_certificate_name" {
  default = "webapp-ssl-cert"
}

variable "webapp_firewall_allow_health_check_name" {
  default = "webapp-firewall-allow-health-check"
}

variable "webapp_firewall_allow_health_check_protocol" {
  default = "tcp"
}

variable "webapp_firewall_allow_health_check_direction" {
  default = "INGRESS" 
}

variable "webapp_instance_tags" {
  default =  ["allow-health-check","load-balancer-backend","http-server","https-server"]
}

variable "google_compute_health_check_name" {
  default = "webapp-health-check"
}

variable "http_health_check_path" {
  default = "/healthz"
  
}

variable "http_health_check_port" {
  default = 3000
  
}


variable "http_health_check_port_specification"{
  default = "USE_FIXED_PORT"
}


variable "http_health_check_proxy_header"{ 
  default = "NONE"
  
}

variable "webapp_autoscaler_name" {
 default = "webapp-autoscaler" 
}

variable "google_compute_region_autoscaler_max_replicas" {
  default = 3
}

variable "google_compute_region_autoscaler_min_replicas" {
  default = 1
}

variable "google_compute_region_autoscaler_cool_down_period_sec" {
  default = 60  
}

variable "google_compute_region_autoscaler_cpu_utilization_target" {
  default = 0.05 
}

variable "google_compute_region_instance_group_manager_target" {
  default =1
  
}

variable "google_compute_subnetwork_private_ip_google_access" {
  default = true
  
}

variable "webapp_sql_instance_deletion_protection" {
  default = false
}

variable "google_sql_database_instance_ip_config_ipv4_enabled" {
  default = false
  
}

variable "google_sql_database_instance_backup_configuration_log_enabled" {
  default = true
  
}

variable "google_sql_database_instance_backup_configuration_binary_log_enabled" {
  default = true
}

variable "google_pubsub_subscription_ack_deadline" {
  default = 10
  
}

variable "google_storage_bucket_uniform_bucket_level_access" {
  default = true
  
}

variable "google_cloudfunctions2_function_service_config_min_instances" {
  default = 1
  
}

variable "google_cloudfunctions2_function_service_config_timeout" {
  default = 60
  
}

variable "google_compute_firewall_source_ranges" {
  default = ["130.211.0.0/22", "35.191.0.0/16"]
  
}

variable "google_compute_firewall_target_tags" {
  default = ["allow-health-check","load-balancer-backend"]
  
}

variable "google_compute_backend_service_name" {
  default = "webapp-backend-service"
}

variable "google_compute_backend_service_protocol" {
  default = "HTTP"
  
}

variable "google_compute_backend_service_port_name" {
  default = "http"
}

variable "google_compute_backend_service_load_balancing_scheme" {
  default = "EXTERNAL_MANAGED"
}

variable "google_compute_backend_service_timeout_sec" {
  default = 20
}

variable "google_compute_backend_service_session_affinity" {
  default = "NONE"
}

variable "google_compute_backend_service_backend_balancing_mode" {
  default = "UTILIZATION"
  
}


variable "google_compute_backend_service_capacity_scaler" {
  default = 1.0
  
}

variable "google_compute_backend_service_log_enabled" {
  default = true
  
}

variable "google_compute_backend_service_log_sample_rate" {
  default = 1
}

variable "webapp_url_map_name" {
  default =  "webapp-url-map"
}

variable "google_compute_target_https_proxy_name" {
  default = "webapp-target-https-proxy"
  
}


variable "google_compute_global_forwarding_rule_name" {
  default = "webapp-forwarding-rule"
}

variable "google_compute_global_forwarding_rule_ip_protocol" {
  default = "TCP"
  
}

variable "google_compute_global_forwarding_rule_load_balancing_scheme" {
  default = "EXTERNAL_MANAGED"

} 

variable "google_compute_global_forwarding_rule_port_range" {
  default = "443"
}

variable "random_password_length" {
  default = 16
  
}

variable "random_password_special" {
  default = false
  
}

variable "random_password_override_special" {
  default = "!#$%&*()-_=+[]{}<>:?"
  
}

variable "random_id_instance_id" {
  default = 8
}

variable "google_compute_region_instance_template_auto_delete" {
  default = true
}

variable "webapp_keyring_name" {
  default = "keyring-webapp"
  type = string
}

variable "webapp_key_name" {
  default = "webapp-key"
  type = string
}

variable "sql_instance_key_name" {
  default = "sql-instance-key"
  type = string
}

variable "bucket_storage_key_name" {
  default = "bucket-storage-key"
  type = string
}

variable "rotation_period_key" {
  default = "2592000s"
  type = string
  
}

variable "lifecycle_prevent_destroy" {
  default = true
  type = bool
}

variable "role_cryptoKeyEncrypterDecrypter" {
  default = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  type = string
}

variable "computer_system_service_account" {
  default = "service-738558818349@compute-system.iam.gserviceaccount.com"
  type = string
  
}

variable "csye_gservice_account" {
  default = "webapp-service-account@csye6225tarundev.iam.gserviceaccount.com"
  type = string
  
}

variable "role_cloudkms_admin" {
  default = "roles/cloudkms.admin"
  type = string
}

variable "kms_crypto_key_purpose" {
  default = "ENCRYPT_DECRYPT"
  type = string
  
}

variable "prevent_destroy" {
  default = false
  type = bool
  
}

variable "sql_service_account" {
  default = "sqladmin.googleapis.com"
  type = string
  
}

variable "google_compute_health_check_check_interval_sec" {
  default = 60
}

variable "google_compute_health_check_timeout_sec" {
  default = 60
}
