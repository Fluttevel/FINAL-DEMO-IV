# ==========| INITIALIZING GLOBAL VARIABLES |==========

variable aws_region {}
variable app_name {}
variable environment {}
variable cidr_block_0 {}
variable ecr_repo_url {}


# ==========|  IMPORT VARIABLES FROM "NETWORK" MODULE  |==========

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = null
}

variable "private_subnets_id" {
  description = "Private Subnets ID"
  type        = list(string)
  default     = null
}


# ==========| VARIABLES FOR "INIT-BUILD" MODULE |==========


variable "buildspec_file" {
  description = "Name for buildspec file"
  default = "buildspec.yml"
}

variable "buildspec_path" {
  description = "path to buildspec file(dependence on stage)"
}

variable "pattern_branch" {
  description = "default pattern for codebuild"
  default = "^refs/heads"
}

variable "branch_githook" {
  description = "Variable for pattern that show what branch codebuild will be wait"
  default = "main"
}

variable "git_event" {
  description = "Variable for codebuild webhook that show after what start build"
  default = "PUSH"
}

variable "repository_url" {
  description = "GitHub repository url"
  default = "https://github.com/DmitryKorzhIT/crisp_cinema_bot_with_devops.git"
}