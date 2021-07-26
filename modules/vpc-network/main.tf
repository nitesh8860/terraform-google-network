terraform {
  required_version = ">= 1.0.0"
  required_providers {
    google = ">= 3.76.0"
  }

}

resource "google_compute_network" "vpc_network" {
  name                    = "${var.name_prefix}-network"
  project                 = var.project
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL"
}

resource "google_compute_router" "vpc_router" {
  name = "${var.name_prefix}-router"

  project = var.project
  region  = var.region
  network = google_compute_network.vpc_network.self_link
}

resource "google_compute_subnetwork" "vpc_subnetwork_public" {
  name          = "${var.name_prefix}-subnetwork-public"
  project       = var.project
  network       = google_compute_network.vpc_network.id
  ip_cidr_range = cidrsubnet(var.cidr_block, var.cidr_subnetwork_width_delta, 0)

  dynamic "log_config" {
    for_each = var.log_config == null ? [] : tolist([var.log_config])

    content {
      aggregation_interval = var.log_config.aggregation_interval
      flow_sampling        = var.log_config.flow_sampling
      metadata             = var.log_config.metadata
    }
  }
}

resource "google_compute_router_nat" "vpc_nat" {
  name                               = "${var.name_prefix}-nat"
  router                             = google_compute_router.vpc_router.name
  region                             = google_compute_router.vpc_router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "LIST_OF_SUBNETWORKS"

  subnetwork {
    name                    = google_compute_subnetwork.vpc_subnetwork_public.self_link
    source_ip_ranges_to_nat = ["ALL_IP_RANGES"]
  }

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

resource "google_compute_subnetwork" "vpc_subnetwork_private" {
  name                     = "${var.name_prefix}-subnetwork-private"
  project                  = var.project
  network                  = google_compute_network.vpc_network.self_link
  private_ip_google_access = true

  ip_cidr_range = cidrsubnet(
    var.cidr_block,
    var.cidr_subnetwork_width_delta,
    1 * (1 + var.cidr_subnetwork_spacing)
  )

  dynamic "log_config" {
    for_each = var.log_config == null ? [] : tolist([var.log_config])

    content {
      aggregation_interval = var.log_config.aggregation_interval
      flow_sampling        = var.log_config.flow_sampling
      metadata             = var.log_config.metadata
    }
  }
}