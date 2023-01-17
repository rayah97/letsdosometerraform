provider "aws" {
  region = "us-east-1"
}

resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "example" {
  vpc_id     = aws_vpc.example.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_network_interface" "example" {
  subnet_id   = aws_subnet.example.id
  private_ips = ["10.0.1.10"]
}

resource "aws_security_group" "example" {
  name        = "example"
  description = "Example security group"
  vpc_id      = aws_vpc.example.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "example" {
  ami             = "ami-0c94855ba95c71c99"
  instance_type   = "t2.micro"
  vpc_id          = aws_vpc.example.id
  security_groups = [aws_security_group.example.name]
  network_interface {
    network_interface_id = aws_network_interface.example.id
    device_index         = 0
  }
}
resource "aws_s3_bucket" "tf_state_bucket" {
  bucket = "bucketforterraformangitGIT"
  acl    = "private"
  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_object" "tf_state_file" {
  bucket = aws_s3_bucket.tf_state_bucket.id
  key    = "develop/terraform.tfstate"
}

terraform {
  backend "s3" {
    bucket = "bucketforterraformangitGIT"
    key    = "develop/terraform.tfstate"
    region = "us-east-1"
  }
}
output "public_ip" {
  value = aws_instance.example.public_ip
}
