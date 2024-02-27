variable "project_name" {
    description = "Project Name"
    type        = string
}
variable "env_prefix" {
    description = "Environment Prefix"
    type        = string
}
variable "security_group_id"{
  description = "Security Group IDs"
  type = string
}
variable "subnet_id"{
  description = "Subnet ID"
  type = string
}
variable "ec2_instance" {
  type = list(object({
    instance_name = string
    ami                         = string
    instance_type               = string
    associate_public_ip_address = string
    ec2_avail_zone           = string
    user_data                   = string
    pub_key_file = string
  }))
  default = []
}