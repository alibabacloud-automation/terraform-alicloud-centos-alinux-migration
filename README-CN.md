# Terraform 阿里云 CentOS 到 Alinux 操作系统迁移模块

terraform-alicloud-centos-alinux-migration

======================================

[English](https://github.com/alibabacloud-automation/terraform-alicloud-centos-alinux-migration/blob/main/README.md) | 简体中文

本 Terraform 模块实现了[CentOS到Alinux操作系统迁移](https://www.aliyun.com/solution/tech-solution/centos-alinux)解决方案，涉及专有网络（VPC）、交换机（VSwitch）、云服务器（ECS）等资源的创建和部署，以及在 CentOS 7 系统上自动安装 WordPress。

该模块创建完整的基础设施设置，包括：
- 用于网络隔离的 VPC 和 VSwitch
- 带有 HTTP/HTTPS 访问规则的安全组
- 使用 CentOS 7 镜像的 ECS 实例
- 通过 ECS 命令和调用实现的自动化 WordPress 安装

## 用法

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

  # 网络配置
  zone_id              = data.alicloud_zones.default.zones[0].id
  vpc_name             = "centos-migration-vpc"
  vpc_cidr_block       = "192.168.0.0/16"
  vswitch_name         = "centos-migration-vsw"
  vswitch_cidr_block   = "192.168.0.0/24"

  # 安全配置
  security_group_name = "centos-migration-sg"

  # ECS 配置
  instance_name        = "centos-wordpress-server"
  image_id            = data.alicloud_images.centos.images[0].id
  instance_type       = data.alicloud_instance_types.default.instance_types[0].id
  ecs_instance_password = "YourPassword123!"
  
  # 数据库配置
  db_password = "DatabasePassword123!"
}
```

## 示例

* [完整示例](https://github.com/alibabacloud-automation/terraform-alicloud-centos-alinux-migration/tree/main/examples/complete)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_alicloud"></a> [alicloud](#requirement\_alicloud) | >= 1.220.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_alicloud"></a> [alicloud](#provider\_alicloud) | >= 1.220.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [alicloud_ecs_command.wordpress_install](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_command) | resource |
| [alicloud_ecs_invocation.wordpress_install](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/ecs_invocation) | resource |
| [alicloud_instance.ecs_instance](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/instance) | resource |
| [alicloud_security_group.security_group](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group) | resource |
| [alicloud_security_group_rule.http_ingress](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_security_group_rule.https_ingress](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/security_group_rule) | resource |
| [alicloud_vpc.vpc](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vpc) | resource |
| [alicloud_vswitch.vswitch](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs/resources/vswitch) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_command_description"></a> [command\_description](#input\_command\_description) | Description of the ECS command | `string` | `"Install WordPress on CentOS 7"` | no |
| <a name="input_command_name"></a> [command\_name](#input\_command\_name) | Name of the ECS command | `string` | `"wordpress-install"` | no |
| <a name="input_command_timeout"></a> [command\_timeout](#input\_command\_timeout) | Timeout for the ECS command execution in seconds | `number` | `7200` | no |
| <a name="input_command_type"></a> [command\_type](#input\_command\_type) | Type of the ECS command | `string` | `"RunShellScript"` | no |
| <a name="input_command_working_dir"></a> [command\_working\_dir](#input\_command\_working\_dir) | Working directory for the ECS command | `string` | `"/root"` | no |
| <a name="input_db_password"></a> [db\_password](#input\_db\_password) | Database user password, 8-32 characters, must include uppercase letters, lowercase letters, special characters and numbers | `string` | n/a | yes |
| <a name="input_ecs_instance_password"></a> [ecs\_instance\_password](#input\_ecs\_instance\_password) | Password for the ECS instance login, 8-30 characters, must include three types (uppercase letters, lowercase letters, numbers, special symbols) | `string` | n/a | yes |
| <a name="input_http_rule_cidr_ip"></a> [http\_rule\_cidr\_ip](#input\_http\_rule\_cidr\_ip) | CIDR IP for HTTP security group rule | `string` | `"0.0.0.0/0"` | no |
| <a name="input_http_rule_ip_protocol"></a> [http\_rule\_ip\_protocol](#input\_http\_rule\_ip\_protocol) | IP protocol for HTTP security group rule | `string` | `"tcp"` | no |
| <a name="input_http_rule_port_range"></a> [http\_rule\_port\_range](#input\_http\_rule\_port\_range) | Port range for HTTP security group rule | `string` | `"80/80"` | no |
| <a name="input_http_rule_type"></a> [http\_rule\_type](#input\_http\_rule\_type) | Type of the HTTP security group rule | `string` | `"ingress"` | no |
| <a name="input_https_rule_cidr_ip"></a> [https\_rule\_cidr\_ip](#input\_https\_rule\_cidr\_ip) | CIDR IP for HTTPS security group rule | `string` | `"0.0.0.0/0"` | no |
| <a name="input_https_rule_ip_protocol"></a> [https\_rule\_ip\_protocol](#input\_https\_rule\_ip\_protocol) | IP protocol for HTTPS security group rule | `string` | `"tcp"` | no |
| <a name="input_https_rule_port_range"></a> [https\_rule\_port\_range](#input\_https\_rule\_port\_range) | Port range for HTTPS security group rule | `string` | `"443/443"` | no |
| <a name="input_https_rule_type"></a> [https\_rule\_type](#input\_https\_rule\_type) | Type of the HTTPS security group rule | `string` | `"ingress"` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | Image ID for the ECS instance | `string` | n/a | yes |
| <a name="input_instance_name"></a> [instance\_name](#input\_instance\_name) | Name of the ECS instance | `string` | `"wordpress-ecs"` | no |
| <a name="input_instance_type"></a> [instance\_type](#input\_instance\_type) | Instance type for the ECS instance | `string` | n/a | yes |
| <a name="input_internet_max_bandwidth_out"></a> [internet\_max\_bandwidth\_out](#input\_internet\_max\_bandwidth\_out) | Maximum outgoing bandwidth to the public network | `number` | `5` | no |
| <a name="input_invocation_timeout_create"></a> [invocation\_timeout\_create](#input\_invocation\_timeout\_create) | Timeout for ECS invocation creation | `string` | `"5m"` | no |
| <a name="input_security_group_name"></a> [security\_group\_name](#input\_security\_group\_name) | Name of the security group | `string` | `"wordpress-sg"` | no |
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

## 提交问题

如果您在使用此模块时遇到任何问题，请提交
[provider issue](https://github.com/aliyun/terraform-provider-alicloud/issues/new) 让我们知道。

**注意：** 不建议在此仓库上提交问题。

## 作者

由阿里云 Terraform 团队创建和维护 (terraform@alibabacloud.com)。

## 许可证

MIT 许可。详细信息请参见 LICENSE。

## 参考

* [Terraform-Provider-Alicloud Github](https://github.com/aliyun/terraform-provider-alicloud)
* [Terraform-Provider-Alicloud Release](https://releases.hashicorp.com/terraform-provider-alicloud/)
* [Terraform-Provider-Alicloud Docs](https://registry.terraform.io/providers/aliyun/alicloud/latest/docs)