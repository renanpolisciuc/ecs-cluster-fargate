# Network configuration
module "network" {
  source = "./modules/network"

  cidr_block = "192.168.0.0/24"

  private_cidrs = [
    "192.168.0.0/26",
    "192.168.0.64/26"
  ]

  public_cidrs = [
    "192.168.0.128/26",
    "192.168.0.192/26"
  ]

  tags = {}
}

# Load balancer modules
module "lb" {
  source = "./modules/load-balancer"

  name = "test"

  subnet_ids = module.network.public_subnets

  vpc_id = module.network.vpc_id

  sgs = [module.network.default_sg_id]
}

# ECS Module
module "ecs" {
  source = "./modules/ecs"

  cluster_name = "test"

  services = local.services

  vpc_id = module.network.vpc_id
  
  lb_sg = module.network.default_sg_id
}