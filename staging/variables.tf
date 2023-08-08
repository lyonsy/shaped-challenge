variable "project_name" {
  default = "shaped-challenge"
}

variable "environment" {
  default = "dev"
}

variable "region" {
  default = "us-central1"
}

variable "service-account-email" {
  default = "sa-shaped-challenge@shaped-challenge.iam.gserviceaccount.com"
}

variable "whitelist_ip" { # Put your IP here
    default = "70.19.73.89/32"
}