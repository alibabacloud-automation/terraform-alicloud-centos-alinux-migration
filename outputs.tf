output "vpc_id" {
  description = "The ID of the VPC"
  value       = alicloud_vpc.vpc.id
}

output "vpc_name" {
  description = "The name of the VPC"
  value       = alicloud_vpc.vpc.vpc_name
}

output "vswitch_id" {
  description = "The ID of the VSwitch"
  value       = alicloud_vswitch.vswitch.id
}

output "vswitch_name" {
  description = "The name of the VSwitch"
  value       = alicloud_vswitch.vswitch.vswitch_name
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = alicloud_security_group.security_group.id
}

output "security_group_name" {
  description = "The name of the security group"
  value       = alicloud_security_group.security_group.security_group_name
}

output "instance_id" {
  description = "The ID of the ECS instance"
  value       = alicloud_instance.ecs_instance.id
}

output "instance_name" {
  description = "The name of the ECS instance"
  value       = alicloud_instance.ecs_instance.instance_name
}

output "instance_public_ip" {
  description = "The public IP address of the ECS instance"
  value       = alicloud_instance.ecs_instance.public_ip
}

output "instance_private_ip" {
  description = "The private IP address of the ECS instance"
  value       = alicloud_instance.ecs_instance.primary_ip_address
}

output "wordpress_url" {
  description = "WordPress default access URL"
  value       = "http://${alicloud_instance.ecs_instance.public_ip}"
}

output "command_id" {
  description = "The ID of the ECS command"
  value       = alicloud_ecs_command.wordpress_install.id
}

output "invocation_id" {
  description = "The ID of the ECS invocation"
  value       = alicloud_ecs_invocation.wordpress_install.id
}