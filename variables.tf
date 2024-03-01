variable "project_name" {
  description = "Project Name"
  type        = string
  default     = "k8s-cluster"
}
variable "env_prefix" {
  description = "Environment Prefix"
  type        = string
  default     = "cka"
}
variable "ec2_instance" {
  type = list(object({
    instance_name               = string
    ami                         = string
    instance_type               = string
    associate_public_ip_address = string
    ec2_avail_zone              = string
    user_data                   = string
    pub_key_file                = string
  }))
  default = [
        {
            instance_name = "master"
            ami                         = "ami-0c7217cdde317cfec"
            instance_type               = "t3.small"
            associate_public_ip_address = "true"
            ec2_avail_zone           = "us-east-1a"
            user_data                   = "./userdata/k8s-master.yaml"
            pub_key_file = "~/.ssh/id_rsa.pub"
        },
        {
            instance_name = "worker01"
            ami                         = "ami-0c7217cdde317cfec"
            instance_type               = "t3.small"
            associate_public_ip_address = "true"
            ec2_avail_zone           = "us-east-1a"
            user_data                   = "./userdata/k8s-worker.yaml"
            pub_key_file = "~/.ssh/id_rsa.pub"
        },
        {
            instance_name = "worker02"
            ami                         = "ami-0c7217cdde317cfec"
            instance_type               = "t3.small"
            associate_public_ip_address = "true"
            ec2_avail_zone           = "us-east-1a"
            user_data                   = "./userdata/k8s-worker.yaml"
            pub_key_file = "~/.ssh/id_rsa.pub"
        }
    ]
}

variable "sg_name" {
  description = "Security Group Name"
  type        = string
  default     = "k8s-sg"
}
#ingress
variable "ingress_rules" {
  description = "Ingress Rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = string
    description = string
  }))
  default = [
    { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", description = "all allow" }
  ]
}
#egress
variable "egress_rules" {
  description = "Egress Rules"
  type = list(object({
    from_port   = number
    to_port     = number
    protocol    = string
    cidr_blocks = string
    description = string
  }))
  default = [
    { from_port = 0, to_port = 0, protocol = "-1", cidr_blocks = "0.0.0.0/0", description = "all allow" }
  ]
}