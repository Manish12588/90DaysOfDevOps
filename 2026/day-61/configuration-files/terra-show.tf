# aws_default_vpc.default:
resource "aws_default_vpc" "default" {
    arn                                  = "arn:aws:ec2:us-west-2:510720290540:vpc/vpc-032bacc776f370df7"
    assign_generated_ipv6_cidr_block     = false
    cidr_block                           = "172.31.0.0/16"
    default_network_acl_id               = "acl-06343935ea07e7cba"
    default_route_table_id               = "rtb-01ef64acd9b2afba9"
    default_security_group_id            = "sg-045a2fda97c315a21"
    dhcp_options_id                      = "dopt-08ea3e73ee02df032"
    enable_dns_hostnames                 = true
    enable_dns_support                   = true
    enable_network_address_usage_metrics = false
    existing_default_vpc                 = true
    force_destroy                        = false
    id                                   = "vpc-032bacc776f370df7"
    instance_tenancy                     = "default"
    ipv6_association_id                  = null
    ipv6_cidr_block                      = null
    ipv6_cidr_block_network_border_group = null
    ipv6_ipam_pool_id                    = null
    ipv6_netmask_length                  = 0
    main_route_table_id                  = "rtb-01ef64acd9b2afba9"
    owner_id                             = "510720290540"
    region                               = "us-west-2"
    tags                                 = {}
    tags_all                             = {}
}

# aws_instance.terra_ec2_instance:
resource "aws_instance" "terra_ec2_instance" {
    ami                                  = "ami-0d76b909de1a0595d"
    arn                                  = "arn:aws:ec2:us-west-2:510720290540:instance/i-0d23de18be20eadd9"
    associate_public_ip_address          = true
    availability_zone                    = "us-west-2a"
    disable_api_stop                     = false
    disable_api_termination              = false
    ebs_optimized                        = false
    force_destroy                        = false
    get_password_data                    = false
    hibernation                          = false
    host_id                              = null
    iam_instance_profile                 = null
    id                                   = "i-0d23de18be20eadd9"
    instance_initiated_shutdown_behavior = "stop"
    instance_lifecycle                   = null
    instance_state                       = "running"
    instance_type                        = "t3.micro"
    ipv6_address_count                   = 0
    ipv6_addresses                       = []
    key_name                             = "terra-challange-key"
    monitoring                           = false
    outpost_arn                          = null
    password_data                        = null
    placement_group                      = null
    placement_group_id                   = null
    placement_partition_number           = 0
    primary_network_interface_id         = "eni-03a3403eea13201df"
    private_dns                          = "ip-172-31-37-117.us-west-2.compute.internal"
    private_ip                           = "172.31.37.117"
    public_dns                           = "ec2-34-209-169-234.us-west-2.compute.amazonaws.com"
    public_ip                            = "34.209.169.234"
    region                               = "us-west-2"
    secondary_private_ips                = []
    security_groups                      = [
        "terra-security-group",
    ]
    source_dest_check                    = true
    spot_instance_request_id             = null
    subnet_id                            = "subnet-001685eff434a2cde"
    tags                                 = {
        "Name" = "TerraWeek-Day1"
    }
    tags_all                             = {
        "Name" = "TerraWeek-Day1"
    }
    tenancy                              = "default"
    user_data_replace_on_change          = false
    vpc_security_group_ids               = [
        "sg-0ce9616f8c418687d",
    ]

    capacity_reservation_specification {
        capacity_reservation_preference = "open"
    }

    cpu_options {
        amd_sev_snp           = null
        core_count            = 1
        nested_virtualization = null
        threads_per_core      = 2
    }

    credit_specification {
        cpu_credits = "unlimited"
    }

    enclave_options {
        enabled = false
    }

    maintenance_options {
        auto_recovery = "default"
    }

    metadata_options {
        http_endpoint               = "enabled"
        http_protocol_ipv6          = "disabled"
        http_put_response_hop_limit = 2
        http_tokens                 = "required"
        instance_metadata_tags      = "disabled"
    }

    primary_network_interface {
        delete_on_termination = true
        network_interface_id  = "eni-03a3403eea13201df"
    }

    private_dns_name_options {
        enable_resource_name_dns_a_record    = false
        enable_resource_name_dns_aaaa_record = false
        hostname_type                        = "ip-name"
    }

    root_block_device {
        delete_on_termination = true
        device_name           = "/dev/sda1"
        encrypted             = false
        iops                  = 3000
        kms_key_id            = null
        tags                  = {}
        tags_all              = {}
        throughput            = 125
        volume_id             = "vol-07abfabad7b9748c8"
        volume_size           = 10
        volume_type           = "gp3"
    }
}

