# ---------------------------------------------------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------------------------------------------------

provider "aws" {
  version = "1.60.0"
  region  = "${var.aws_region}"
}

provider "template" {
  version = "1.0.0"
}

provider "ignition" {
  version = "1.0.0"
}

provider "null" {
  version = "1.0.0"
}