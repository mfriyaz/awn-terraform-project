#Module for create Security Group
module "vmsdb_mssql_sg" {
    source = "../../modules/security_group"
    name = "ec2-mssql-access"
    description = "Allow MSSQL access"
    vpc_id = "vpc-055fd4ec6ef5a9b38"
    allowed_cidrs = ["192.168.110.150/24"]
    tags = {
      Environment = "VMSNOW_DB"
      ManagedBy = "Terraform"
    }  
}
#Fetch the EC2 instance by ID
data "aws_instance" "aws_inst_2_2024" {
    instance_id = "i-02eb9faa456e4ff60"  #Replace with your actual instanceID
}

#Attach the SG to the instance's primary network interface
resource "aws_network_interface_sg_attachment" "attach_sg" {
    security_group_id = "module.vmsdb_mssql_sg.security_group_id"
    network_interface_id = "eni-0a47e29882db84207"
  }