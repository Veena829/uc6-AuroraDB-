# modules/aurora/main.tf

resource "aws_rds_cluster" "aurora" {
  cluster_identifier      = "aurora-cluster"
  engine                  = "aurora-mysql"
  master_username         = var.db_username
  master_password         = var.db_password
  database_name           = var.db_name
  skip_final_snapshot     = true
  vpc_security_group_ids  = [aws_security_group.aurora_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.aurora_subnet.name
}

resource "aws_rds_cluster_instance" "aurora_instances" {
  count              = 2
  identifier         = "aurora-instance-${count.index}"
  cluster_identifier = aws_rds_cluster.aurora.id
  instance_class     = "db.r6g.large"
  engine             = aws_rds_cluster.aurora.engine
}

resource "aws_security_group" "aurora_sg" {
  name        = "aurora-sg"
  description = "Aurora DB SG"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Change this in production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_subnet_group" "aurora_subnet" {
  name       = "aurora-subnet-group"
  subnet_ids = var.subnet_ids
}

