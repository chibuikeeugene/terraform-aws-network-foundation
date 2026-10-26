# ============ identity security ============== #
data "aws_iam_policy_document" "ecs_assume_role" {
  statement {
    sid =  "AllowAccessToECSForTaskExecutionRole"

    effect = "Allow"

    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type = "Service"

      identifiers = [
        "ecs-tasks.amazonaws.com"
      ]
    }
  }
}

# setting up iam role resource
resource "aws_iam_role" "ecs_task_execution" {
  name = var.ecs_task_execution_name
  assume_role_policy = data.aws_iam_policy_document.ecs_assume_role.json
  tags = var.tags
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution" {
  role = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"

}