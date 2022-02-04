# ==========| INITIALIZING GLOBAL VARIABLES |==========

variable aws_region {}
variable app_name {}
variable environment {}
variable cidr_block_0 {}


# ==========| VARIABLES FOR "NETWORK" MODULE |==========

variable "vpc" {
  description = "Values for VPC"
  type = object({
    cidr_block           = string
    instance_tenancy     = string
    enable_dns_hostnames = bool
  })
  default = {
    cidr_block           = "10.0.0.0/16"
    instance_tenancy     = "default"
    enable_dns_hostnames = true
  }
}

variable "public_subnet" {
  description = "Values for Public Subnets"
  type = object({
    cidr_block        = list(string)
    availability_zone = list(string)
  })
  default = {
    cidr_block        = ["10.0.10.0/24", "10.0.20.0/24"]
    availability_zone = ["eu-west-2a", "eu-west-2b"]
  }
}

variable "private_subnet" {
  description = "Values for Private Subnets"
  type = object({
    cidr_block        = list(string)
    availability_zone = list(string)
  })
  default = {
    cidr_block        = ["10.0.11.0/24", "10.0.21.0/24"]
    availability_zone = ["eu-west-2a", "eu-west-2b"]
  }
}

variable "count_value" {
  description = "Count value"
  type        = number
  default     = 2
}