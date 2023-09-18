terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.17.0" # 최신 버전
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}


resource "aws_vpc" "default" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "fastcampus_default_vpc"
  }
}

resource "aws_subnet" "public_subnet_1" {
  vpc_id = aws_vpc.default.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "fastcampus_public_subnet_1"
  }
}

/* resource "aws_subnet" "private_subnet_1" {
  vpc_id = aws_vpc.default.id
  cidr_block = "10.0.100.0/24"

  tags = {
    Name = "fastcampus_private_subnet_1"
  }
} */

# resource의 네임과 설정은 로컬에서만 판별하기 때문에
# datasource를 이용해서 클라우드 콘솔에 있는 id와 비교 할수 있음
data "aws_subnet" "private_subnet_1" {
  id = "subnet-055f04f6c48187fe4"
}