env    = "prod"
region = ""

db_identifier             = "hw-api-prod"
db_engine                 = "postgres"
db_engine_version         = "15"
db_name                   = "hwapiprod"
db_username               = "admin_postgresql"
db_allocated_storage      = 10
db_subnet_group_name      = "hw-api-db"
db_instance_class         = "db.t3.micro"
db_security_group_inbound = ["10.0.1.119/32","10.0.3.0/24","10.0.4.0/24"]


cluster_name    = "eks-prod"
cluster_version = "1.30"
vpc_id          = "vpc-0c9fa8d16afd1a094"
subnet_ids      = ["subnet-0322cefad70cfa991", "subnet-0b27d2cc2e0990167"]
