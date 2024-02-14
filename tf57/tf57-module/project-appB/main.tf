module "vpc" {
  source      = "../01_vpc-child-module"
  vpc_name    = "project-appB"
  vpc_cidr    = "192.168.101.0/24"
  subnet_cidr = ["192.168.101.0/26", "192.168.101.64/26"]
}

module "sg" {
  source   = "../02_sg-child-module"
  vpc_name = "project-appB"
  vpc_id   = module.vpc.vpc_id
}