variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "instance_type" {
  default = "t2.micro" # Free tier eligible
}

variable "ami_id" {
  # Amazon ubuntu  AMI for us-east-1
  default = "ami-0a7d80731ae1b2435"
}

variable "key_name" {
  default = "aws_key" # Make sure this exists in EC2 -> Key Pairs
}
