output "vpc_id" {
  description = "The ID of the vpc"
  value       = module.novapay_network.vpc_id
}

output "payment_api_repository_url" {
  description = "Payment API image registory"
  value       = module.novapay_ecr.repository_url
}