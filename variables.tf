variable "project_name" {
  description = "Project Name"
  type        = string
  default     = "qsl-docker-jenkins"
}
variable "env_prefix" {
  description = "Environment Prefix"
  type        = string
  default     = "dev"
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
            instance_name = "agent"
            ami                         = "ami-0c7217cdde317cfec"
            instance_type               = "t2.medium"
            associate_public_ip_address = "true"
            ec2_avail_zone           = "us-east-1a"
            user_data                   = "./userdata/jenkins-agent.yaml"
            pub_key_file = "~/.ssh/id_rsa.pub"
        },
        {
            instance_name = "master"
            ami                         = "ami-0c7217cdde317cfec"
            instance_type               = "t2.medium"
            associate_public_ip_address = "true"
            ec2_avail_zone           = "us-east-1a"
            user_data                   = "./userdata/jenkins-master.yaml"
            pub_key_file = "~/.ssh/id_rsa.pub"
        }
    ]
}

variable "sg_name" {
  description = "Security Group Name"
  type        = string
  default     = "jenkins-sg"
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