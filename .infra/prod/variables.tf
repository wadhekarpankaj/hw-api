variable "env" {
  default = "prod"
  type    = string
}

variable "region" {
  default = "eu-central-1"
  type    = string
}

variable "vpc_id" {
  description = "VPC ID for the EKS cluster"
  type        = string
}

#cluster
variable "cluster_name" {
  description = "The name of the EKS cluster"
  type        = string
}

variable "cluster_version" {
  description = "The version of the EKS cluster"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS cluster"
  type        = list(string)
}



#db
variable "db_identifier" {
  description = "The name of the RDS instance"
  type        = string
}

variable "db_engine" {
  description = "The engine of the RDS instance"
  type        = string
}

variable "db_engine_version" {
  description = "The engine version of the RDS instance"
  type        = string
}

variable "db_name" {
  description = "The name of the RDS instance"
  type        = string
}

variable "db_allocated_storage" {
  description = "The storage size for the RDS instance"
  type        = number
}
variable "db_username" {
  description = "The username for the RDS instance"
  type        = string
}

variable "db_subnet_group_name" {
  description = "The subnet group for the RDS instance"
  type        = string
}

variable "db_instance_class" {
  description = "The instance type of the RDS instance"
  type        = string
}

variable "db_security_group_inbound" {
  description = "The ingress cidr for the RDS instance"
  type        = list(string)
}
