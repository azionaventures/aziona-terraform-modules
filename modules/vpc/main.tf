module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "terraformed-vpc-${var.environment}"
  cidr = var.vpc_cidr_block

  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  private_subnets = [
    cidrsubnet(var.vpc_cidr_block, 8, 0),
    cidrsubnet(var.vpc_cidr_block, 8, 1)
  ]
  private_subnet_tags = {
    subnet = "${var.eks_cluster}-private"
    "kubernetes.io/cluster/${var.eks_cluster}" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
  
  public_subnets  = [
    cidrsubnet(var.vpc_cidr_block, 8, 100),
    cidrsubnet(var.vpc_cidr_block, 8, 101)
  ]
  public_subnet_tags = {
    subnet = "${var.eks_cluster}-public"
    "kubernetes.io/cluster/${var.eks_cluster}" = "shared"
    "kubernetes.io/role/elb" = 1
  }

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = var.environment
  }
}