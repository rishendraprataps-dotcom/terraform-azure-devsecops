variable "subscription_id" {
  description = "Azure subscription ID. Supply through ARM_SUBSCRIPTION_ID or terraform.tfvars."
  type        = string
  sensitive   = true
  default     = null
}

variable "location" {
  description = "Azure region for demo resources."
  type        = string
  default     = "centralindia"
}

variable "resource_group_name" {
  description = "Name of the demo resource group."
  type        = string
  default     = "rg-terraform-devsecops-demo"
}

variable "vnet_name" {
  description = "Name of the virtual network."
  type        = string
  default     = "vnet-devsecops-demo"
}

variable "address_space" {
  description = "Address space for the virtual network."
  type        = list(string)
  default     = ["10.20.0.0/16"]
}

variable "subnet_name" {
  description = "Name of the application subnet."
  type        = string
  default     = "snet-app"
}

variable "subnet_prefixes" {
  description = "CIDR prefixes for the application subnet."
  type        = list(string)
  default     = ["10.20.1.0/24"]
}

variable "environment" {
  description = "Environment tag."
  type        = string
  default     = "demo"
}
