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
  vpc_id            = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
  tags = {
    Name = "${var.name_prefix}-subnet"
  }
}

resource "aws_network_interface" "main" {
  subnet_id = aws_subnet.main.id
 

  tags = {
    Name = "${var.name_prefix}-interface"
  }
}
 resource "aws_eip" "main" {
  vpc = true
}
resource "aws_eip_association" "main" {
  public_ip = aws_eip.main.public_ip
  network_interface_id = aws_network_interface.main.id
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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "main" {
  ami           = var.ami
  instance_type = var.instance_type
  vpc_security_group_ids = [aws_security_group.main.id]


  network_interface {
    network_interface_id = aws_network_interface.main.id
    device_index         = 0
  }

  tags = {
    Name = "${var.name_prefix}-instance"
  }
}


# resource "aws_eip" "main" {
#   vpc = true
#   instance = aws_instance.main.id
# }
# resource "aws_internet_gateway" "example" {
#   vpc_id = aws_vpc.example.id
# }

# resource "aws_subnet" "public_subnet" {
#   vpc_id                  = aws_vpc.example.id
#   cidr_block              = "10.0.1.0/24"
#   availability_zone       = "us-west-2a"
#   map_public_ip_on_launch = true
# }

# resource "aws_route_table" "public_subnet" {
#   vpc_id = aws_vpc.example.id
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.example.id
#   }
# }

# resource "aws_route_table_association" "public_subnet" {
#   subnet_id      = aws_subnet.public_subnet.id
#   route_table_id = aws_route_table.public_subnet.id
# }


 terraform {
  backend "s3" {
    bucket = "bucketforterraformangit"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
output "public_ip" {
  value = aws_instance.main.public_ip
}
