variable "location" {
  description = "Azure region"
  type        = string
  default     = "eastus"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "shared"
}

variable "address_space" {
  description = "VNet address space"
  type        = list(string)
}
