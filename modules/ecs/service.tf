resource "aws_ecs_service" "this" {
  count  = length(var.services)

  name            = var.services[count.index].name
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this[count.index].arn
  desired_count   = var.services[count.index].desired_count

  load_balancer {
    target_group_arn = var.services[count.index].tg_arn
    container_name   = var.services[count.index].lb_container_name
    container_port   = var.services[count.index].lb_container_port
  }

  network_configuration {
    subnets = var.services[count.index].subnets
    security_groups = [aws_security_group.this.id]
  }
}