locals {
  services = [
    {
      name = "nginx"

      desired_count = 1

      tg_arn            = module.lb.tg_arn
      lb_container_name = "nginx"
      lb_container_port = 80

      subnets = module.network.private_subnets

      container_definitions = [
        {
          name      = "nginx"
          image     = "nginx:1.22"
          cpu       = 1024
          memory    = 2048
          essential = true
          portMappings = [
            {
              containerPort = 80
              hostPort      = 80
            }
          ]
        }
      ]
    }
  ]
}