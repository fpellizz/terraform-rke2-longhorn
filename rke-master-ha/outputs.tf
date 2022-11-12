output "rke2-master_public_ip_address" {
  value       = module.ec2_master_01.public_ip
  description = "Public IP of rke2 server"
}

output "rke2-master_private_ip_address" {
  value       = module.ec2_master_01.private_ip
  description = "Private IP of rke2 server"
}

output "rke2-master_Instance_id" {
  description = "Instance ID of rke2 server"
  value       = module.ec2_master_01.id
}
