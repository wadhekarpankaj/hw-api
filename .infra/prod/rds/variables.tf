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

variable "env" {
  default = "Environment for the RDS instance"
  type    = string
}