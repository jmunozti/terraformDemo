output "vpc_id" {
  value = module.vpc.vpc_id
}

output "bastion_public_ip" {
  value = module.bastion.public_ip
}

output "bastion_public_dns" {
  value = module.bastion.public_dns
}

output "ec2_private_ip" {
  value = module.ec2.private_ip
}

output "elb_public_dns" {
  value = module.elb.elb_address
}
