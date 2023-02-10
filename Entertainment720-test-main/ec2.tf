resource "aws_instance" "main" {
  ami                    = data.aws_ssm_parameter.instance_ami.value
  instance_type          = "t3.micro"
  key_name               = "tbermudez"
  subnet_id              = aws_subnet.public[0].id
  vpc_security_group_ids = ["sg-07ce11263077f0aa9"]
  tags = {
    "Name" = "${var.default_tags.env}-EC2"
  }
  user_data = base64encode(file("C:/Users/tberm/SkillStorm/Entertainment720-test-main/user.sh"))
}

output "ec2_ssh_command" {
  value = "ssh -i tbermudez.pem ubuntu@ec2-${replace(aws_instance.main.public_ip, ".", "-")}.compute-1.amazonaws.com"
}
