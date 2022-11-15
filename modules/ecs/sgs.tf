resource "aws_security_group" "this" {
  name        = "tasks_sg"
  description = "Allow traffic from lb"
  vpc_id      = var.vpc_id

  ingress {
    description = "TLS from LB"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    security_groups = [var.lb_sg]
  }

  ingress {
    description = "HTTP from LB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = var.tags
}