provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project
  region      = var.region
  zone        = var.zone
}

data "google_project" "current" {
}
locals {
    cloud_storage_service_account = "service-${data.google_project.current.number}@gs-project-accounts.iam.gserviceaccount.com"
    //cloud_storage_service_account = "service-738558818349@gs-project-accounts.iam.gserviceaccount.com"
}

resource "google_dns_record_set" "webapp_dns_record_set" {
  name          = var.dns_record_set_name
  type          = var.dns_record_type
  ttl           = var.dns_record_set_ttl
  managed_zone  = var.dns_record_zone
  rrdatas       = [ google_compute_global_forwarding_rule.webapp_forwarding_rule.ip_address]
}
resource "google_compute_project_metadata" "web_metadata" {
  metadata = {
    "DB_NAME"       = var.webapp_DB_Name
    "DB_USER"       = var.webapp_USER_Name
    "DB_PASSWORD"   = random_password.password.result
    "DB_HOST"       = google_sql_database_instance.webapp_sql_instance.private_ip_address
  }
}

resource "google_project_service" "serverless_vpc_access" {
  service = var.google_project_service_name
}
resource "google_vpc_access_connector" "webapp_connector" {
  name                    = var.serverless_connector_name
  region                  = var.region
  network                 = google_compute_network.csye6225_vpc_network[0].self_link
  ip_cidr_range           = var.google_vpc_access_connector_ip_cidr_range
  min_instances           = var.google_vpc_access_connector_min_instances
  max_instances           = var.google_vpc_access_connector_max_instances
  machine_type            = var.google_vpc_access_connector_machine_type
  depends_on              = [google_project_service.serverless_vpc_access]
}

resource "google_compute_global_address" "global_address" {
  provider      = google-beta
  project       = var.project
  name          = var.global_address_name
  purpose       = var.global_address_purpose
  network       = google_compute_network.csye6225_vpc_network[0].self_link
  address_type  = var.global_address_type
  prefix_length = 16
}

resource "google_compute_managed_ssl_certificate" "webapp_ssl_cert" {
  provider = google-beta
  name     = var.google_compute_managed_ssl_certificate_name
  project = var.project 
  lifecycle {
    prevent_destroy = false
  }
  managed {
    domains = [var.webapp_domain_name]
  }
}

resource "google_compute_firewall" "webapp_firewall_allow_health_check" {
  name          = var.webapp_firewall_allow_health_check_name
  provider      = google-beta
  direction     = var.webapp_firewall_allow_health_check_direction
  network       = google_compute_network.csye6225_vpc_network[0].self_link
  source_ranges = var.google_compute_firewall_source_ranges
  allow {
    protocol = var.webapp_firewall_allow_health_check_protocol
  }
  target_tags = var.google_compute_firewall_target_tags
  project     = var.project
}


resource "google_compute_target_https_proxy" "webapp_target_http_proxy" {
  name              = var.google_compute_target_https_proxy_name
  provider          = google-beta
  project           = var.project
  url_map           = google_compute_url_map.webapp_url_map.id
  ssl_certificates  = [google_compute_managed_ssl_certificate.webapp_ssl_cert.self_link]
}

resource "google_compute_global_forwarding_rule" "webapp_forwarding_rule" {
  name                  = var.google_compute_global_forwarding_rule_name
  project               = var.project
  provider              = google-beta
  ip_protocol           = var.google_compute_global_forwarding_rule_ip_protocol
  load_balancing_scheme = var.google_compute_global_forwarding_rule_load_balancing_scheme
  port_range            = var.google_compute_global_forwarding_rule_port_range
  target                = google_compute_target_https_proxy.webapp_target_http_proxy.id
}

resource "random_password" "password" {
  length           = var.random_password_length
  special          = var.random_password_special
  override_special = var.random_password_override_special
}


resource "random_id" "random_db_instance_id" {
  byte_length = var.random_id_instance_id
}
