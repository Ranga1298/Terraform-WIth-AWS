terraform {
  backend "s3" {
    bucket = "ranga-bucket-new" # Replace with your S3 bucket name
    key    = "terraform.tfstate"
    region = "us-east-2"

  }
}