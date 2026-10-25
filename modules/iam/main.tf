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