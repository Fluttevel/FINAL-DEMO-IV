# ==========|  PROVIDER  |==========

provider "aws" {
  region = var.aws_region
}


# ==========|  S3 BUCKET  |==========

terraform {
  backend "s3" {}
}