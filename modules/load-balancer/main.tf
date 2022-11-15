resource "aws_lb" "this" {
  name               = var.name
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.sgs
  subnets            = var.subnet_ids

  enable_deletion_protection = true

  tags = var.tags
}