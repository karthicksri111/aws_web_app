provider "aws" {
  region         = var.region
  assume_role {
    role_arn     = "arn:aws:iam::${local.account_id}:role/Terraform_Role"
        }
}

