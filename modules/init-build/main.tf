# ==========|  NULL-RESOURCE  |==========

resource "null_resource" "build" {
  # Resource builds Dockerfile locally and push it to AWS ECR

  provisioner "local-exec" {
    command     = var.script
    working_dir = var.working_dir

    # Variables for script execution
    environment = {
      TAG         = var.image_tag
      REPO_REGION = var.aws_region
      REPO_URL    = var.ecr_repo_url
      APP_NAME    = var.app_name
      ENV_NAME    = var.environment
    }
  }
}