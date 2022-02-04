terraform {
    source = "../../../modules//codebuild"
}

include {
    path = find_in_parent_folders()
}

dependencies {
    paths = ["../network"]
}

dependency "network" {
    config_path = "../network"
    mock_outputs = {
        vpc_id = "vpc-000000000000"
        private_subnets_id = ["subnet-222222222222", "subnet-333333333333"]
  }
}

dependency "ecr" {
    config_path = "../ecr"
    skip_outputs = true
}

inputs = {
    vpc_id = dependency.network.outputs.vpc_id
    private_subnets_id = dependency.network.outputs.private_subnets_id
}

