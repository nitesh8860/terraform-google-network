# Define your GCP provider configuration
provider "google" {
  credentials = file("<PATH_TO_YOUR_GCP_SERVICE_ACCOUNT_KEY_JSON>")
  project     = var.project
  region      = var.region
}

# Include the vpc-network module
module "my_vpc" {
  source = "./modules/vpc-network"

  # Define input variables for the vpc-network module
  vpc_name           = var.name_prefix
  region             = var.region
  subnet_cidr_blocks = [cidrsubnet(var.cidr_block, 8, var.cidr_subnetwork_spacing)]
  firewall_rules     = [
    {
      name        = "allow-http-https",
      description = "Allow HTTP and HTTPS traffic",
      direction   = "INGRESS",
      action      = "ALLOW",
      targets     = ["tag('http-https')"],
      source_ips  = ["0.0.0.0/0"],
      protocols   = ["tcp"],
      ports       = ["80", "443"],
    },
  ]

  # Additional variables based on your requirements
  log_config = var.log_config
}

# Output values from the vpc-network module
output "vpc_id" {
  value = module.my_vpc.vpc_id
}

output "subnets" {
  value = module.my_vpc.subnets
}
