terraform {
    source = "../../../modules//init-build"
}

include {
    path = find_in_parent_folders()
}

dependencies {
    paths = ["../ecr"]
}

dependency "ecr" {
    config_path = "../ecr"
    skip_outputs = true
}

inputs = {
    working_dir = format("%s/../../../app", get_terragrunt_dir())
}