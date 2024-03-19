terraform {
  backend "s3" {
    bucket = "ra" # Replace with your S3 bucket name
    key    = "terraform.tfstate"
    region = "us-east-2"

  }
}
