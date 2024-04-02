# AWS Environment Variables
#
# This variable defines AWS access credentials required for Terraform to interact with AWS services.
variable "aws_credentials" {
  type = object({
    access_key = string
    secret_key = string
  })

  default = {
    access_key = "your_access_key"
    secret_key = "your_secret_key"
  }
}

# VPC Configuration
#
# These variables define the configuration for the Virtual Private Cloud (VPC) including region, availability zones,
# VPC CIDR block, and subnet CIDR blocks.
variable "aws_region" {
  type    = string
  default = "ap-south-1"
}

variable "aws_zone" {
  type = map(string)
  default = {
    "zone1" = "ap-south-1a"
    "zone2" = "ap-south-1b"
  }
}

variable "vpc_cidr" {
  type    = string
  default = "10.10.0.0/16"
}

variable "subnet_cidrs" {
  type = map(string)
  default = {
    # Public Subnets
    "public_1a" = "10.10.0.0/19"
    "public_1b" = "10.10.32.0/19"

    # Private Subnets
    "private_1a" = "10.10.64.0/19"
    "private_1b" = "10.10.96.0/19"
  }
}

# Infrastructure Environment
#
# These variables define the environment-specific configuration for your infrastructure, such as environment name and instance type.
variable "env" {
  type    = string
  default = "Demo_Dev"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}
