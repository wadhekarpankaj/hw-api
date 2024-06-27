locals {
  cluster_tags = {
    name      = var.cluster_name
    env       = var.env
    terraform = "true"
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.19.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version


  # EKS Addons
  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }

  vpc_id     = var.vpc_id
  subnet_ids = var.subnet_ids

  eks_managed_node_groups = {
    main = {
      labels = {
        node_group = "main"
      }
      ami_type       = "AL2_x86_64"
      instance_types = ["t2.medium"]
      min_size       = 1
      max_size       = 2
      desired_size   = 1
    }
    app = {
      labels = {
        node_group = "app"
      }
      ami_type       = "AL2_x86_64"
      instance_types = ["t2.medium"]
      min_size       = 1
      max_size       = 2
      desired_size   = 1
    }
  }

  tags = local.cluster_tags
}
