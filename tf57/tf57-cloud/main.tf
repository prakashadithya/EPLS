terraform {
  cloud {
    organization = "jerrish-org"

    workspaces {
      name = "tf57-cloud"
    }
  }
}

data "aws_ami" "updated_ami" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.*-x86_64-gp2"]
  }
}

resource "aws_instance" "demo_instance" {
  ami           = data.aws_ami.updated_ami.id
  instance_type = "t2.micro" #lookup(var.instance_type, terraform.workspace)
}

resource "aws_instance" "demo_instance1" {
  ami           = data.aws_ami.updated_ami.id
  instance_type = "t2.micro" #lookup(var.instance_type, terraform.workspace)
}