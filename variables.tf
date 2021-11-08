variable "prefix" {
  description = "Project Code or Name"
  type        = string
  default = "AFS"
}

variable env {
  description = "Environment where VMs will be provisioned"
  type        = string
  default     = "test"
}

variable region {
  description = "Management Console Region"
  type        = string
  default     = "US"
}

variable location {
  description = "Azure Region"
  type        = string
  default     = "West US 2"
}

variable "subscription_id" {
  description = "Subscription ID"
  type        = string
  default = "subscription_id"
}

variable "client_id" {
  description = "Client ID"
  type        = string
  default = "client_id"
}

variable "client_secret" {
  description = "Client Secret"
  type        = string
  default = "client_secret"
}

variable "tenant_id" {
  description = "Tenant ID"
  type        = string
  default = "tenant_id"
}

variable rgname {
  type        = string
}

variable "lb_subnet" {
  description = "Subnet"
  type        = string
  default = "promdev"
}

variable "vnet" {
  description = "Virtual Network"
  type        = string
  default = "csc-proj-tcs-moni-poc-euwe-vnet"
}
