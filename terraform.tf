terraform {
  backend "s3" {
    bucket = "mytfbackend1"
    key = "dev/terraform.tfstate"
    region = "us-east-1"
    dynamo_table = "terraformtable"
  }
}
