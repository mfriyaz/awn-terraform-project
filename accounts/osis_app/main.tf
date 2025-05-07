# Module for creating the SG
module "osis_ftp_sg" {
  source      = "../../modules/security_group_osis_app_server"
  name        = "ec2-ftp-access"
  description = "Allow FTP access"
  vpc_id      = "vpc-f505c791"
  allowed_cidrs = ["106.219.179.50/32"]
  tags = {
    Environment = "OSIS_APP"
    ManagedBy   = "Terraform"
  }
}

# Fetch the EC2 instance by ID
data "aws_instance" "OSIS-Live-Instance" {
  instance_id = "i-04536d1205e5d23f9"  # Replace with your actual instance ID
}

# Attach the SG to the instance's primary network interface
resource "aws_network_interface_sg_attachment" "attach_sg" {
  security_group_id    = module.osis_ftp_sg.security_group_id
  network_interface_id = "eni-0ffa0cdd110241880"
}