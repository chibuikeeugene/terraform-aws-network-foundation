provider "aws" {
  region = var.region_name
  profile = "terraform-profile"
  default_tags {
    tags = {
      ManagedBy = "Platform engineering team"
      Project   = var.project_name
      Purpose   = "Terraform State"
    }
  }
}