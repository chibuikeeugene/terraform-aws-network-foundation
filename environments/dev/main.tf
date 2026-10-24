data "aws_caller_identity" "current_user" { 
}

module "novapay_network" {
  source = "../../modules/network"

  vpc_cidr_block = var.vpc_cidr_block
  private_subnets_app = var.private_subnets_app
  public_subnets = var.public_subnets
  private_subnets_db = var.private_subnets_db
  name_prefix = "${var.project_name}-${var.environment}"
  
}

module "novapay_security" {
  source = "../../modules/security"
  project_name = var.project_name
  environment = var.environment
  vpc_id = module.novapay_network.vpc_id
}