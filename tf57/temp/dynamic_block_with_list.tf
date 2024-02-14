variable "sg_ports" {
  type    = list(any)
  default = ["22", "3389", "80", "443"]
}

variable "this" {
  type    = bool
  default = true
}

resource "aws_security_group" "demo_sg" {
  count       = var.this == true ? 1 : 0
  name        = "tf-sg"
  description = "Allow required traffic for the application"
  vpc_id      = "vpc-0ad1594a9ea4d7e55"

  dynamic "ingress" {
    for_each = var.sg_ports
    iterator = port
    content {
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/32"]
    }
  }
}