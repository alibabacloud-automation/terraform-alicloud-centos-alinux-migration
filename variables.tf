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

variable "custom_command_script" {
  type        = string
  description = "Custom script content for ECS command execution, if not provided, default WordPress installation script will be used"
  default     = null
}

variable "ecs_command_config" {
  type = object({
    name        = string
    description = string
    type        = string
    timeout     = number
    working_dir = string
  })
  description = "Configuration object for ECS command"
  default = {
    name        = "wordpress-install"
    description = "Install WordPress on CentOS 7"
    type        = "RunShellScript"
    timeout     = 7200
    working_dir = "/root"
  }
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


variable "security_group_rules" {
  type = map(object({
    type        = string
    ip_protocol = string
    port_range  = string
    cidr_ip     = string
  }))
  description = "Map of security group rules to create"
  default = {
    http = {
      type        = "ingress"
      ip_protocol = "tcp"
      port_range  = "80/80"
      cidr_ip     = "0.0.0.0/0"
    },
    https = {
      type        = "ingress"
      ip_protocol = "tcp"
      port_range  = "443/443"
      cidr_ip     = "0.0.0.0/0"
    }
  }
}
