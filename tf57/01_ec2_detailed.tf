#this resource deploys public key to aws specified region
resource "aws_key_pair" "demo_ssh_pub_key" {
  key_name   = "tf-ssh-key"
  public_key = file(var.ssh_pub_key)
}

data "aws_ami" "updated_ami" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.*-x86_64-gp2"]
  }
}

locals {
  subnets = [aws_subnet.demo_subnet1.id, aws_subnet.demo_subnet2.id]
}

#this resource creates ec2 instance in aws specified region
resource "aws_instance" "demo_instance" {
  #tags                   = var.instance_tag[count.index]
  ami                    = data.aws_ami.updated_ami.id                        #lookup(var.ami, var.os_specific, "ami-123")
  instance_type          = var.environment == "dev" ? "t2.micro" : "t2.large" #element(var.instance_type, var.size)
  key_name               = aws_key_pair.demo_ssh_pub_key.key_name
  subnet_id              = local.subnets[count.index]
  vpc_security_group_ids = [aws_security_group.demo_sg.id]
  count                  = var.ha == true ? 2 : 1

  provisioner "file" {
    source      = "./nothing"
    destination = "/nowhere"
    on_failure  = continue
  }

  provisioner "local-exec" {
    command = "echo ${self.public_ip} > public_ip.txt"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "del public_ip.txt"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    host        = self.public_ip
    private_key = file("./terraformclass-global")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo amazon-linux-extras install php8.0 mariadb10.5 -y",
      "sudo yum install httpd -y",
      "sudo systemctl start httpd",
      "sudo systemctl enable httpd",
      "sudo mkdir /var/www/inc",
      "sudo chown -R ec2-user /var/www/"
    ]
  }

  provisioner "file" {
    content     = <<-EOF
    <?php

define('DB_SERVER', '${aws_db_instance.demo_database.address}');
define('DB_USERNAME', '${var.db_username}');
define('DB_PASSWORD', '${var.db_password}');
define('DB_DATABASE', '${var.initial_db_name}');

?>
  EOF
    destination = "/var/www/inc/dbinfo.inc"
  }

  provisioner "file" {
    source      = "./temp/index.php"
    destination = "/var/www/html/index.php"
  }
}

/*
resource "aws_instance" "demo_instance3" {
  tags                   = var.instance_tag
  ami                    = var.ami["rhel"]
  instance_type          = var.instance_type[0]
  key_name               = "terraformclass-mumbai-kp"
  vpc_security_group_ids = var.sgs
}

resource "time_sleep" "wait_a_min" {
  create_duration = "1m"
  depends_on = [
    aws_instance.demo_instance
  ]
}

#this resource creates ec2 instance in singapore region
resource "aws_instance" "demo_instance1" {
  tags = {
    Name = "linux-webserver2"
    Dept = "devops"
  }
  ami           = "ami-005835d578c62050d"
  instance_type = "t2.micro"
  provider      = aws.tf57-singapore
}

#this resource creates ec2 instance in mumbai region in account2
resource "aws_instance" "demo_instance2" {
  tags = {
    Name = "linux-webserver3"
    Dept = "devops"
  }
  ami           = "ami-0cca134ec43cf708f"
  instance_type = "t2.micro"
  provider      = aws.tf57-mumbai-production
}
*/