# Creating Internet Gateway
resource "aws_internet_gateway" "Terraform-IG" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "terraform-IG"
  }
}
