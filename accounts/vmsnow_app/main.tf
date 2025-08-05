# Module for creating the SG
module "ftp_sg" {
  source      = "../../modules/security_group_app_server"
  name        = "ec2-ftp-access"
  description = "Allow FTP access"
  vpc_id      = "vpc-07cc34a429fb05169"
  allowed_cidrs = ["106.219.183.156/32"]
  tags = {
    Environment = "VMSNOW_APP"
    ManagedBy   = "Terraform"
  }
}
# Fetch the EC2 instance by ID
data "aws_instance" "aws_inst_1_2024" {
  instance_id = "i-085c733698cd07214"  # Replace with your actual instance ID
}

# Attach the SG to the instance's primary network interface
resource "aws_network_interface_sg_attachment" "attach_sg" {
  security_group_id    = module.ftp_sg.security_group_id
  network_interface_id = "eni-0c6a38cac8946e73c"
}
