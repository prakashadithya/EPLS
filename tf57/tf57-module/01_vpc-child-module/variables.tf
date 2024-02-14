variable "vpc_name" {
  type    = string
  default = "project-vpc"
}

variable "vpc_cidr" {
  type    = string
  default = "192.168.2.0/24"
}

variable "subnet_cidr" {
  type    = list(any)
  default = ["192.168.2.0/26", "192.168.2.64/26"]
}