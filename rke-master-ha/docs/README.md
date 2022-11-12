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
| <a name="provider_terraform"></a> [terraform](#provider\_terraform) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_ec2_master_01"></a> [ec2\_master\_01](#module\_ec2\_master\_01) | terraform-aws-modules/ec2-instance/aws | ~> 4.0 |
| <a name="module_ec2_master_02"></a> [ec2\_master\_02](#module\_ec2\_master\_02) | terraform-aws-modules/ec2-instance/aws | ~> 4.0 |

## Resources

| Name | Type |
|------|------|
| [gandi_livedns_record.rkesandbox-01](https://registry.terraform.io/providers/go-gandi/gandi/latest/docs/resources/livedns_record) | resource |
| [gandi_livedns_record.rkesandbox-02](https://registry.terraform.io/providers/go-gandi/gandi/latest/docs/resources/livedns_record) | resource |
| [aws_vpc.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/vpc) | data source |
| [terraform_remote_state.master-node](https://registry.terraform.io/providers/hashicorp/terraform/latest/docs/data-sources/remote_state) | data source |

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
<!-- END_TF_DOCS -->