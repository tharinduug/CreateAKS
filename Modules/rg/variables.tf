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

variable tags {
  description = "taging for env"
  type        = string
  default     = "Demo"
}