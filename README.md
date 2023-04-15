# Purpose:

Create VPC, Internet Gateway, Subnet, EIP, NAT gateway, Route Table.

## Variable Inputs:

#### REQUIRED:

```
- project_name  (ex: project name).
- environment   (ex: dev/prod).
- cidr_block    VPC CIDR block (ex:10.0.0.0/16).
```

#### OPTIONAL:

```
- public_subnets_cidr       List of custom public subnet CIDRs. Number of CIDR = Number of public subnets created
                            To not create Public subnets, set public_subnets_cidr = []
                            If this variable value not provided, subnets are created with auto generated CIDRs.

- private_subnets_cidr      List of custom private subnet CIDRs. Number of CIDR = Number of private subnets created
                            If this variable value not provided, subnets are created with auto generated CIDRs.

- nat_gateway_enabled       Set as "true" to create NAT gateway, and allocated EIP. Default = false.

- enable_flow_log           Whether or not to enable VPC Flow Logs. Default = false.

- dns_hostnames_enabled     Boolean flag to enable/disable DNS hostnames in the VPC. Default = true.

- dns_support_enabled       Boolean flag to enable/disable DNS support in the VPC. Default = true.

- instance_tenancy          Tenancy option for instances launched into the VPC. Default = "default".

# VPC FLOW LOG

- create_flow_log_cloudwatch_log_group    Whether to create CloudWatch log group for VPC Flow Logs. Default = true.

- create_flow_log_cloudwatch_iam_role     Whether to create IAM role for VPC Flow Logs. Default = true.

- flow_log_destination_type               Type of flow log destination. Can be s3 or cloud-watch-logs. Default = cloud-watch-logs".

- flow_log_destination_arn                The ARN of the CloudWatch log group or S3 bucket to put VPC flow logs. Required if create_flow_log_cloudwatch_log_group is set to false.

- flow_log_cloudwatch_iam_role_arn        The ARN for the IAM role to put flow logs to CloudWatch. Required if flow_log_destination_arn is set to custom CloudWatch ARN.

- flow_log_log_format                     The fields to include in the flow log record, in the order in which they should appear. Default = null.

- flow_log_traffic_type                   The type of traffic to capture. Valid values: ACCEPT, REJECT, ALL. Default = ALL.

- flow_log_cloudwatch_log_group_retention_in_days
    Specifies the number of days you want to retain log events in the specified log group for VPC flow logs. Default = 365.

- flow_log_cloudwatch_log_group_kms_key_id
    The ARN of the KMS Key to use when encrypting log data for VPC flow logs. Default = null.

- flow_log_max_aggregation_interval
    The maximum interval of time during which a flow of packets is captured and aggregated into a flow log record. Valid Values: `60` seconds or `600` seconds. Default = 600.

# FLOW LOG TO S3

- flow_log_file_format                The format for the flow log. Valid values: `plain-text`, `parquet`. Default = "plain-text".

- flow_log_hive_compatible_partitions Indicates whether to use Hive-compatible prefixes for flow logs stored in Amazon S3. Default = false.

- flow_log_per_hour_partition         Indicates whether to partition the flow log per hour. This reduces the cost and response time for queries. Default     = false.
```

## Major resources created:

- VPC. [1]
- Internet Gateway. [1]
- Subnet. [A set of public, private subnet per AZ]
- Route Table. [2: public, private]
- Elastic IP. [1] (created if NAT gateway is enabled)
- NAT gateway. [1] (created if NAT gateway is enabled)
- VPC flow log. (created if VPN flow log is enabled)

# Steps to create the resources

1. Call the module from your tf code.
2. Specify variable inputs.

Example:

```
provider "aws" {
  region = "us-east-1"
}

module "network" {
  source        = "app.terraform.io/bigfantech/network/aws"
  version       = "1.0.0"

  project_name  = "abc"
  environment   = "dev"
  cidr_block    = "10.0.0.0/16"
}
```

3. Apply: From terminal run following commands.

```
terraform init
```

```
terraform plan
```

```
terraform apply
```

!! You have successfully network components as per your specification !!

---

## OUTPUTS

```
- vpc_id:
    The ID of the VPC

- vpc_arn:
    The ARN of the VPC

- vpc_cidr_block:
    The primary IPv4 CIDR block of the VPC

- igw_id:
    IGW ID

- public_subnet_ids:
    List of the created public subnets IDs

- private_subnet_ids:
    List of the created private subnets IDs

- eip_id:
    ElasticIP ID

- ngw_id:
    NAT Gateway ID
```
