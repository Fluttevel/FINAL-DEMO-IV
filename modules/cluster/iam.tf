# ==========| IAM ROLE |==========

resource "aws_iam_role" "ecs_task_execution_role" {
  name               = "${var.app_name}-${var.environment}-${var.ecs_task_execution_role_name}"
  assume_role_policy = data.aws_iam_policy_document.ecs_task_execution_role.json
}


# ==========| IAM ROLE POLICY |==========

resource "aws_iam_role_policy" "ecs_task_execution_role" {
  name_prefix = "ecs_iam_role_policy"
  role        = aws_iam_role.ecs_task_execution_role.id
  policy      = data.template_file.ecs_service_policy.rendered
}


# ==========| IAM ROLE |==========

resource "aws_iam_role" "ecs_task_role" {
  name               = "${var.app_name}-${var.environment}-${var.ecs_task_role_name}"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ecs-tasks.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}


# ==========| IAM ROLE POLICY XXX |==========

resource "aws_iam_role_policy" "ecs_task_role" {
  name = "${var.app_name}-${var.environment}-${var.ecs_task_role_name}"
  role = aws_iam_role.ecs_task_role.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:Get*",
                "s3:List*"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}


# ==========| IAM ROLE POLICY ATTACHMENT XXX |==========

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


# ================================================== #
# ==========|   Roles for EC2 profile XXX  |=========== #
# ================================================== #


# ==========| IAM ROLE POLICY DOCUMENT |==========

data "aws_iam_policy_document" "ec2_policy" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}


# ==========| IAM ROLE |==========

resource "aws_iam_role" "ec2_role" {
  name               = "ecs-agent-${var.aws_region}"
  assume_role_policy = data.aws_iam_policy_document.ec2_policy.json
}


# ==========| IAM ROLE POLICY ATTACHMENT |==========

resource "aws_iam_role_policy_attachment" "ec2_atach" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}


# ==========| IAM INSTANCE PROFILE |==========

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ecs-agent-${var.aws_region}"
  role = aws_iam_role.ec2_role.name
}