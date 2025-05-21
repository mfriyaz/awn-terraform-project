# Module for creating the SG
module "osis_mssql_sg" {
  source      = "../../modules/security_group"
  name        = "ec2-mssql-access"
  description = "Allow MSSQL access"
  vpc_id      = "vpc-01541d8a67c16ca49"
  allowed_cidrs = ["106.219.179.220/32"]
  tags = {
    Environment = "OSIS_DB"
    ManagedBy   = "Terraform"
  }
}

# Fetch the EC2 instance by ID
data "aws_instance" "free_tier_setup_2024" {
  instance_id = "i-05fda7facb514c076"  # Replace with your actual instance ID
}

# Attach the SG to the instance's primary network interface
resource "aws_network_interface_sg_attachment" "attach_sg" {
  security_group_id    = module.osis_mssql_sg.security_group_id
  network_interface_id = "eni-07f4be0e03bbb9dc3"
}