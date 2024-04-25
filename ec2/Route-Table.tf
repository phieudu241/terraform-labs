# Creating  Route Table

resource "aws_route_table" "Terraform-RT" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Terraform-IG.id
  }
  tags = {
    Name = "terraform-RT"
  }
}
