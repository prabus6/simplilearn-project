output "ec2_public_ipv4_url" {
  value = join("", ["http://", aws_instance.jenkins_server.public_ip])
}