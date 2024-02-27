 variable "project" {
   default = "csye-6225-tarun-002294529"
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

variable "network_demo" {
  default = "csye6225-network-demo"
  
}

variable "subnetwork_webapp" {
  default = "webapp-subnetwork"
}

variable "subnetwork_db" {
  default = "db-subnetwork"
}

variable "route_hop" {
  default = "network-route"
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
  default = "222"
}

variable "webapp_vm_name" {
  default = "webapp-instance"
}

variable "machine_type" {
  default = "e2-standard-2"
  
}

variable "base_image_name" {
  default = "csye6225-image-a3-demo"
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

variable "allow-ssh-rule-demo" {
  default = "allow-ssh-rule-demo"
}


variable "port_22" {
  default = 22
}
