# Day 63 -- Variables, Outputs, Data Sources and Expressions

### Task 1: Extract Variables
Take your Day 62 infrastructure config and refactor it:

1. Create a `variables.tf` file with input variables for:
   - `region` (string, default: your preferred region)
   - `vpc_cidr` (string, default: `"10.0.0.0/16"`)
   - `subnet_cidr` (string, default: `"10.0.1.0/24"`)
   - `instance_type` (string, default: `"t2.micro"`)
   - `project_name` (string, no default -- force the user to provide it)
   - `environment` (string, default: `"dev"`)
   - `allowed_ports` (list of numbers, default: `[22, 80, 443]`)
   - `extra_tags` (map of strings, default: `{}`)

2. Replace every hardcoded value in `main.tf` with `var.<name>` references
   
   [main.tf](./terraform-files/main.tf)

   [variables.tf](./terraform-files/variables.tf)

3. Run `terraform plan` -- it should prompt you for `project_name` since it has no default
   
   ![](Images/Task-1_Step-3.png)

**Document:** What are the five variable types in Terraform? (`string`, `number`, `bool`, `list`, `map`)

 - `string`: used for names, IDs, regions, AMIs, environment names — anything that is plain text.
 - `number`: used for replica counts, port numbers, timeouts, sizes.
 - `bool`: used for feature flags, on/off switches, enabling/disabling options.
 - `list`: used for ports, availability zones, subnet IDs, IP ranges — anything that is a sequence.
 - `map`: used for tags, environment-specific configs, lookup tables.
---

### Task 2: Variable Files and Precedence
1. Create `terraform.tfvars`:
```hcl
project_name = "terraweek"
environment  = "dev"
instance_type = "t2.micro"
```

2. Create `prod.tfvars`:
```hcl
project_name = "terraweek"
environment  = "prod"
instance_type = "t3.small"
vpc_cidr     = "10.1.0.0/16"
subnet_cidr  = "10.1.1.0/24"
```

3. Apply with the default file:
```bash
terraform plan                              # Uses terraform.tfvars automatically
```
[terraform.tfvars](./terraform-files/terraform.tfvars)

![](Images/Task-2_Step-3.png)

![](Images/Task-2_Step-3.1.png)

4. Apply with the prod file:
```bash
terraform plan -var-file="prod.tfvars"      # Uses prod.tfvars

terraform apply -var-file="prod.tfvars" -auto-approve
```
[prod.tfvars](./terraform-files/prod.tfvars)

![](Images/Task-2_Step-4.png)

![](Images/Task-2_Step-4.1.png)

![](Images/Task-2_Step-4.2.png)

5. Override with CLI:
```bash
terraform plan -var="instance_type=t2.nano"  # CLI overrides everything
```
![](Images/Task-2_Step-5.png)

6. Set an environment variable:
```bash
export TF_VAR_environment="staging"
terraform plan                              # env var overrides default but not tfvars
```
![](Images/Task-2_Step-6.2.png)

![](Images/Task-2_Step-6.1.png)

**Document:** Write the variable precedence order from lowest to highest priority.

![](Images/Task-2_Step-6.png)

---

### Task 3: Add Outputs
Create an `outputs.tf` file with outputs for:

1. `vpc_id` -- the VPC ID
2. `subnet_id` -- the public subnet ID
3. `instance_id` -- the EC2 instance ID
4. `instance_public_ip` -- the public IP of the EC2 instance
5. `instance_public_dns` -- the public DNS name
6. `security_group_id` -- the security group ID

Apply your config and verify the outputs are printed at the end:
```bash
terraform apply

# After apply, you can also run:
terraform output                          # Show all outputs
terraform output instance_public_ip       # Show a specific output
terraform output -json                    # JSON format for scripting
```

![](Images/Task-3_Step-1.png)

![](Images/Task-3_Step-2.png)

[output.json](./terraform-files/output.json)

![](Images/Task-3_Step-3.png)

**Verify:** Does `terraform output instance_public_ip` return the correct IP?

![](Images/Task-3_Step-4.png)

---

### Task 4: Use Data Sources
Stop hardcoding the AMI ID. Use a data source to fetch it dynamically.

1. Add a `data "aws_ami"` block that:
   - Filters for Amazon Linux 2 images
   - Filters for `hvm` virtualization and `gp2` root device
   - Uses `owners = ["amazon"]`
   - Sets `most_recent = true`

