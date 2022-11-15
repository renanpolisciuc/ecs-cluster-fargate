resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = var.tags
}

resource "aws_eip" "nat-ip" {
}

resource "aws_nat_gateway" "this" {
  allocation_id = aws_eip.nat-ip.id
  subnet_id     = aws_subnet.public[0].id

  tags = var.tags

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.this]
}