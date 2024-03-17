#Provider Block

terraform {
 required_providers {
   aws = {
     source  = "hashicorp/aws"
     version = "~> 4.0"
   }
 }
}

provider "aws" {
 region = "us-east-1"
}

#Security Group

resource "aws_security_group" "jenkis_sg" {
  vpc_id = "${var.vpc_id}"
  name= "Jenkins-SG"
  description="Allow SSH and 8080 port for access"  
}

resource "aws_security_group_rule" "port22" {
  type = "ingress"
  from_port = 22
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.jenkis_sg.id}"
}

resource "aws_security_group_rule" "port8080" {
  type = "ingress"
  from_port = 8080
  to_port = 8080
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.jenkis_sg.id}"
}

resource "aws_security_group_rule" "allow-all-vpc-traffic" {
  type = "ingress"
  from_port = 0
  to_port = 0
  protocol = -1
  cidr_blocks = ["192.168.0.0/16"]
  security_group_id = "${aws_security_group.jenkis_sg.id}"
}

resource "aws_security_group_rule" "allow-all-outbound" {
  type = "egress"
  from_port = 0
  to_port = 0
  protocol = -1
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.jenkis_sg.id}"
}

## EC2 Creation

resource "aws_instance" "jenkins_server" {
 ami                         = "${var.ami_id}" 
 instance_type               = "t3.micro"
 key_name                    = "${var.key_name}"
 subnet_id                   = "${var.public_subnet_ids}"
 security_groups             = ["${aws_security_group.jenkis_sg.id}"]
 user_data                   = file("jenkins-install.sh")
 tags = {Name = "Jenkins-server"}
 associate_public_ip_address = true
 root_block_device {
   volume_type           = "gp3"
   volume_size           = "10"
   delete_on_termination = true
 }
}