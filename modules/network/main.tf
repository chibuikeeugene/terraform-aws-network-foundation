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
resource "aws_subnet" "private_app" {
  for_each = var.private_subnets_app

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
resource "aws_subnet" "private_db" {
  for_each = var.private_subnets_db

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
    vpc_id = aws_vpc.this.id
    tags = merge(
        var.tags,
        {
            Name = "${var.name_prefix}-public-rt"
        }
    )
}

# setup route table for private app subnet
resource "aws_route_table" "private_app" {
  vpc_id = aws_vpc.this.id
  for_each = var.private_subnets_app

  tags = merge(
    var.tags,
    {
        Name = "${var.name_prefix}-${each.key}-rt"
    }
  )
}

# setup route table for private db subnet
resource "aws_route_table" "private_db" {
  vpc_id = aws_vpc.this.id
  for_each = var.private_subnets_db

  tags = merge(
    var.tags,
    {
        Name = "${var.name_prefix}-${each.key}-rt"
    }
  )
}

# to create a NAT resource we need an elastic ip, so we create an EIP Resource
resource "aws_eip" "nat" {
  for_each = var.public_subnets
  domain = "vpc"
  tags = {
    Name = "nat-eip-${each.key}"
  }
}
# setting up NAT gateway resource
resource "aws_nat_gateway" "public" {
  for_each = var.public_subnets
  allocation_id = aws_eip.nat[each.key].id
  subnet_id = aws_subnet.public[each.key].id
  
  tags = {
    Name = "nat-gateway-${each.key}"
  }
  depends_on = [ aws_internet_gateway.igw ]
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