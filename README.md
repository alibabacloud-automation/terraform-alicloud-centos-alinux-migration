Terraform Alicloud CentOS to Alinux Operating System Migration Module

# terraform-alicloud-centos-alinux-migration

English | [简体中文](https://github.com/alibabacloud-automation/terraform-alicloud-centos-alinux-migration/blob/main/README-CN.md)

This Terraform module implements the [CentOS to Alinux Operating System Migration](https://www.aliyun.com/solution/tech-solution/centos-alinux) solution, involving the creation and deployment of resources such as Virtual Private Cloud (VPC), Virtual Switch (VSwitch), Elastic Compute Service (ECS), and automatic WordPress installation on CentOS 7 systems.

This module creates a complete infrastructure setup, including:
- VPC and VSwitch for network isolation
- Security groups with HTTP/HTTPS access rules
- ECS instances using CentOS 7 images
- Automated WordPress installation through ECS commands and invocations

## Usage

```hcl
provider "alicloud" {
  region = "cn-hangzhou"
}

data "alicloud_zones" "default" {
  available_instance_type = "ecs.g7.large"
}

data "alicloud_images" "centos" {
  name_regex    = "^centos_7_8_x64*"
  owners        = "system"
  instance_type = "ecs.g7.large"
}

data "alicloud_instance_types" "default" {
  instance_type_family = "ecs.g7"
  sorted_by            = "CPU"
}

module "centos_alinux_migration" {
  source = "alibabacloud-automation/centos-alinux-migration/alicloud"

  # Network configuration
  zone_id              = data.alicloud_zones.default.zones[0].id
  vpc_name             = "centos-migration-vpc"
  vpc_cidr_block       = "192.168.0.0/16"
  vswitch_name         = "centos-migration-vsw"
  vswitch_cidr_block   = "192.168.0.0/24"

  # Security configuration
  security_group_name = "centos-migration-sg"

  # ECS configuration
  instance_name        = "centos-wordpress-server"
  image_id            = data.alicloud_images.centos.images[0].id
  instance_type       = data.alicloud_instance_types.default.instance_types[0].id
  ecs_instance_password = "YourPassword123!"

  # Database configuration
  db_password = "DatabasePassword123!"
}
```

## Migrating from CentOS to AlmaLinux

This module sets up a WordPress environment on CentOS, which can serve as a starting point for migration to AlmaLinux. The WordPress installation script handles the following:

1. Environment preparation
2. Nginx installation and configuration
3. MySQL installation and setup
4. PHP installation and configuration
5. WordPress installation and configuration

After the initial setup is complete, you can continue with the migration process from CentOS to AlmaLinux following the official AlmaLinux migration guide.

## Examples

* [Complete Example](https://github.com/alibabacloud-automation/terraform-alicloud-centos-alinux-migration/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.220.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | 1.269.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ecs_command.wordpress_install](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.wordpress_install](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_instance.ecs_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_security_group.security_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.ingress_rules](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_custom_command_script"></a> [custom\_command\_script](#input\_custom\_command\_script) | Custom script content for ECS command execution, if not provided, default WordPress installation script will be used | `string` | `null` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Database user password, 8-32 characters, must include uppercase letters, lowercase letters, special characters and numbers | `string` | n/a | yes |
| <a name="input_ecs_command_config"></a> [ecs\_command\_config](#input\_ecs\_command\_config) | Configuration object for ECS command | <pre>object({<br>    name        = string<br>    description = string<br>    type        = string<br>    timeout     = number<br>    working_dir = string<br>  })</pre> | <pre>{<br>  "description": "Install WordPress on CentOS 7",<br>  "name": "wordpress-install",<br>  "timeout": 7200,<br>  "type": "RunShellScript",<br>  "working_dir": "/root"<br>}</pre> | no |
| <a name="input_ecs_instance_password"></a> [ecs\_instance\_password](#input\_ecs\_instance\_password) | Password for the ECS instance login, 8-30 characters, must include three types (uppercase letters, lowercase letters, numbers, special symbols) | `string` | n/a | yes |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | Image ID for the ECS instance | `string` | n/a | yes |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Name of the ECS instance | `string` | `"wordpress-ecs"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type for the ECS instance | `string` | n/a | yes |
| <a name="input_internet_max_bandwidth_out"></a> [internet\_max\_bandwidth\_out](#input\_internet\_max\_bandwidth\_out) | Maximum outgoing bandwidth to the public network | `number` | `5` | no |
| <a name="input_invocation_timeout_create"></a> [invocation\_timeout\_create](#input\_invocation\_timeout\_create) | Timeout for ECS invocation creation | `string` | `"5m"` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Name of the security group | `string` | `"wordpress-sg"` | no |
| <a name="input_security_group_rules"></a> [security\_group\_rules](#input\_security\_group\_rules) | Map of security group rules to create | <pre>map(object({<br>    type        = string<br>    ip_protocol = string<br>    port_range  = string<br>    cidr_ip     = string<br>  }))</pre> | <pre>{<br>  "http": {<br>    "cidr_ip": "0.0.0.0/0",<br>    "ip_protocol": "tcp",<br>    "port_range": "80/80",<br>    "type": "ingress"<br>  },<br>  "https": {<br>    "cidr_ip": "0.0.0.0/0",<br>    "ip_protocol": "tcp",<br>    "port_range": "443/443",<br>    "type": "ingress"<br>  }<br>}</pre> | no |
| <a name="input_system_disk_category"></a> [system\_disk\_category](#input\_system\_disk\_category) | System disk category for the ECS instance | `string` | `"cloud_essd"` | no |
| <a name="input_vpc_cidr_block"></a> [vpc\_cidr\_block](#input\_vpc\_cidr\_block) | CIDR block for the VPC | `string` | `"192.168.0.0/16"` | no |
| <a name="input_vpc_name"></a> [vpc\_name](#input\_vpc\_name) | Name of the VPC | `string` | `"wordpress-vpc"` | no |
| <a name="input_vswitch_cidr_block"></a> [vswitch\_cidr\_block](#input\_vswitch\_cidr\_block) | CIDR block for the VSwitch | `string` | `"192.168.0.0/24"` | no |
| <a name="input_vswitch_name"></a> [vswitch\_name](#input\_vswitch\_name) | Name of the VSwitch | `string` | `"wordpress-vsw"` | no |
| <a name="input_zone_id"></a> [zone\_id](#input\_zone\_id) | Availability zone ID for the VSwitch | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_command_id"></a> [command\_id](#output\_command\_id) | The ID of the ECS command |
| <a name="output_instance_id"></a> [instance\_id](#output\_instance\_id) | The ID of the ECS instance |
| <a name="output_instance_name"></a> [instance\_name](#output\_instance\_name) | The name of the ECS instance |
| <a name="output_instance_private_ip"></a> [instance\_private\_ip](#output\_instance\_private\_ip) | The private IP address of the ECS instance |
| <a name="output_instance_public_ip"></a> [instance\_public\_ip](#output\_instance\_public\_ip) | The public IP address of the ECS instance |
| <a name="output_invocation_id"></a> [invocation\_id](#output\_invocation\_id) | The ID of the ECS invocation |
| <a name="output_security_group_id"></a> [security\_group\_id](#output\_security\_group\_id) | The ID of the security group |
| <a name="output_security_group_name"></a> [security\_group\_name](#output\_security\_group\_name) | The name of the security group |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | The ID of the VPC |
| <a name="output_vpc_name"></a> [vpc\_name](#output\_vpc\_name) | The name of the VPC |
| <a name="output_vswitch_id"></a> [vswitch\_id](#output\_vswitch\_id) | The ID of the VSwitch |
| <a name="output_vswitch_name"></a> [vswitch\_name](#output\_vswitch\_name) | The name of the VSwitch |
| <a name="output_wordpress_url"></a> [wordpress\_url](#output\_wordpress\_url) | WordPress default access URL |
<!-- END_TF_DOCS -->

## Submit Issues

If you have any problems while using this module, please submit an
[provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) to let us know.

**Note:** Issues are not recommended to be submitted on this repository.

## Authors

Created and maintained by the Alibaba Cloud Terraform team (terraform@alibabacloud.com).

## License

MIT License. See [LICENSE](LICENSE) for full details.

## Reference

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)