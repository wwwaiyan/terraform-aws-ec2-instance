module "vpc" {
  source             = "github.com/wwwaiyan/terraform-aws-vpc/modules/wy_vpc"
  project_name       = var.project_name
  env_prefix         = var.env_prefix
  public_subnet_cidr = ["10.90.1.0/24","10.90.2.0/24"]
  private_subnet_cidr = ["10.90.3.0/24","10.90.4.0/24"]
}
module "sg" {
  #this module depends on wy_vpc module
  source        = "./modules/wy_sg"
  sg_name       = var.sg_name
  project_name  = var.project_name
  env_prefix    = var.env_prefix
  vpc_id        = module.vpc.vpc[0].id
  ingress_rules = var.ingress_rules
  egress_rules  = var.egress_rules
  depends_on = [ module.vpc ]
}
module "ec2_instance" {
  source            = "./modules/wy_instance"
  ec2_instance      = var.ec2_instance
  project_name      = var.project_name
  env_prefix        = var.env_prefix
  subnet_id         = module.vpc.public_subnet_ids[0]
  security_group_id = module.sg.security_group[0].id
  depends_on = [ module.vpc, module.sg ]
}