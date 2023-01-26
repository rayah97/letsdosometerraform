variable "name_prefix" {
  type    = string
  default = "my-terraform"
}

variable "region" {
  type    = string
  default = "us-east-1"
}
variable "instance_name" {
  type        = string
  default     = "myinstance"
  description = "The name tag of the ec2 instance"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "ami" {
  type    = string
  default = "ami-0b5eea76982371e91"

}

