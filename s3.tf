# Create an S3 bucket
resource "aws_s3_bucket" "mybucket" {
  bucket = "my-tf-backend-bucket"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

# Create a folder in the bucket
resource "aws_s3_bucket_object" "folder" {
  bucket = aws_s3_bucket.mybucket.id
  key    = "logs/"
}

# Create an EBS volume 
resource "aws_ebs_volume" "example" {
  availability_zone = "us-east-1a"
  size              = 40

  tags = {
    Name = "HelloWorld"
  }
}
