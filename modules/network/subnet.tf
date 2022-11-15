resource "aws_subnet" "private" {
  count = length(var.private_cidrs)

  availability_zone = "us-east-1${local.zones[count.index]}"

  vpc_id     = aws_vpc.this.id
  cidr_block = var.private_cidrs[count.index]

  tags = merge(var.tags, {
    Name = "subnet-private-${count.index}"
  })
}

resource "aws_subnet" "public" {
  count = length(var.public_cidrs)

  availability_zone = "us-east-1${local.zones[count.index]}"

  vpc_id     = aws_vpc.this.id
  cidr_block = var.public_cidrs[count.index]

  tags = merge(var.tags, {
    Name = "subnet-public-${count.index}"
  })
}