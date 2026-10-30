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