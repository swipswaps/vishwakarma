terraform {
  required_version = "~> 0.12.29"
}

provider "aws" {
  region  = var.aws_region
  version = "~>v3.29.0"
}

provider "external" {
  version = "1.2.0"
}

provider "ignition" {
  version = "1.2.1"
}

provider "null" {
  version = "2.1.2"
}

provider "random" {
  version = "2.2.0"
}

provider "template" {
  version = "2.1.2"
}

provider "tls" {
  version = "2.1.0"
}
