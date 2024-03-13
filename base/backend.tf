terraform {
  backend "s3" {
    bucket = "karthi-s3-tfstate"
    key = "main"
    region = "us-east-1"
    dynamodb_table = "karthi-dynamodb-lock"
  }
}