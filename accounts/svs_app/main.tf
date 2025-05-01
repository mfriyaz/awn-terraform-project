# Module for creating the SG
module "ftp_mssql_sg" {
  source      = "../../modules/security_group_app_server"
  name        = "ec2-ftp-mssql-access"
  description = "Allow FTP and MSSQL access"
  vpc_id      = "vpc-0770331a6f17a5f46"
  allowed_cidrs = ["192.60.10.0/24"]
  tags = {
    Environment = "SVS_APP"
    ManagedBy   = "Terraform"
  }
}

# Fetch the EC2 instance by ID
data "aws_instance" "free_tier_setup_2024" {
  instance_id = "i-0406fd74a62736614"  # Replace with your actual instance ID
}

# Attach the SG to the instance's primary network interface
resource "aws_network_interface_sg_attachment" "attach_sg" {
  security_group_id    = module.ftp_mssql_sg.security_group_id
  network_interface_id = "eni-05bbe957906a2e8ce"
}
