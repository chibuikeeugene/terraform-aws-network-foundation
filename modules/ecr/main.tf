# provisioning ecr repository resource
resource "aws_ecr_repository" "payment_api" {
  name = var.repository_name
  image_tag_mutability = var.image_tag_mutability
  encryption_configuration {
    encryption_type = "AES256"
  }
  tags = merge(
    var.tags,
    {
        Name = var.repository_name
    }
  )

}

# configuring image scanning resource
resource "aws_ecr_registry_scanning_configuration" "basic" {
  scan_type = "BASIC"
  rule {
    scan_frequency = "SCAN_ON_PUSH"
    repository_filter {
      filter = var.repository_name
      filter_type = "WILDCARD"
    }
  }
}

# setting up ecr image lifecycle rules
resource "aws_ecr_lifecycle_policy" "payment_api" {
  repository = aws_ecr_repository.payment_api.name

  policy = jsonencode({
    rules = [
      {
        rulePriority = 1
        description  = "Expire untagged images after 7 days"

        selection = {
          tagStatus   = "untagged"
          countType   = "sinceImagePushed"
          countUnit   = "days"
          countNumber = 7
        }

        action = {
          type = "expire"
        }
      },
      {
        rulePriority = 2
        description  = "Retain the last 10 release images"

        selection = {
          tagStatus     = "tagged"
          tagPatternList = ["v*"]
          countType     = "imageCountMoreThan"
          countNumber   = 10
        }

        action = {
          type = "expire"
        }
      }
    ]
  })
}