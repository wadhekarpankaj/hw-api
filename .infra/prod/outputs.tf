output "eks_cluster_arn" {
  value = module.eks.eks_cluster_arn
}

output "eks_cluster_endpoint" {
  value = module.eks.eks_cluster_endpoint
}

output "db_instance_arn" {
  value = module.rds.db_instance_arn
}

output "db_instance_endpoint" {
  value = module.rds.db_instance_endpoint
}