data "google_iam_policy" "kms_key_encrypt_decrypt" {
  binding {
    role    = var.role_cryptoKeyEncrypterDecrypter
    members =  [ "serviceAccount:${local.cloud_storage_service_account}"]
  }
}

resource "google_kms_crypto_key_iam_policy" "crypto_key_sql" {
  crypto_key_id = google_kms_crypto_key.sql_instance_key.id
  policy_data   = data.google_iam_policy.kms_key_encrypt_decrypt.policy_data
}

resource "google_kms_crypto_key_iam_policy" "crypto_key_bucket_storage" {
  crypto_key_id = google_kms_crypto_key.bucket_storage_key.id
  policy_data   = data.google_iam_policy.kms_key_encrypt_decrypt.policy_data
}
