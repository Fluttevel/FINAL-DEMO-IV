terraform {
    source = "../../../modules//cluster"
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
        vpc_id             = "vpc-000000000000"
        public_subnets_id  = ["subnet-22222222222", "subnet-333333333333"]
        private_subnets_id = ["subnet-00000000000", "subnet-111111111111"]
    }
}

inputs = {
    vpc_id             = dependency.network.outputs.vpc_id
    public_subnets_id  = dependency.network.outputs.public_subnets_id
    private_subnets_id = dependency.network.outputs.private_subnets_id
}