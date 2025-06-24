terraform {
    backend "s3" {
        bucket = "statefile-vpc"
        key    = "terraform.tfstate"
        region = "us-east-1"
    }
}