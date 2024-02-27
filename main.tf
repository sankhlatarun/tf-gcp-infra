provider "google" {
  credentials = file(var.credentials_file)
  project     = var.project
  region      = var.region
  zone        = var.zone
}


resource "google_compute_network" "csye6225_vpc_network" {
  name                            = var.network
  auto_create_subnetworks         = var.vpc_auto_create_subnetworks
  routing_mode                    = var.vpc_routing_mode
  delete_default_routes_on_create = var.vpc_delete_default_routes_on_create
}


resource "google_compute_subnetwork" "webapp" {
  name          = var.subnetwork_webapp
  ip_cidr_range = var.webapp_subnetwork_ip_cidr_range
  region        = var.vpc_region
  network       = google_compute_network.csye6225_vpc_network.id
}

resource "google_compute_subnetwork" "db" {
  name          = var.subnetwork_db
  ip_cidr_range = var.db_subnetwork_ip_cidr_range
  region        = var.vpc_region
  network       = google_compute_network.csye6225_vpc_network.id
}

resource "google_compute_route" "hoproute" {
  name              = var.route_hop
  network           = google_compute_network.csye6225_vpc_network.self_link
  dest_range        = var.dest_range_route
  next_hop_gateway  = var.next_hop_gateway_route
}

// create vm from custom image gcp terraform
resource "google_compute_instance" "webapp_vm" {
  name         = var.webapp_vm_name
  machine_type = var.machine_type
  zone         = var.zone
  boot_disk {
    initialize_params {
      image = var.base_image_name
      type = var.base_image_type
      size = var.boot_disk_size
    }
  }

  tags = [var.allow_port_3000_name, var.allow_port_5432_name,var.allow_postgres]
  network_interface {
    # network = "default"
    network     = google_compute_network.csye6225_vpc_network.self_link
    subnetwork  = google_compute_subnetwork.webapp.self_link
    access_config {
      
    }
  }
}


resource "google_compute_firewall" "allow_port_3000" {
  name    = var.allow_port_3000_name
  network = google_compute_network.csye6225_vpc_network.self_link

  allow {
    protocol = var.allow_tcp_port_protocol
    ports    = [var.allow_port_3000]
  }

  source_ranges = [var.sourse_range_firewall]
  target_tags   = [var.allow_port_3000_name]
}

resource "google_compute_firewall" "allow_port_5432" {
  name    = var.allow_port_5432_name
  network = google_compute_network.csye6225_vpc_network.self_link

  allow {
    protocol = var.allow_tcp_port_protocol
    ports    = [var.allow_port_5432]
  }

  

  source_ranges = [var.sourse_range_firewall]
  target_tags   = [var.webapp_vm_name]
}

resource "google_compute_firewall" "deny_port_22" {
  name    = var.deny_port_22_name
  network = google_compute_network.csye6225_vpc_network.self_link
  deny {
    protocol  = var.allow_tcp_port_protocol
    ports     = [var.deny_port_22]
  }
  source_ranges   = [var.sourse_range_firewall]
  target_tags     = [var.deny_port_22_name] 
}
