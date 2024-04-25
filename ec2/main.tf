terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "ap-northeast-1"
  profile = "default"
}

variable "INSTALL_DEPENDENCIES" {
  default   = "./install-dependencies/docker.sh"
  type      = string
}

variable "PEM_FILE" {
  default   = "terraform"
  type      = string
  sensitive = true
}

resource "aws_instance" "example_server" {
  ami = "ami-0db548937a54fa3a7" // ubuntu-focal-20.04, x86_64, storage-8g-gp2
  instance_type          = "t2.micro"
  key_name               = var.PEM_FILE
  subnet_id              = aws_subnet.subnet1.id
  vpc_security_group_ids = [aws_security_group.security_group.id]
  user_data              = filebase64(var.INSTALL_DEPENDENCIES)

  tags = {
    Name = "terraform"
  }
}

output "ec2instance" {
  value = aws_instance.example_server.public_ip
}