# aws_key_pair.terra_key_pair:
resource "aws_key_pair" "terra_key_pair" {
    arn             = "arn:aws:ec2:us-west-2:510720290540:key-pair/terra-challange-key"
    fingerprint     = "+4eaTjEfgBSFzCLOmE6Mx+KtlMGYw8MAeC+XzGLRENw="
    id              = "terra-challange-key"
    key_name        = "terra-challange-key"
    key_name_prefix = null
    key_pair_id     = "key-02f75727f51bd9f73"
    key_type        = "ed25519"
    public_key      = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILvAi7s3BmiO8GeJL+0vJUwkLwYlp+HEANB+kM3dvTYR ubuntu@ip-172-31-45-223"
    region          = "us-west-2"
    tags            = {}
    tags_all        = {}
}

# aws_s3_bucket.s3_bucket:
resource "aws_s3_bucket" "s3_bucket" {
    acceleration_status         = null
    arn                         = "arn:aws:s3:::terraweek-manish-2026"
    bucket                      = "terraweek-manish-2026"
    bucket_domain_name          = "terraweek-manish-2026.s3.amazonaws.com"
    bucket_namespace            = "global"
    bucket_prefix               = null
    bucket_region               = "us-west-2"
    bucket_regional_domain_name = "terraweek-manish-2026.s3.us-west-2.amazonaws.com"
    force_destroy               = false
    hosted_zone_id              = "Z3BJ6K6RIION7M"
    id                          = "terraweek-manish-2026"
    object_lock_enabled         = false
    policy                      = null
    region                      = "us-west-2"
    request_payer               = "BucketOwner"
    tags_all                    = {}

    grant {
        id          = "f5325d8a0cbc47e588ced29f82f8c60c9e48ad67a5b419d4fea84a3473a3a1d5"
        permissions = [
            "FULL_CONTROL",
        ]
        type        = "CanonicalUser"
        uri         = null
    }

    server_side_encryption_configuration {
        rule {
            bucket_key_enabled = false

            apply_server_side_encryption_by_default {
                kms_master_key_id = null
                sse_algorithm     = "AES256"
            }
        }
    }

    versioning {
        enabled    = false
        mfa_delete = false
    }
}

# aws_security_group.terra_security_group:
resource "aws_security_group" "terra_security_group" {
    arn                    = "arn:aws:ec2:us-west-2:510720290540:security-group/sg-0ce9616f8c418687d"
    description            = "This is inbound and outbound rules of your instance"
    egress                 = []
    id                     = "sg-0ce9616f8c418687d"
    ingress                = [
        {
            cidr_blocks      = [
                "172.31.0.0/16",
            ]
            description      = null
            from_port        = 22
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 22
        },
        {
            cidr_blocks      = [
                "172.31.0.0/16",
            ]
            description      = null
            from_port        = 80
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 80
        },
    ]
    name                   = "terra-security-group"
    name_prefix            = null
    owner_id               = "510720290540"
    region                 = "us-west-2"
    revoke_rules_on_delete = false
    tags                   = {}
    tags_all               = {}
    vpc_id                 = "vpc-032bacc776f370df7"
}

# aws_vpc_security_group_ingress_rule.security_inbound_rule:
resource "aws_vpc_security_group_ingress_rule" "security_inbound_rule" {
    arn                    = "arn:aws:ec2:us-west-2:510720290540:security-group-rule/sgr-05df6ff433d980865"
    cidr_ipv4              = "172.31.0.0/16"
    from_port              = 80
    id                     = "sgr-05df6ff433d980865"
    ip_protocol            = "tcp"
    region                 = "us-west-2"
    security_group_id      = "sg-0ce9616f8c418687d"
    security_group_rule_id = "sgr-05df6ff433d980865"
    tags_all               = {}
    to_port                = 80
}

# aws_vpc_security_group_ingress_rule.security_outbound_rule:
resource "aws_vpc_security_group_ingress_rule" "security_outbound_rule" {
    arn                    = "arn:aws:ec2:us-west-2:510720290540:security-group-rule/sgr-0a2938616454fcd78"
    cidr_ipv4              = "172.31.0.0/16"
    from_port              = 22
    id                     = "sgr-0a2938616454fcd78"
    ip_protocol            = "tcp"
    region                 = "us-west-2"
    security_group_id      = "sg-0ce9616f8c418687d"
    security_group_rule_id = "sgr-0a2938616454fcd78"
    tags_all               = {}
    to_port                = 22
}