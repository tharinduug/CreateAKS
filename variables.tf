variable "prefix" {
  description = "Project Code or Name"
  type        = string
  default = "AFS"
}

variable location {
  description = "Azure Region"
  type        = string
  default     = "West US 2"
}

variable "subscription_id" {
  description = "Subscription ID"
  type        = string
  default = ""
}

variable "client_id" {
  description = "Client ID"
  type        = string
  default = ""
}

variable "client_secret" {
  description = "Client Secret"
  type        = string
  default = ""
}

variable "tenant_id" {
  description = "Tenant ID"
  type        = string
  default = ""
}

