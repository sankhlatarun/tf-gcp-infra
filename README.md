
# tf-gcp-infra

This project automates the setup of Google Cloud Platform (GCP) infrastructure using Terraform. It provisions a Virtual Private Cloud (VPC) network with multiple subnets, service accounts, and other resources, streamlining the deployment process.

## Features

- **VPC Network**: Creates a custom VPC with two subnets.
- **Service Accounts**: Manages service accounts with specific roles.
- **Cloud SQL**: Enables the Cloud SQL Admin API for database management.
- **Cloud Storage**: Sets up storage buckets as needed.
- **Cloud Functions**: Deploys serverless functions.
- **Pub/Sub**: Configures messaging services.
- **Cloud KMS**: Manages encryption keys.

## Prerequisites

- **Terraform**: Ensure Terraform is installed. [Installation Guide](https://learn.hashicorp.com/tutorials/terraform/install-cli)
- **Google Cloud SDK**: Install and initialize the SDK. [Installation Guide](https://cloud.google.com/sdk/docs/install)

## Setup Instructions

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/sankhlatarunorg/tf-gcp-infra.git
   cd tf-gcp-infra
   ```

2. **Initialize Terraform**:
   ```bash
   terraform init
   ```

3. **Authenticate with GCP**:
   ```bash
   gcloud auth application-default login
   ```

4. **Enable Required APIs**:
   ```bash
   gcloud services enable compute.googleapis.com sqladmin.googleapis.com
   ```

5. **Configure Variables**:
   - Rename `terraform-tfvars/sample.tfvars` to `terraform.tfvars`.
   - Update the variables in `terraform.tfvars` to match your GCP project settings.

6. **Validate Configuration**:
   ```bash
   terraform plan -var-file="terraform.tfvars"
   ```

7. **Apply Configuration**:
   ```bash
   terraform apply --auto-approve -var-file="terraform.tfvars"
   ```

## Commands Reference

- **Plan**: Review changes without applying.
  ```bash
  terraform plan -var-file="terraform.tfvars"
  ```

- **Apply**: Apply changes to the infrastructure.
  ```bash
  terraform apply --auto-approve -var-file="terraform.tfvars"
  ```

- **Destroy**: Remove all resources managed by Terraform.
  ```bash
  terraform destroy --auto-approve -var-file="terraform.tfvars"
  ```

## Notes

- **Google Beta Provider**: If using beta features, initialize with:
  ```bash
  terraform init
  ```
  Ensure the `google-beta` provider is specified in your Terraform configuration.

- **Service Account Roles**: Assign the `Cloud KMS CryptoKey Encrypter/Decrypter` role to the necessary service accounts as required.

- **Project and Credentials**: Update the project name and credentials in the `terraform.tfvars` file to align with your GCP project.

For more detailed information, refer to the [Terraform Google Network Module](https://github.com/terraform-google-modules/terraform-google-network) and the [GCP VPC Documentation](https://cloud.google.com/vpc/docs/create-modify-vpc-networks).
```

Let me know if you need any modifications! 🚀
