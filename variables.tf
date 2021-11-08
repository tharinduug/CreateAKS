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
  default = "26362789-7f7b-4206-853f-511d344e5772"
}

variable "client_id" {
  description = "Client ID"
  type        = string
  default = "7455661b-baa7-4df1-b000-b6758660b8a3"
}

variable "client_secret" {
  description = "Client Secret"
  type        = string
  default = "zNS7Q~yi2NtL2mFx6xfW9NiV84D1oElRguJpn"
}

variable "tenant_id" {
  description = "Tenant ID"
  type        = string
  default = "b7dc2e83-5607-4300-8118-2452b2e0b461"
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
