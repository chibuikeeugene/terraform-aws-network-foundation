# setup vpc infrastructure
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = merge(
    var.tags,
    {
        Name = "${var.name_prefix}-vpc"
    }
  )
}

# setup internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
  tags = merge(
    var.tags,
    {
        Name = "${var.name_prefix}-igw"
    }
  )
}

# setup our first two public subnets
resource "aws_subnet" "public" {
  # we loop through our public subnet variable
  for_each = var.public_subnets

  vpc_id = aws_vpc.this.id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags = merge(
    var.tags,
    {
        Name = "${var.name_prefix}-${each.key}"
        Tier = "Public"
    }
  )
}

# setup our 4 private subnets
resource "aws_subnet" "private" {
  for_each = var.private_subnets

  vpc_id = aws_vpc.this.id
  cidr_block = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags = merge(
    var.tags,
    {
        Name = "${var.name_prefix}-${each.key}"
    }
  )
}


# setup route table for public subnets
resource "aws_route_table" "public" {
  
}

# setup route table for private app subnet
resource "aws_route_table" "private_app" {
  
}

# setup route table for private db subnet
resource "aws_route_table" "private_db" {
  
}

resource "aws_nat_gateway" "private_app_nat" {
  
}

# add routes to public route table
resource "aws_route" "internet" {
  
}

resource "aws_route" "internal" {
  
}

# add associate route table with  subnets
resource "aws_route_table_association" "public" {
  
}

resource "aws_route_table_association" "private_app" {
  
}

resource "aws_route_table_association" "private_db" {
  
}