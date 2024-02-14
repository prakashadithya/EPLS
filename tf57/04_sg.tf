data "publicip_address" "default" {
}

resource "aws_security_group" "demo_sg" {
  name        = "tf-vpc-sg"
  description = "Allow required traffic for the application"
  vpc_id      = aws_vpc.demo_vpc.id
  ingress {
    description = "ssh port"
    from_port   = var.sshport
    to_port     = var.sshport
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
  ingress {
    description = "nfs port"
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [var.allow_specific]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "tf-vpc-sg"
  }
}