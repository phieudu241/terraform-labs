# Creating Subnet 1

resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = "ap-northeast-1a"
  cidr_block              = "172.31.0.0/20"
  map_public_ip_on_launch = true

  tags = {
    Name = "terraform-Subnet1"
  }
}
