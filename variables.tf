#------
# VPC 
#------

variable "cidr_block" {
  description = "Enter the VPC CIDR block"
}

variable "instance_tenancy" {
  type        = string
  description = "A tenancy option for instances launched into the VPC"
  default     = "default"
  validation {
    condition     = contains(["default", "dedicated", "host"], var.instance_tenancy)
    error_message = "Instance tenancy must be one of \"default\", \"dedicated\", or \"host\"."
  }
}

variable "dns_hostnames_enabled" {
  type        = bool
  description = "A boolean flag to enable/disable DNS hostnames in the VPC"
  default     = true
}

variable "dns_support_enabled" {
  type        = bool
  description = "A boolean flag to enable/disable DNS support in the VPC"
  default     = true
}

variable "additional_vpc_tags" {
  description = "Map of additional VPC tags"
  type        = map(any)
  default     = {}
}


#---------
# SUBNET
#---------

variable "public_subnets_cidr" {
  description = "List of public subnet CIDRs. Number of CIDR = Number of public subnets created"
  # Default is set to `null` to make it possible to not create public subnet
  # by setting variable value public_subnets_cidr = []
  default = null
}

variable "additional_public_subnet_tags" {
  description = "Map of additional Public subnet tags"
  type        = map(any)
  default     = {}
}

variable "private_subnets_cidr" {
  description = "List of private subnet CIDRs. Number of CIDR = Number of private subnets created"
  type        = list(string)
  default     = []
}

variable "additional_private_subnet_tags" {
  description = "Map of additional Private subnet tags"
  type        = map(any)
  default     = {}
}

variable "nat_gateway_enabled" {
  description = "Flag to enable/disable one NAT Gateway creation in public subnet"
  default     = "false"
}

#----
# VPC FLOW LOG
#----

variable "enable_vpc_flow_log" {
  description = "Whether or not to enable VPC Flow Logs. Default = false"
  type        = bool
  default     = false
}

variable "create_flow_log_cloudwatch_log_group" {
  description = "Whether to create CloudWatch log group for VPC Flow Logs. Default = true"
  type        = bool
  default     = true
}

variable "create_flow_log_cloudwatch_iam_role" {
  description = "Whether to create IAM role for VPC Flow Logs. Default = true"
  type        = bool
  default     = true
}

variable "flow_log_destination_type" {
  description = "Type of flow log destination. Can be s3 or cloud-watch-logs. Default = cloud-watch-logs"
  type        = string
  default     = "cloud-watch-logs"
}

variable "flow_log_destination_arn" {
  description = "The ARN of the CloudWatch log group or S3 bucket to put VPC flow logs. Required if create_flow_log_cloudwatch_log_group is set to false."
  type        = string
  default     = ""
}

variable "flow_log_cloudwatch_iam_role_arn" {
  description = "The ARN for the IAM role to put flow logs to CloudWatch. Required if flow_log_destination_arn is set to custom CloudWatch ARN"
  type        = string
  default     = ""
}

variable "flow_log_log_format" {
  description = "The fields to include in the flow log record, in the order in which they should appear. Default = null"
  type        = string
  default     = null
}

variable "flow_log_traffic_type" {
  description = "The type of traffic to capture. Valid values: ACCEPT, REJECT, ALL. Default = ALL"
  type        = string
  default     = "ALL"
}

variable "flow_log_cloudwatch_log_group_retention_in_days" {
  description = "Specifies the number of days you want to retain log events in the specified log group for VPC flow logs. Default = 365"
  type        = number
  default     = 365
}

variable "flow_log_cloudwatch_log_group_kms_key_id" {
  description = "The ARN of the KMS Key to use when encrypting log data for VPC flow logs. Default = null"
  type        = string
  default     = null
}

variable "flow_log_max_aggregation_interval" {
  description = "The maximum interval of time during which a flow of packets is captured and aggregated into a flow log record. Valid Values: `60` seconds or `600` seconds. Default = 600"
  type        = number
  default     = 600
}

# FLOW LOG TO S3

variable "flow_log_file_format" {
  description = "(Optional) The format for the flow log. Valid values: `plain-text`, `parquet`."
  type        = string
  default     = "plain-text"
  validation {
    condition = can(regex("^(plain-text|parquet)$",
    var.flow_log_file_format))
    error_message = "ERROR valid values: plain-text, parquet."
  }
}

variable "flow_log_hive_compatible_partitions" {
  description = "(Optional) Indicates whether to use Hive-compatible prefixes for flow logs stored in Amazon S3."
  type        = bool
  default     = false
}

variable "flow_log_per_hour_partition" {
  description = "(Optional) Indicates whether to partition the flow log per hour. This reduces the cost and response time for queries."
  type        = bool
  default     = false
}
