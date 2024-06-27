variable "vpc_id" {
  description = "VPC ID for the EKS cluster"
  type        = string
}

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

variable "env" {
  default = "Environment for the EKS cluster"
  type    = string
}

