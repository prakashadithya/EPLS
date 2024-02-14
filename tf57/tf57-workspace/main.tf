terraform {
  backend "local" {
    path = "secure_state/terraform.tfstate"
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
/*
variable "instance_type" {
  type = map(any)
  default = {
    default     = "t2.micro"
    development = "t2.medium"
    production  = "t2.large"
  }
}
*/