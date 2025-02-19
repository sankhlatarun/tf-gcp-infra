# tf-gcp-infra
setting up your infrastructure using Terraform.
Tarun Sankhla

002294529

service account
service network
cloud resource manage api

add 1 vpc network with 2 subnets and workflow for teraform validation

commands:
terraform plan
terraform destroy
terraform apply
terraform plan -var-file="terraform-tfvars/terraform.tfvars" 
terraform apply  --auto-approve

added google beta via terraform init 
gcloud auth application-default loginyes
enable cloud sql admin api

change prjoect name
change credentials

terraform apply -var-file="terraform-tfvars/terraform.tfvars"
add Cloud KMS CryptoKey Encrypter/Decrypter to role
