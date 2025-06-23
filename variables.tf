variable "instance_type" {
  default = "t2.micro"
}

variable "ami_id" {
  default = "ami-0a7d80731ae1b2435" # Amazon Linux 2 AMI in us-east-1
}

variable "key_name" {
  description = "Name of the existing EC2 Key Pair"
}
