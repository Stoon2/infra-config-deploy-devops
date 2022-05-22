output "private_instance_ip" {
  value = aws_instance.app_server.private_ip
}

output "bastion_instance_ip" {
  value = aws_instance.bastion.public_ip
}
