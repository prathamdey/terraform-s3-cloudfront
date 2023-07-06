terraform {
  required_version = "~> 1.2.2"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.19.0"
    }
  }
}
/*
provider "aws" {
  profile = "default"
  region  = var.aws_region_primary
}
*/

provider "aws" {
  alias  = "virginia"
  region = var.aws_region_primary
}

provider "aws" {
  alias  = "ohio"
  region = var.aws_region_secondary
}


# pushed to test branch