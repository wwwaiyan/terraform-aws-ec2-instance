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
            instance_name = "app-service"
            ami                         = "ami-0c7217cdde317cfec"
            instance_type               = "t3.large"
            associate_public_ip_address = "true"
            ec2_avail_zone           = "us-east-1a"
            user_data                   = "./ec2_userdata/istioonKind.yaml"
            pub_key_file = "~/.ssh/id_rsa.pub"
        }
    ]
}
variable "project_name" {
  description = "Project Name"
  type        = string
  default     = "test-project"
}
variable "env_prefix" {
  description = "Environment Prefix"
  type        = string
  default     = "test"
}

variable "sg_name" {
  description = "Security Group Name"
  type        = string
  default     = "test-sg"
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
    { from_port = 22, to_port = 22, protocol = "tcp", cidr_blocks = "0.0.0.0/0", description = "ssh" },
    { from_port = 80, to_port = 80, protocol = "tcp", cidr_blocks = "0.0.0.0/0", description = "Nginx allow" },
    { from_port = 3000, to_port = 3000, protocol = "tcp", cidr_blocks = "0.0.0.0/0", description = "frontend" }
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