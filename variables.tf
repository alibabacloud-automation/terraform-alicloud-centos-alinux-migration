variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
  default     = "wordpress-vpc"
}

variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
  default     = "192.168.0.0/16"
}

variable "vswitch_name" {
  type        = string
  description = "Name of the VSwitch"
  default     = "wordpress-vsw"
}

variable "vswitch_cidr_block" {
  type        = string
  description = "CIDR block for the VSwitch"
  default     = "192.168.0.0/24"
}

variable "zone_id" {
  type        = string
  description = "Availability zone ID for the VSwitch"
}

variable "security_group_name" {
  type        = string
  description = "Name of the security group"
  default     = "wordpress-sg"
}

variable "http_rule_type" {
  type        = string
  description = "Type of the HTTP security group rule"
  default     = "ingress"
}

variable "http_rule_ip_protocol" {
  type        = string
  description = "IP protocol for HTTP security group rule"
  default     = "tcp"
}

variable "http_rule_port_range" {
  type        = string
  description = "Port range for HTTP security group rule"
  default     = "80/80"
}

variable "http_rule_cidr_ip" {
  type        = string
  description = "CIDR IP for HTTP security group rule"
  default     = "0.0.0.0/0"
}

variable "https_rule_type" {
  type        = string
  description = "Type of the HTTPS security group rule"
  default     = "ingress"
}

variable "https_rule_ip_protocol" {
  type        = string
  description = "IP protocol for HTTPS security group rule"
  default     = "tcp"
}

variable "https_rule_port_range" {
  type        = string
  description = "Port range for HTTPS security group rule"
  default     = "443/443"
}

variable "https_rule_cidr_ip" {
  type        = string
  description = "CIDR IP for HTTPS security group rule"
  default     = "0.0.0.0/0"
}

variable "instance_name" {
  type        = string
  description = "Name of the ECS instance"
  default     = "wordpress-ecs"
}

variable "image_id" {
  type        = string
  description = "Image ID for the ECS instance"
}

variable "instance_type" {
  type        = string
  description = "Instance type for the ECS instance"
}

variable "internet_max_bandwidth_out" {
  type        = number
  description = "Maximum outgoing bandwidth to the public network"
  default     = 5
}

variable "system_disk_category" {
  type        = string
  description = "System disk category for the ECS instance"
  default     = "cloud_essd"
}

variable "ecs_instance_password" {
  type        = string
  description = "Password for the ECS instance login, 8-30 characters, must include three types (uppercase letters, lowercase letters, numbers, special symbols)"
  sensitive   = true
}

variable "command_name" {
  type        = string
  description = "Name of the ECS command"
  default     = "wordpress-install"
}

variable "command_description" {
  type        = string
  description = "Description of the ECS command"
  default     = "Install WordPress on CentOS 7"
}

variable "command_type" {
  type        = string
  description = "Type of the ECS command"
  default     = "RunShellScript"
}

variable "command_timeout" {
  type        = number
  description = "Timeout for the ECS command execution in seconds"
  default     = 7200
}

variable "command_working_dir" {
  type        = string
  description = "Working directory for the ECS command"
  default     = "/root"
}

variable "invocation_timeout_create" {
  type        = string
  description = "Timeout for ECS invocation creation"
  default     = "5m"
}

variable "db_password" {
  type        = string
  description = "Database user password, 8-32 characters, must include uppercase letters, lowercase letters, special characters and numbers"
  sensitive   = true
}