output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.centos_alinux_migration.vpc_id
}

output "vswitch_id" {
  description = "The ID of the VSwitch"
  value       = module.centos_alinux_migration.vswitch_id
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = module.centos_alinux_migration.security_group_id
}

output "instance_id" {
  description = "The ID of the ECS instance"
  value       = module.centos_alinux_migration.instance_id
}

output "instance_public_ip" {
  description = "The public IP address of the ECS instance"
  value       = module.centos_alinux_migration.instance_public_ip
}

output "wordpress_url" {
  description = "WordPress default access URL"
  value       = module.centos_alinux_migration.wordpress_url
}