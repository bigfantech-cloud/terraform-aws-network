# BigFantech-Cloud

We automate your infrastructure.
You will have full control of your infrastructure, including Infrastructure as Code (IaC).

To hire, email: `bigfantech@yahoo.com`

# Purpose of this code

> Terraform module

- Create VPC, Internet Gateway, Subnet, EIP, NAT gateway, Route Table.

## Required Providers

| Name                | Description |
| ------------------- | ----------- |
| aws (hashicorp/aws) | >= 4.47     |

## Variables

### Required Variables

| Name           | Description                          | Default |
| -------------- | ------------------------------------ | ------- |
| `project_name` |                                      |         |
| `environment`  |                                      |         |
| `cidr_block`   | VPC CIDR block (example:10.0.0.0/16) |         |

### Optional Variables

| Name                                              | Description                                                                                                                                                                                                                           | Default          |
| ------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ---------------- |
| `public_subnets_cidr`                             | List of custom public subnet CIDRs. Number of CIDR = Number of public subnets created. To not create Public subnets, set public_subnets_cidr = []. If this variable value not provided, subnets are created with auto generated CIDRs | []               |
| `private_subnets_cidr`                            | List of custom private subnet CIDRs. Number of CIDR = Number of private subnets created. If this variable value not provided, subnets are created with auto generated CIDRs                                                           | []               |
| `nat_gateway_enabled`                             | Set as "true" to create NAT gateway, and allocated EIP                                                                                                                                                                                | false            |
| `dns_hostnames_enabled`                           | Boolean flag to enable/disable DNS hostnames in the VPC                                                                                                                                                                               | true             |
| `dns_support_enabled`                             | Boolean flag to enable/disable DNS support in the VPC                                                                                                                                                                                 | true             |
| `instance_tenancy`                                | Tenancy option for instances launched into the VPC                                                                                                                                                                                    | default          |
| `additional_vpc_tags`                             | Map of additional VPC tags                                                                                                                                                                                                            | {}               |
| `additional_public_subnet_tags`                   | Map of additional Public subnet tags                                                                                                                                                                                                  | {}               |
| `additional_private_subnet_tags`                  | Map of additional Private subnet tags                                                                                                                                                                                                 | {}               |
| # VPC FLOW LOG                                    |
| `enable_vpc_flow_log`                             | Whether or not to enable VPC Flow Logs                                                                                                                                                                                                | false            |
| `create_flow_log_cloudwatch_log_group`            | Whether to create CloudWatch log group for VPC Flow Logs                                                                                                                                                                              | true             |
| `create_flow_log_cloudwatch_iam_role`             | Whether to create IAM role for VPC Flow Logs. If set to false, `flow_log_destination_arn` is required                                                                                                                                 | true             |
| `flow_log_destination_type`                       | Type of flow log destination. Can be s3 or cloud-watch-logs                                                                                                                                                                           | cloud-watch-logs |
| `flow_log_cloudwatch_iam_role_arn`                | The ARN for the IAM role to put flow logs to CloudWatch. Required if flow_log_destination_arn is set to custom CloudWatch ARN                                                                                                         |                  |
| `flow_log_destination_arn`                        | The ARN of the CloudWatch log group or S3 bucket to put VPC flow logs. Required if create_flow_log_cloudwatch_log_group is set to false                                                                                               |                  |
| `flow_log_log_format`                             | he fields to include in the flow log record, in the order in which they should appear                                                                                                                                                 | null             |
| `flow_log_traffic_type`                           | The type of traffic to capture. Valid values: ACCEPT, REJECT, ALL                                                                                                                                                                     | ALL              |
| `flow_log_cloudwatch_log_group_retention_in_days` | Specifies the number of days you want to retain log events in the specified log group for VPC flow logs                                                                                                                               | 365              |
| `flow_log_cloudwatch_log_group_kms_key_id`        | The ARN of the KMS Key to use when encrypting log data for VPC flow logs                                                                                                                                                              | null             |
| `flow_log_max_aggregation_interval`               | The maximum interval of time during which a flow of packets is captured and aggregated into a flow log record. Valid Values: `60` seconds or `600` seconds                                                                            | 600              |
| # FLOW LOG TO S3                                  |
| `flow_log_file_format`                            | The format for the flow log. Valid values: `plain-text`, `parquet`                                                                                                                                                                    | plain-text       |
| `flow_log_hive_compatible_partitions`             | Indicates whether to use Hive-compatible prefixes for flow logs stored in Amazon S3                                                                                                                                                   | false            |
| `flow_log_per_hour_partition`                     | Indicates whether to partition the flow log per hour. This reduces the cost and response time for queries                                                                                                                             | false            |

### Example config

> Check the `example` folder in this repo

### Outputs

| Name                 | Description                             |
| -------------------- | --------------------------------------- |
| `vpc_id`             | VPC ID                                  |
| `vpc_cidr_block`     | The primary IPv4 CIDR block of the VPC  |
| `igw_id`             | IGW ID                                  |
| `public_subnet_ids`  | List of the created public subnets IDs  |
| `private_subnet_ids` | List of the created private subnets IDs |
| `eip_id`             | ElasticIP ID                            |
| `ngw_id`             | NAT Gateway ID                          |
