resource "aws_instance" "instance" {
  for_each = { for instance in var.ec2_instance : instance.instance_name => instance }
  ami                         = each.value.ami
  instance_type               = each.value.instance_type
  vpc_security_group_ids      = [var.security_group_id]
  subnet_id                   = var.subnet_id
  associate_public_ip_address = each.value.associate_public_ip_address
  availability_zone           = each.value.ec2_avail_zone
  key_name                    = "${var.project_name}-${var.env_prefix}-${each.value.instance_name}-key"
  user_data                   = file(each.value.user_data)
  tags = {
      Name        = "${var.project_name}-${var.env_prefix}-${each.value.instance_name}"
      Project     = var.project_name
      Environment = var.env_prefix
  }
  depends_on = [aws_key_pair.key_pair]
  lifecycle {
    ignore_changes = [ tags, user_data ]
  }
}
resource "aws_key_pair" "key_pair" {
  for_each = { for instance in var.ec2_instance : instance.instance_name => instance }
  key_name   = "${var.project_name}-${var.env_prefix}-${each.value.instance_name}-key"
  public_key = file(each.value.pub_key_file)
  lifecycle {
    ignore_changes = [ public_key, key_name ]
  }
}