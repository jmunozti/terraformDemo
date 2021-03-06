resource "aws_launch_configuration" "asg-launch-config" {
  image_id             = var.ami_id
  instance_type        = var.instance_type
  security_groups      = [aws_security_group.asg.id]
  key_name             = var.ssh_key
  iam_instance_profile = "arn:aws:iam::005488327456:instance-profile/EC2"

  user_data = <<EOF
#!/bin/bash
sudo yum update -y

#Installing nginx
sudo amazon-linux-extras install nginx1.12 -y
sudo service nginx start
sudo chkconfig nginx on

#Sending /var/log/messages to CloudWatch because it records a variety of events,
#such as the system error messages, system startups and shutdowns, change in the network configuration, etc.
sudo yum install -y awslogs
sudo systemctl start awslogsd
sudo systemctl enable awslogsd.service

logger $(uname -a)
EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  launch_configuration = aws_launch_configuration.asg-launch-config.id
  min_size             = var.min_size
  max_size             = var.max_size
  health_check_type    = var.health_check_type
  vpc_zone_identifier  = [var.vpc_zone_identifier]
  load_balancers       = [var.load_balancers]

  tag {
    key                 = "Name"
    value               = format("%s_asg", var.environment)
    propagate_at_launch = true
  }
}
