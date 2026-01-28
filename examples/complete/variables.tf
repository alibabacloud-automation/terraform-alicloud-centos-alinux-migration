variable "region" {
  type        = string
  description = "The region where to deploy the resources"
  default     = "cn-zhangjiakou"
}

variable "instance_type" {
  type        = string
  description = "The instance type for ECS instance"
  default     = "ecs.g7.large"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
  default     = "centos-migration-vpc"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "192.168.0.0/16"
}

variable "vswitch_name" {
  type        = string
  description = "Name of the VSwitch"
  default     = "centos-migration-vsw"
}

variable "vswitch_cidr_block" {
  type        = string
  description = "CIDR block for the VSwitch"
  default     = "192.168.0.0/24"
}

variable "security_group_name" {
  type        = string
  description = "Name of the security group"
  default     = "centos-migration-sg"
}

variable "instance_name" {
  type        = string
  description = "Name of the ECS instance"
  default     = "centos-wordpress-server"
}

variable "ecs_instance_password" {
  type        = string
  description = "Password for the ECS instance login, 8-30 characters, must include three types (uppercase letters, lowercase letters, numbers, special symbols)"
  sensitive   = true
}

variable "db_password" {
  type        = string
  description = "Database user password, 8-32 characters, must include uppercase letters, lowercase letters, special characters and numbers"
  sensitive   = true
}