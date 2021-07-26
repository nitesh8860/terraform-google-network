variable "project" {
  type        = string
  description = "The project id for the network"
}

variable "region" {
  type        = string
  description = "the region for subnets"
}

variable "name_prefix" {
  type        = string
  description = "a name prefix to ensure uniqueness in resource names."
}

variable "cidr_block" {
  type        = string
  default     = "0.0.0.0/16"
  description = "cidr range for vpc network"
}

variable "cidr_subnetwork_width_delta" {
  type        = number
  default     = 4
  description = "difference between subnet and net mask. i.e. /20 and /16"
}

variable "log_config" {
  type = object({
    aggregation_interval = string
    flow_sampling        = number
    metadata             = string
  })
  default = {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
  description = "flow logs for subnet"
}

variable "cidr_subnetwork_spacing" {
  description = "How many subnetwork-mask sized spaces to leave between each subnetwork type."
  type        = number
  default     = 0
}