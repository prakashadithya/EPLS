terraform {
  required_providers {
    publicip = {
      source  = "nxt-engineering/publicip"
      version = "0.0.9"
    }
  }
}

data "publicip_address" "default" {
}

resource "aws_security_group" "demo_sg" {
  name        = "${var.vpc_name}-sg"
  description = "Allow required traffic for the application"
  vpc_id      = var.vpc_id
  ingress {
    description = "ssh port"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${data.publicip_address.default.ip}/32"]
  }
  ingress {
    description = "http port"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "rdp port"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = ["${data.publicip_address.default.ip}/32"]
  }
  ingress {
    description = "rds port"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    self        = true
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.vpc_name}-sg"
  }
}