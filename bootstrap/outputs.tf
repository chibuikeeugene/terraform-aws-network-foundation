output "bucket_name" {
  description = "The name of the terraform state object"
  value       = aws_s3_bucket.terraform_state.bucket
}

output "bucket_arn" {
  description = "The ARN of the terraform state object"
  value       = aws_s3_bucket.terraform_state.arn
}