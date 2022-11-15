resource "aws_ecs_task_definition" "this" {
  count = length(var.services)

  requires_compatibilities = ["FARGATE"]

  network_mode             = "awsvpc"

  cpu                      = sum(var.services[count.index].container_definitions.*.cpu)
  memory                   = sum(var.services[count.index].container_definitions.*.memory)

  family                = "service"
  container_definitions = jsonencode(var.services[count.index].container_definitions)
}