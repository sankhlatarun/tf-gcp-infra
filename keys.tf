resource "google_kms_key_ring" "webapp_keyring" {
  name     = "keyring-csye-${random_id.random_db_instance_id.hex}"
  location = var.region
}

resource "google_kms_crypto_key" "webapp_key" {
  name      = "webapp-key-${random_id.random_db_instance_id.hex}"
  key_ring  = google_kms_key_ring.webapp_keyring.id
  purpose   = var.kms_crypto_key_purpose
  rotation_period   = var.rotation_period_key
  lifecycle {
    prevent_destroy = false
  }
}

resource "google_kms_crypto_key" "sql_instance_key" {
  name     = "sql-instance-key-${random_id.random_db_instance_id.hex}"
  key_ring = google_kms_key_ring.webapp_keyring.id
  rotation_period   = var.rotation_period_key

  lifecycle {
    prevent_destroy = false
  }
}

resource "google_kms_crypto_key" "bucket_storage_key" {
  name     = "bucket-storage-key-${random_id.random_db_instance_id.hex}"
  key_ring = google_kms_key_ring.webapp_keyring.id
  rotation_period   = var.rotation_period_key
  
  lifecycle {
    prevent_destroy = false
  }
}
