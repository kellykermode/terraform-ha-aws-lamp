#No backend specified, therefore local backend
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
    }
  }
}
