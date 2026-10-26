import {
  to = module.novapay_iam.aws_iam_role.ecs_task_execution
  id = var.ecs_task_execution_name
}

import {
  to = module.novapay_iam.aws_iam_role_policy_attachment.ecs_task_execution
  id = "${var.ecs_task_execution_name}/arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}