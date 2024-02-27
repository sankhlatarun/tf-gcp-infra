# tf-gcp-infra
setting up your infrastructure using Terraform.
Tarun Sankhla

002294529

add 1 vpc network with 2 subnets and workflow for teraform validation

commands:
terraform plan
terraform destroy
terraform apply
terraform plan -var-file="terraform-tfvars/main.tfvars" 
terraform apply  --auto-approve

added google beta via terraform inti
gcloud auth application-default login
enable cloud sql admin api
