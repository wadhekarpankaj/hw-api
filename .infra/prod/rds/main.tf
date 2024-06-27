locals {
  db_tags = {
    name      = var.db_identifier
    env       = var.env
    terraform = "true"
  }
}

module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "6.6.0"

  identifier = var.db_identifier


  create_db_option_group    = false
  create_db_parameter_group = false

  engine               = var.db_engine
  engine_version       = var.db_engine_version
  family               = "${var.db_engine}${var.db_engine_version}"
  major_engine_version = var.db_engine_version
  instance_class       = var.db_instance_class

  allocated_storage = var.db_allocated_storage

  db_name  = var.db_name
  username = var.db_username
  port     = 5432

  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]

  maintenance_window      = "Mon:00:00-Mon:03:00"
  backup_window           = "03:00-06:00"
  backup_retention_period = 0

  tags = local.db_tags
}


resource "aws_security_group" "rds_sg" {
  name   = "rds_sg"
  vpc_id = "vpc-0c9fa8d16afd1a094"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = var.db_security_group_inbound
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

