variable "ssh_pub_key" {
  type      = string
  sensitive = true
}

variable "instance_tag" {
  type = list(any)
}

variable "ami" {
  type = map(any)
}

variable "os_specific" {
  type = string
}

variable "instance_type" {
  type = list(string)
}

variable "size" {
  type = number
}

variable "db_username" {
  type      = string
  sensitive = true
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "initial_db_name" {
  type      = string
  sensitive = true
}

variable "sgs" {
  type = list(any)
}

variable "bucket_name" {
  type = string
}

variable "public_ip_on_launch" {
  type = bool
}

variable "sshport" {
  type = number
}

variable "allow_specific" {
  description = "this allows corp office public ip"
  default     = "1.1.1.1/32"
  type        = string
}

variable "list_of_any" {
  type    = list(any)
  default = ["hello", 100, true]
}

variable "ha" {
  type = bool
}

variable "environment" {
  type = string
}