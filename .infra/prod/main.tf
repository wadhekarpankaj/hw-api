module "rds" {
  source = "./rds"

  db_identifier             = var.db_identifier
  db_engine                 = var.db_engine
  db_engine_version         = var.db_engine_version
  db_name                   = var.db_name
  db_allocated_storage      = var.db_allocated_storage
  db_username               = var.db_username
  db_subnet_group_name      = var.db_subnet_group_name
  db_instance_class         = var.db_instance_class
  db_security_group_inbound = var.db_security_group_inbound
  env                       = var.env
}

module "eks" {
  source = "./eks"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  vpc_id          = var.vpc_id
  subnet_ids      = var.subnet_ids
  env             = var.env
}
