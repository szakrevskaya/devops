resource "random_string" "rds_password" {
  length           = var.rds_password_length
  special          = true
  override_special = var.special_chars
}

resource "aws_ssm_parameter" "rds_password" {
  name  = var.rds_pass_param_name
  type  = var.rds_pass_param_type
  value = random_string.rds_password.result
}

resource "aws_db_instance" "postgres-db" {
  identifier             = var.db_id
  instance_class         = var.db_instance_type
  allocated_storage      = var.allocated_storage_value
  engine                 = var.db_engine
  engine_version         = var.db_engine_version
  username               = "postgres"
  password               = random_string.rds_password.result
  publicly_accessible    = true
  skip_final_snapshot    = true
}