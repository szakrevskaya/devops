variable rds_password_length {
    type    = number
    default = 12
}

variable special_chars {
    type    = string
    default = "/@#$"
}

variable rds_pass_param_name {
    type    = string
    default = "postgres-dev"
}

variable rds_pass_param_type {
    type    = string
    default = "SecureString"
}

variable db_id {
    type    = string
    default = "postgres-db-1"
}

variable db_instance_type {
    type    = string
    default = "db.t3.micro"
}

variable allocated_storage_value {
    type    = number
    default = 5
}

variable db_engine {
    type    = string
    default = "postgres"
}

variable db_engine_version {
    type    = string
    default = "16.1"
}