2. Replace the hardcoded AMI in your `aws_instance` with `data.aws_ami.amazon_linux.id`

3. Add a `data "aws_availability_zones"` block to fetch available AZs in your region

4. Use the first AZ in your subnet: `data.aws_availability_zones.available.names[0]`

[task-4_main.tf](./terraform-files/task-4_main.tf)

[outputs.tf](./terraform-files/outputs.tf)

Apply and verify -- your config now works in any region without changing the AMI.

![](Images/Task-4_Step-1.png)

![](IMages/Task-4_Step-2.png)

**Document:** What is the difference between a `resource` and a `data` source?

 - `resource`: it's a block tells Terraform to create and manage a piece of infrastructure. Terraform owns its full lifecycle — create, update, and destroy.

 - `data`: it's a block tells Terraform to read and fetch information about something that already exists. Terraform never creates, modifies, or destroys it.
    
    |                        | `resource`                   | `data`                         |
    | ---------------------- | ---------------------------- | ------------------------------ |
    | **Purpose**            | Create infrastructure        | Read existing infrastructure   |
    | **Lifecycle**          | Terraform manages fully      | Read-only, never touched       |
    | **On `apply`**         | Creates/updates the resource | Fetches the latest value       |
    | **On `destroy`**       | Deletes the resource         | Nothing happens                |
    | **State tracking**     | Yes — full state tracked     | Only cached for reference      |
    | **Syntax prefix**      | `aws_vpc.main.id`            | `data.aws_ami.amazon_linux.id` |
    | **Real world analogy** | Building a new house         | Looking up an existing address |
---

### Task 5: Use Locals for Dynamic Values
1. Add a `locals` block:
```hcl
locals {
  name_prefix = "${var.project_name}-${var.environment}"
  common_tags = {
    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
```

2. Replace all Name tags with `local.name_prefix`:
   - VPC: `"${local.name_prefix}-vpc"`
   - Subnet: `"${local.name_prefix}-subnet"`
   - Instance: `"${local.name_prefix}-server"`

3. Merge common tags with resource-specific tags:
```hcl
tags = merge(local.common_tags, {
  Name = "${local.name_prefix}-server"
})
```
Apply and check the tags in the AWS console -- every resource should have consistent tagging.

[task-5_main.tf](./terraform-files/task-5_main.tf)

![](Images/Task-5_Step-1.png)

![](Images/Task-5_Step-2.png)

---

### Task 6: Built-in Functions and Conditional Expressions
Practice these in `terraform console`:
```bash
terraform console
```

1. **String functions:**
   - `upper("terraweek")` -> `"TERRAWEEK"`
   - `join("-", ["terra", "week", "2026"])` -> `"terra-week-2026"`
   - `format("arn:aws:s3:::%s", "my-bucket")`

2. **Collection functions:**
   - `length(["a", "b", "c"])` -> `3`
   - `lookup({dev = "t2.micro", prod = "t3.small"}, "dev")` -> `"t2.micro"`
   - `toset(["a", "b", "a"])` -> removes duplicates

3. **Networking function:**
   - `cidrsubnet("10.0.0.0/16", 8, 1)` -> `"10.0.1.0/24"`

4. **Conditional expression** -- add this to your config:
```hcl
instance_type = var.environment == "prod" ? "t3.small" : "t2.micro"
```
Apply with `environment = "prod"` and verify the instance type changes.

`terraform apply -var-file="prod.tfvars"`

![](Images/Task-6_Step-1.png)

**Document:** Pick five functions you find most useful and explain what each does.

---

## Hints
- `terraform.tfvars` is loaded automatically. Any other `.tfvars` file needs `-var-file`
- Variable precedence (low to high): default -> `terraform.tfvars` -> `*.auto.tfvars` -> `-var-file` -> `-var` flag -> `TF_VAR_*` env vars
- `terraform console` is an interactive REPL for testing expressions and functions
- Data sources are read-only -- they fetch information, they don't create resources
- `merge()` combines two maps -- great for tags
- `terraform output -json` is useful when piping output into other scripts

---

## Documentation
Create `day-63-variables-outputs.md` with:
- Your `variables.tf` with all variable types
- Both `.tfvars` files (dev and prod)
- Screenshot of outputs after `terraform apply`
- Explanation of variable precedence with examples
- Five built-in functions you found most useful
- The difference between `variable`, `local`, `output`, and `data`

---

