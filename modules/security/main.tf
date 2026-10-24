# setting up ALB Security group
resource "aws_security_group" "alb" {
  name_prefix = "${var.project_name}-${var.environment}-alb-"
  description = "Security group of the ALB"
  vpc_id = var.vpc_id
  tags = merge(
    var.tags,
    {
        Name =  "${var.project_name}-${var.environment}-alb-sg"
    }
  )
}

# setting up ingress rule for ALB security group
resource "aws_vpc_security_group_ingress_rule" "alb_https" {
  security_group_id = aws_security_group.alb.id
  description = "Allow HTTPs from the internet"
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 443
  to_port = 443
  ip_protocol = "tcp"
}

# setting up ECS application security group
resource "aws_security_group" "app" {
    name_prefix = "${var.project_name}-${var.environment}-app-"
    description = "Security group for ECS application"
    vpc_id = var.vpc_id
    tags = merge(
        var.tags,
        {
            Name = "${var.project_name}-${var.environment}-app-sg"
        }
    )
}

# setting up ingress rule for app sg
resource "aws_vpc_security_group_ingress_rule" "app_from_alb" {
  security_group_id = aws_security_group.app.id
  description = "Allow application traffic from ALB"
  referenced_security_group_id = aws_security_group.alb.id
  from_port = 8000
  to_port = 8000
  ip_protocol = "tcp"
}

#setting up database security group
resource "aws_security_group" "database" {
  name_prefix = "${var.project_name}-${var.environment}-db-"
  vpc_id = var.vpc_id
  description = "Security group for the database"
  tags = merge(
    var.tags,
    {
      Name = "${var.project_name}-${var.environment}-db-sg"
    }
  )
}


#setting up ingress rule for database sg
resource "aws_vpc_security_group_ingress_rule" "db_from_app" {
  security_group_id = aws_security_group.database.id
  ip_protocol = "tcp"
  description = "Allow application traffic from app"
  referenced_security_group_id = aws_security_group.app.id
  from_port = 5432
  to_port = 5432
}


# ==================== Egress rules ========================== #
resource "aws_vpc_security_group_egress_rule" "alb_to_app" {
  security_group_id = aws_security_group.alb.id
  referenced_security_group_id = aws_security_group.app.id
  ip_protocol = "tcp"
  from_port = 8000
  to_port = 8000
  description = "Allow ALB to communicate with the app"
}


resource "aws_vpc_security_group_egress_rule" "app_to_db" {
  security_group_id = aws_security_group.app.id
  referenced_security_group_id = aws_security_group.database.id
  ip_protocol = "tcp"
  from_port = 5432
  to_port = 5432
  description = "Allow ECS to communicate with POSTGRESQL"
}

resource "aws_vpc_security_group_egress_rule" "app_https" {
  security_group_id = aws_security_group.app.id
  ip_protocol = "tcp"
  cidr_ipv4 = "0.0.0.0/0"
  from_port = 443
  to_port = 443
  description = "Allow HTTPS outbound"
}