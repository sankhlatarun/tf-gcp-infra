
resource "google_compute_region_instance_template" "webapp_vm_instance_template" {
  name          = var.webapp_vm_instance_template_name
  machine_type  = var.machine_type
  tags          = var.webapp_instance_tags
  region        = var.region
  depends_on    = [ google_sql_database_instance.webapp_sql_instance,  google_service_account.webapp_service_account, google_project_iam_binding.csye_service_account_logging, google_project_iam_binding.csye_service_account_metric_writer]
  metadata      = google_compute_project_metadata.web_metadata.metadata
  metadata_startup_script = templatefile("metadata_script.tpl", {
    DB_USER     = var.webapp_DB_Name,
    DB_PASSWORD = random_password.password.result,
    DB_HOST     = google_sql_database_instance.webapp_sql_instance.private_ip_address,
    DB_NAME     = var.webapp_DB_Name
  })
  disk {
    source_image = var.base_image_name
    auto_delete  = var.google_compute_region_instance_template_auto_delete
    disk_size_gb = var.boot_disk_size
    disk_type    = var.base_image_type
    disk_encryption_key {
      kms_key_self_link = google_kms_crypto_key.webapp_key.id
    }
  }
  network_interface {
    network    = google_compute_network.csye6225_vpc_network[0].self_link
    subnetwork = google_compute_subnetwork.webapp.self_link
    # access_config {  }
  }
  service_account {
    email  = google_service_account.webapp_service_account.email
    scopes = var.service_account_scopes_logging
  }
}


resource "google_compute_region_instance_group_manager" "webapp_instance_group_manager_1" {
  name               = var.webapp_instance_group_manager_name
  region             = var.region
  base_instance_name = var.webapp_base_instance_name
  target_size        = var.google_compute_region_instance_group_manager_target
    lifecycle {
      ignore_changes = [target_size]
    }
  version {
    instance_template = google_compute_region_instance_template.webapp_vm_instance_template.self_link
  }
  named_port {
    name = var.google_compute_instance_group_manager_named_ports_name
    port = var.google_compute_instance_group_manager_named_ports_port
  }
  auto_healing_policies {
    health_check      = google_compute_health_check.webapp_health_check.self_link
    initial_delay_sec = var.instance_group_autohealing_policy_initial_delay_sec
  }
}


resource "google_compute_health_check" "webapp_health_check" {
  name      = var.google_compute_health_check_name
  provider  = google-beta
  project   = var.project
  check_interval_sec = var.google_compute_health_check_check_interval_sec
  timeout_sec        = var.google_compute_health_check_timeout_sec

  http_health_check {
    request_path        = var.http_health_check_path
    port                = var.http_health_check_port
    port_specification  = var.http_health_check_port_specification
    proxy_header        = var.http_health_check_proxy_header
  }
}

resource "google_compute_region_autoscaler" "webapp_autoscaler" {
  name        = var.webapp_autoscaler_name
  region      = var.region
  target      = google_compute_region_instance_group_manager.webapp_instance_group_manager_1.id
  depends_on  = [ google_compute_region_instance_group_manager.webapp_instance_group_manager_1 ]
  autoscaling_policy {
    min_replicas    = var.google_compute_region_autoscaler_min_replicas
    max_replicas    = var.google_compute_region_autoscaler_max_replicas
    cooldown_period = var.google_compute_region_autoscaler_cool_down_period_sec
    cpu_utilization {
      target = var.google_compute_region_autoscaler_cpu_utilization_target
    }
  }
}

resource "google_compute_backend_service" "webapp_backend_service" {
  name                    = var.google_compute_backend_service_name
  project                 =  var.project
  provider                = google-beta
  protocol                = var.google_compute_backend_service_protocol
  port_name               = var.google_compute_backend_service_port_name
  load_balancing_scheme   = var.google_compute_backend_service_load_balancing_scheme
  timeout_sec             = var.google_compute_backend_service_timeout_sec
  health_checks           = [google_compute_health_check.webapp_health_check.id]
  session_affinity        = var.google_compute_backend_service_session_affinity
  backend {
    group           = google_compute_region_instance_group_manager.webapp_instance_group_manager_1.instance_group
    balancing_mode  = var.google_compute_backend_service_backend_balancing_mode
    capacity_scaler = var.google_compute_backend_service_capacity_scaler
  }
  log_config {
    enable      = var.google_compute_backend_service_log_enabled
    sample_rate = var.google_compute_backend_service_log_sample_rate
  }
}

resource "google_compute_url_map" "webapp_url_map" {
  name            = var.webapp_url_map_name
  provider        = google-beta
  project         = var.project
  default_service = google_compute_backend_service.webapp_backend_service.id
}
