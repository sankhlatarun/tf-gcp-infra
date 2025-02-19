resource "google_project_service_identity" "cloudsql_sa" {
  provider  = google-beta
  project   = var.project
  service   = var.sql_service_account
}

resource "google_sql_database_instance" "webapp_sql_instance" {
  name                = "webapp-sql-instance-${random_id.random_db_instance_id.hex}"
  database_version    = var.database_version
  region              = var.region
  depends_on          = [ google_service_networking_connection.webapp_private_vpc_connection,google_kms_crypto_key_iam_policy.crypto_key_sql,google_project_iam_binding.csye_service_account_KMS ]
  deletion_protection = var.webapp_sql_instance_deletion_protection
  encryption_key_name = google_kms_crypto_key.sql_instance_key.id

  settings {
    tier                = var.database_tier
    disk_size           = var.database_disk_size
    ip_configuration {
      ipv4_enabled    = var.google_sql_database_instance_ip_config_ipv4_enabled
      private_network = google_compute_network.csye6225_vpc_network[0].self_link
    }
    backup_configuration {
      binary_log_enabled  = var.google_sql_database_instance_backup_configuration_binary_log_enabled
      enabled             = var.google_sql_database_instance_backup_configuration_log_enabled
    }
  }
}

resource "google_sql_database" "sql_database" {
  name     = var.webapp_DB_Name
  instance = google_sql_database_instance.webapp_sql_instance.name
}

resource "google_sql_user" "sql_user" {
  name      = var.webapp_USER_Name
  instance  = google_sql_database_instance.webapp_sql_instance.name
  password  = random_password.password.result
}
