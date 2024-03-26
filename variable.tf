locals {
  labels = {
    "data_project" = var.data_project
  }
}

variable "project" {
  description = "ID Google Cloud project"
  type = string
}

variable "region" {
  description = "Region for Google Cloud project"
  type = string
}

variable "data_project" {
  description = "Name of data pipeline project to use as a resource prefix"
  type = string
}