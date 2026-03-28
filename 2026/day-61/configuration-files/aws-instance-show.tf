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