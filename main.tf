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

resource "aws_subnet" "private_subnet_1" {
  vpc_id = aws_vpc.default.id
  cidr_block = "10.0.100.0/24"

  tags = {
    Name = "fastcampus_private_subnet_1"
  }
}