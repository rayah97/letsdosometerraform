provider "aws" {
  region = var.region
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "${var.name_prefix}-vpc"
  }
}

resource "aws_subnet" "main" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = "${var.name_prefix}-subnet"
  }
}

resource "aws_network_interface" "main" {
  subnet_id       = aws_subnet.main.id
  security_groups = [aws_security_group.main.id]
  tags = {
    Name = "${var.name_prefix}-interface"
  }
}


resource "aws_security_group" "main" {
  name        = "${var.name_prefix}-sg"
  description = "Allow HTTP traffic"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_route_table" "main" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_route_table_association" "main" {
  subnet_id      = aws_subnet.main.id
  route_table_id = aws_route_table.main.id
}

resource "aws_instance" "main" {
  ami           = var.ami
  instance_type = var.instance_type
  user_data     = file("init-script.sh")
  

  network_interface {
    network_interface_id = aws_network_interface.main.id
    device_index         = 0
  }
  tags = {
    Name = "${var.name_prefix}-instance"
  }
}

terraform {
  backend "s3" {
    bucket = "bucketforterraformangitblaahrayah"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}



