variable "db_identifier" {
  type = string
}

variable "db_name" {
  type = string
}

resource "random_string" "db-password" {
  length  = 32
  upper   = true
  numeric = true
  special = false
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "security_group" {
  vpc_id      = "${data.aws_vpc.default.id}"
  name        = "terraform-sg-postgres"
  description = "Allow all inbound for Postgres"
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "db-instance" {
  identifier             = var.db_identifier
  allocated_storage      = 50
  db_name                = var.db_name
  engine                 = "postgres"
  engine_version         = "16.2"
  instance_class         = "db.t3.micro"
  username               = "postgres"
  password               = random_string.db-password.result
  vpc_security_group_ids = [aws_security_group.security_group.id]
  publicly_accessible    = true
  skip_final_snapshot    = true
}
