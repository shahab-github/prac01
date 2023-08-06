provider "aws" {
  version                 = "~> 2.0"
  shared_credentials_file = "~/.aws/credentials"
  profile                 = "terraform"
  region                  = "eu-west-1"
}

/*# Backend must remain commented until the Bucket
 and the DynamoDB table are created. 
 After the creation you can uncomment it,
 run "terraform init" and then "terraform apply" */

# terraform {
#   backend "s3" {
#     bucket         = "my-terraform-state-backend"
#     key            = "dev/terraform.tfstate"
#     region         = "us-east-1"
#     dynamodb_table = "terraform_state"
#   }
# }
