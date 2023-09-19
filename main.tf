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


/* 개발 용도
module "default_custom_vpc" {
  source = "./custom_vpc" # custom_vpc아래의 모듈을 사용하겠다는 선언
  env = "dev"
}

/* 운영 용도 */
/* module "production_custom_vpc" {
  source = "./custom_vpc" # custom_vpc안에 있는 tag name이 똑같이 들어감
  env="prod"
} */


variable "names" {
  type = list(string)
  default = [ "test1", "test2" ]
}

variable "envs" {
  type = list(string)
  default = [ "dev","prod","" ]
}

/* module "personal_custom_vpc" {
  /* 구문이 바뀌면 replace 됨 */
  /* for_each = toset(var.names) */
  /* for_each = toset([for name in var.names : "${name}_human"])
  source = "./custom_vpc"
  env = "personal_${each.key}"
} */


module "vpc_list" {
  for_each = toset([for env in var.envs : env if env != ""])
  source = "./custom_vpc"
  env = each.key
}



# resource의 네임과 설정은 로컬에서만 판별하기 때문에
# datasource를 이용해서 클라우드 콘솔에 있는 id와 비교 할수 있음
/* data "aws_subnet" "private_subnet_1" {
  id = "subnet-055f04f6c48187fe4"
} */


# terraform은 모듈이 변경되면 모두 삭제 -> 재생성 된다.