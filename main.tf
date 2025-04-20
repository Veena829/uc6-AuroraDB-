module "vpc" {
  source = "./modules/vpc"
}

module "aurora" {
  source       = "./modules/aurora"
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = module.vpc.subnet_ids
  db_name      = var.db_name
  db_username  = var.db_username
  db_password  = var.db_password
}

resource "aws_secretsmanager_secret" "aurora_credentials" {
  name = "aurora-db-credentials-v3"
}

resource "aws_secretsmanager_secret_version" "aurora_credentials_version" {
  secret_id     = aws_secretsmanager_secret.aurora_credentials.id
  secret_string = jsonencode({
    username = var.db_username,
    password = var.db_password
  })
}

