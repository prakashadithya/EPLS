terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.49.0"
    }
    publicip = {
      source  = "nxt-engineering/publicip"
      version = "0.0.9"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "ap-southeast-1"
  alias   = "tf57-singapore"
}

provider "aws" {
  profile = "production"
  region  = "ap-south-1"
  alias   = "tf57-mumbai-production"
}