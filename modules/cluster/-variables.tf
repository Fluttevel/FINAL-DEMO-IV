# ==========| INITIALIZING GLOBALS VARIABLES |==========

variable aws_region {}
variable ecr_repo_url {}
variable app_name {}
variable environment {}
variable image_tag {}
variable app_count {}
variable cidr_block_0 {}


# ==========|  IMPORT VARIABLES FROM "NETWORK" MODULE  |==========

variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = null
}

variable "public_subnets_id" {
  description = "Public Subnets ID"
  type        = list(string)
  default     = null
}

variable "private_subnets_id" {
  description = "Private Subnets ID"
  type        = list(string)
  default     = null
}


# ==========| SSM PARAMETER |==========

resource "aws_ssm_parameter" "telegram_token" {
  name  = var.telegram_token_name
  type  = var.telegram_token_type
  value = var.telegram_token_value
}


# ==========| VARIABLES FOR "ECS" |==========

variable "server_port" {
  description = "Server port '80'"
  type        = number
  default     = 80
}

variable "telegram_token_name" {
  description = "Name token for Telegram"
  type        = string
  default     = "telegram_token"
}

variable "telegram_token_type" {
  description = "Type token for Telegram"
  type        = string
  default     = "SecureString"
}

variable "task_definition_template" {
  description = "JSON Template file for resource task_definition"
  type        = string
  default     = "./../cluster/def.json.tpl"
}

variable "launch_type" {
  description = "AWS-managed infrastructure 'FARGATE'"
  type        = string
  default     = "FARGATE"
}

variable "network_mode" {
  description = "Network mode"
  type        = string
  default     = "awsvpc"
}

variable "fargate_cpu" {
  description = "Fargate instance CPU units to provision (1 vCPU = 1024 CPU units)"
  type        = string
  default     = "512"
}

variable "fargate_memory" {
  description = "Fargate instance memory to provision (in MiB)"
  type        = string
  default     = "1024"
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  type        = string
  default     = "TaskExecutionRole"
}

variable "ecs_task_role_name" {
  description = "ECS task role name"
  type        = string
  default     = "TaskRole"
}

variable "protocol_tcp" {
  description = "Protocol 'TCP'"
  type        = string
  default     = "tcp"
}

locals {
  container_name  = format("%s-%s-app", var.app_name, var.environment)
  app_image       = format("%s/%s-%s:%s", var.ecr_repo_url, var.app_name, var.environment, var.image_tag)
}


# ==========| VARIABLES FOR "ALB" |==========

variable "load_balancer_type" {
  description = "Load Balancer type"
  type        = string
  default     = "application"
}

variable "protocol_http" {
  description = "Protocol 'HTTP'"
  type        = string
  default     = "HTTP"
}

variable "target_type" {
  description = "Target type"
  type        = string
  default     = "ip"
}

variable "health_check_path" {
  description = "Health check path '/'"
  type        = string
  default     = "/"
}

variable "health_check_matcher" {
  description = "Response code '200' for HTTP"
  type        = string
  default     = "200"
}

variable "listener_fixed_response" {
  description = "Values for Fixed Response"
  type = object({
    type         = string
    content_type = string
    message_body = string
    status_code  = number
  })
  default = {
    type         = "fixed-response"
    content_type = "text/plain"
    message_body = "404: page not found"
    status_code  = 404
  }
}

variable "listener_rule" {
  description = "Values for Listener Rule"
  type = object({
    priority     = number
    path_pattern = string
    action_type  = string
  })
  default = {
    priority     = 100
    path_pattern = "*"
    action_type  = "forward"
  }
}