output "ec2_instance" {
  value = { for key, instance in aws_instance.instance : key => { name = instance.tags.Name, public_ip = instance.public_ip, instance_id = instance.id } }
}