resource "aws_vpc" "MainVpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Name = "EC2"
  }
}

resource "aws_subnet" "VPC_Subnet" {
  vpc_id = aws_vpc.MainVpc.id
  cidr_block = "10.0.0.0/24"
  availability_zone = "us-east-1a"
tags = {
  Name = "EC2_Subnet"
}
}

resource "aws_network_acl" "VPC_Nacl" {
  vpc_id = aws_vpc.MainVpc.id

  ingress  {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_block = "0.0.0.0/0"
    rule_no = 200
    action = "allow"
  }
    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_block = "0.0.0.0/0"
        rule_no = 300
        action = "allow"
    } 
tags = {
  Name = "EC2_NACL"
}
}

resource "aws_security_group" "Security_Vpc" {
  vpc_id = aws_vpc.MainVpc.id
  ingress  {
    from_port = 0
    to_port = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "-1"
  }
  egress  {
    from_port = 0
    to_port  = 0
    cidr_blocks = ["0.0.0.0/0"]
    protocol = "-1"
  }
tags = {
  Name = "EC2_Security"
}
}

resource "aws_instance" "VPC_Instance" { 
    ami =  "ami-01b799c439fd5516a"
    instance_type =  "m5.large"
    subnet_id = aws_subnet.VPC_Subnet.id
    vpc_security_group_ids = [ aws_security_group.Security_Vpc.id ]
}
