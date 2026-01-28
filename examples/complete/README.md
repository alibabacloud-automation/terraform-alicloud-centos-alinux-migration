# Complete Example

This example demonstrates the complete usage of the CentOS to Alinux migration module.

## Usage

To run this example you need to execute:

```bash
$ terraform init
$ terraform plan
$ terraform apply
```

Note that this example may create resources which cost money. Run `terraform destroy` when you don't need these resources.

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.0 |
| alicloud | >= 1.220.0 |

## Providers

| Name | Version |
|------|---------|
| alicloud | >= 1.220.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| region | The region where to deploy the resources | `string` | `"cn-hangzhou"` | no |
| instance_type | The instance type for ECS instance | `string` | `"ecs.g7.large"` | no |
| vpc_name | Name of the VPC | `string` | `"centos-migration-vpc"` | no |
| vpc_cidr_block | CIDR block for the VPC | `string` | `"192.168.0.0/16"` | no |
| vswitch_name | Name of the VSwitch | `string` | `"centos-migration-vsw"` | no |
| vswitch_cidr_block | CIDR block for the VSwitch | `string` | `"192.168.0.0/24"` | no |
| security_group_name | Name of the security group | `string` | `"centos-migration-sg"` | no |
| instance_name | Name of the ECS instance | `string` | `"centos-wordpress-server"` | no |
| ecs_instance_password | Password for the ECS instance login | `string` | n/a | yes |
| db_password | Database user password | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | The ID of the VPC |
| vswitch_id | The ID of the VSwitch |
| security_group_id | The ID of the security group |
| instance_id | The ID of the ECS instance |
| instance_public_ip | The public IP address of the ECS instance |
| wordpress_url | WordPress default access URL |