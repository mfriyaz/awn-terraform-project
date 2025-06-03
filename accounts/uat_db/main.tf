# Module for creating the SG
module "ftp_mssql_sg" {
  source      = "../../modules/security_group"
  name        = "ec2-ftp-mssql-access"
  description = "Allow FTP and MSSQL access"
  vpc_id      = "vpc-09df8e4d092501997"
<<<<<<< HEAD
  allowed_cidrs = ["106.219.181.130/32"]
=======
  allowed_cidrs = ["106.219.176.28/32"]
>>>>>>> a5dd9e49c8382a584f7ede8d7667342bb041c8d3
  tags = {
    Environment = "UAT_DB"
    ManagedBy   = "Terraform"
  }
}

# Fetch the EC2 instance by ID
data "aws_instance" "free_tier_setup_2024" {
  instance_id = "i-00898d4cbde268243"  # Replace with your actual instance ID
}

# Attach the SG to the instance's primary network interface
resource "aws_network_interface_sg_attachment" "attach_sg" {
  security_group_id    = module.ftp_mssql_sg.security_group_id
  network_interface_id = "eni-09d5bdf677bcff5bc"
}
