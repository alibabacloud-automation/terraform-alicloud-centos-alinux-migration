provider "alicloud" {
  region = var.region
}

# Query available zones
data "alicloud_zones" "default" {
  available_instance_type = var.instance_type
}

# Query CentOS images
data "alicloud_images" "centos" {
  name_regex    = "^centos_7_8_x64*"
  owners        = "system"
  instance_type = var.instance_type
}

# Query instance types
data "alicloud_instance_types" "default" {
  instance_type_family = "ecs.g7"
  sorted_by            = "CPU"
}

module "centos_alinux_migration" {
  source = "../.."

  # Network configuration
  zone_id            = data.alicloud_zones.default.zones[0].id
  vpc_name           = var.vpc_name
  vpc_cidr_block     = var.vpc_cidr_block
  vswitch_name       = var.vswitch_name
  vswitch_cidr_block = var.vswitch_cidr_block

  # Security configuration
  security_group_name = var.security_group_name
  security_group_rules = {
    http_from_vswitch = {
      type        = "ingress"
      ip_protocol = "tcp"
      port_range  = "80/80"
      cidr_ip     = var.vswitch_cidr_block
    },
    https_from_vswitch = {
      type        = "ingress"
      ip_protocol = "tcp"
      port_range  = "443/443"
      cidr_ip     = var.vswitch_cidr_block
    }
  }

  # ECS configuration
  instance_name         = var.instance_name
  image_id              = data.alicloud_images.centos.images[0].id
  instance_type         = data.alicloud_instance_types.default.instance_types[0].id
  ecs_instance_password = var.ecs_instance_password

  # Database configuration
  db_password = var.db_password
}