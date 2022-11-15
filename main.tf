resource "aws_elasticache_subnet_group" "this" {
  name       = var.name
  subnet_ids = var.subnet_ids
}

resource "aws_elasticache_replication_group" "this" {
  replication_group_id          = var.name
  multi_az_enabled              = true
  automatic_failover_enabled    = true
  subnet_group_name             = aws_elasticache_subnet_group.this.name
  security_group_ids            = [aws_security_group.this.id]
  replication_group_description = "Redis cluster"
  node_type                     = var.node_type
  number_cache_clusters         = var.num_of_nodes
  parameter_group_name          = "default.redis6.x"
  engine_version                = "6.x"
  port                          = var.port
  # transit_encryption_enabled    = true
  # at_rest_encryption_enabled    = true
  snapshot_retention_limit      = 1
}

resource "aws_security_group" "this" {
  name   = "${var.name}-redis"
  vpc_id = var.vpc_id

  ingress {
    from_port = var.port
    to_port   = var.port
    protocol  = "tcp"
    // Clamp down to appropriate cidr block
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
