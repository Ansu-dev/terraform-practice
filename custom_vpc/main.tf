resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "fastcampus_default_vpc"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.default.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "ap-northeast-2a" # 가용영역 A

  tags = {
    Name = "fastcampus_public_subnet_1"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id = aws_vpc.default.id
  cidr_block = "10.0.100.0/24"
  availability_zone = "ap-northeast-2a" # 가용영역 A

  tags = {
    Name = "fastcampus_private_subnet_1"
  }
}

# nat_gateway
resource "aws_nat_gateway" "private_nat" {
  connectivity_type = "private"
  subnet_id = aws_subnet.private_subnet_1.id
}

# internet_gateway
resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.default.id # 위에 설정한 vpc
}
