resource "aws_instance" "demo_instance" {
  ami           = "ami-0cca134ec43cf708f"
  instance_type = "t2.micro"
}