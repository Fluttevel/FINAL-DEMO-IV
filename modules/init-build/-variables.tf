# ==========| INITIALIZING GLOBAL VARIABLES |==========

variable aws_region {}
variable app_name {}
variable environment {}
variable image_tag {}
variable ecr_repo_url {}

variable working_dir {}


# ==========| VARIABLES FOR "INIT-BUILD" MODULE |==========

variable script {
  description = "Bash script, which build Dockerfile and push it to AWS ECR"
  type        = string
  default     = "docker-script.sh"
}

#variable working_dir {
#  description = "Directory, where script is executed"
#  type        = string
#  default     = "./../../app/"
#}