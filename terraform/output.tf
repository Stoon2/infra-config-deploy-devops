output "private_instance_ip" {
  value = aws_instance.app_server.private_ip
}

output "bastion_instance_ip" {
  value = aws_instance.bastion.public_ip
}

# RDS connection configuration
output "rds_hostname" {
  value = aws_db_instance.main_rds.address
}
output "rds_port" {
  value = aws_db_instance.main_rds.port
}

# Elastic Cache connection conf
output "redis_hostname" {
  value = aws_elasticache_cluster.main_cache.cache_nodes.0.address
}
output "redis_port" {
  value = aws_elasticache_cluster.main_cache.port
}
