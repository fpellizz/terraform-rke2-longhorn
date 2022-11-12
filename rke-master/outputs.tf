output "rke2-master_public_ip_address" {
  value       = module.ec2_master.public_ip
  description = "Public IP of rke2 server"
}

output "rke2-master_private_ip_address" {
  value       = module.ec2_master.private_ip
  description = "Private IP of rke2 server"
}

output "rke2-master_Instance_id" {
  description = "Instance ID of rke2 server"
  value       = module.ec2_master.id
}

output "rke2-servers-security_group_internal-id" {
  description = "Internal Security Grou ID"
  value       = module.security_group_internal.security_group_id  
}

output "rke2-servers-security_group_external-id" {
  description = "External Security Grou ID"
  value       = module.security_group_external.security_group_id  
}

