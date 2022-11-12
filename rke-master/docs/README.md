<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.0 |
| <a name="requirement_gandi"></a> [gandi](#requirement\_gandi) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.36.1 |
| <a name="provider_gandi"></a> [gandi](#provider\_gandi) | 2.2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ec2_master"></a> [ec2\_master](#module\_ec2\_master) | terraform-aws-modules/ec2-instance/aws | ~> 4.0 |
| <a name="module_security_group_external"></a> [security\_group\_external](#module\_security\_group\_external) | terraform-aws-modules/security-group/aws | ~> 4.0 |
| <a name="module_security_group_internal"></a> [security\_group\_internal](#module\_security\_group\_internal) | terraform-aws-modules/security-group/aws | ~> 4.0 |

## Resources

| Name | Type |
|------|------|
| [aws_eip_association.eip_assoc](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip_association) | resource |
| [gandi_livedns_record.rkesandbox](https://registry.terraform.io/providers/go-gandi/gandi/latest/docs/resources/livedns_record) | resource |
| [aws_availability_zones.available](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |
| [aws_eip.endpoint](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eip) | data source |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ami"></a> [ami](#input\_ami) | Ami used for ec2 | `string` | `"ami-0abb90b1685f9e9fc"` | no |
| <a name="input_aws_access_key"></a> [aws\_access\_key](#input\_aws\_access\_key) | AWS access key | `string` | n/a | yes |
| <a name="input_aws_secret_key"></a> [aws\_secret\_key](#input\_aws\_secret\_key) | AWS secret key | `string` | n/a | yes |
| <a name="input_elastic_ip"></a> [elastic\_ip](#input\_elastic\_ip) | Elastic IP already present on aws region | `string` | `""` | no |
| <a name="input_key"></a> [key](#input\_key) | key used for ec2 | `string` | `"DevelopmentServiceParigi"` | no |
| <a name="input_region"></a> [region](#input\_region) | The aws region | `string` | `"eu-west-3"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | <pre>{<br>  "Environment": "Development",<br>  "Owner": "memyselfandi",<br>  "Project": "Project name"<br>}</pre> | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rke2-master_Instance_id"></a> [rke2-master\_Instance\_id](#output\_rke2-master\_Instance\_id) | Instance ID of rke2 server |
| <a name="output_rke2-master_private_ip_address"></a> [rke2-master\_private\_ip\_address](#output\_rke2-master\_private\_ip\_address) | Private IP of rke2 server |
| <a name="output_rke2-master_public_ip_address"></a> [rke2-master\_public\_ip\_address](#output\_rke2-master\_public\_ip\_address) | Public IP of rke2 server |
| <a name="output_rke2-servers-security_group_external-id"></a> [rke2-servers-security\_group\_external-id](#output\_rke2-servers-security\_group\_external-id) | External Security Grou ID |
| <a name="output_rke2-servers-security_group_internal-id"></a> [rke2-servers-security\_group\_internal-id](#output\_rke2-servers-security\_group\_internal-id) | Internal Security Grou ID |
<!-- END_TF_DOCS -->