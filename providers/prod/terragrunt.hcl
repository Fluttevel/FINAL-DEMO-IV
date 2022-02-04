# ==========|  VALUES OF GLOBAL VARIABLES  |==========

locals {
    ecr_repo_url       = "692807581431.dkr.ecr.eu-west-2.amazonaws.com" # To change !!!
    aws_region         = "eu-west-2" # (Optional To change !)
    app_name           = "crisp-cinema-bot"
    environment        = "prod"
    image_tag          = "final.1.0"
    cidr_block_0       = "0.0.0.0/0"
    app_count          = 1
}

inputs = {
    ecr_repo_url       = local.ecr_repo_url
    aws_region         = local.aws_region
    app_name           = local.app_name
    environment        = local.environment
    image_tag          = local.image_tag
    cidr_block_0       = local.cidr_block_0
    app_count          = local.app_count
}

remote_state {
    backend = "s3" 

    config = {
        encrypt = true
        bucket  = "s3-${local.app_name}-${local.environment}"
        key     =  format("%s/terraform.tfstate", path_relative_to_include())
        region  = local.aws_region
  }
}