resource "aws_security_group" "allow_ssh_all" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = module.network.vpc_main_id

  ingress {
    description = "SSH from ALL"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_security_group" "allow_redis_port" {
  name        = "allow-redis-port"
  description = "Allows access to redis"
  vpc_id      = module.network.vpc_main_id

  ingress {
    description     = "Redis local"
    from_port       = 6379
    to_port         = 6379
    protocol        = "tcp"
    security_groups = [aws_security_group.allow_ssh_p3000_local.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "allow_ssh_p3000_local" {
  name        = "allow_all_tcp"
  description = "Allow all tcp"
  vpc_id      = module.network.vpc_main_id

  ingress {
    description = "Port 0 - 65535 local"
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = [module.network.vpc_main_cidr]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}

resource "aws_security_group" "allow_3306_local" {
  name        = "allow_3306_local"
  description = "Allow P3306 inbound traffic locally"
  vpc_id      = module.network.vpc_main_id

  ingress {
    description = "P3306 from local"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [module.network.vpc_main_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_tls"
  }
}
