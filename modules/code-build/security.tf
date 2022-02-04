resource "aws_security_group" "sg_codebuild" {
  name = "sg-${var.app_name}-${var.environment}"
  vpc_id = var.vpc_id

  ingress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = [var.cidr_block_0]
  }

  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = [var.cidr_block_0]
  }
}

