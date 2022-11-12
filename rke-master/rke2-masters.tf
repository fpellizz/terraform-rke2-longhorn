#definisco alcuni parametri

locals {
  name      = "rke2-sandbox"
  ami       = var.ami
  user_data = <<-EOT
  #!/bin/bash
  export INSTALL_RKE2_TYPE=server
  export RKE2_TOKEN=supercarifragilistichespiralidoso,1
  export RKE2_CONFIG_FILE=/etc/rancher/rke2/config.yaml
  dnf -y install bash 
  dnf -y install curl 
  dnf -y install findmnt 
  dnf -y install grep 
  dnf -y install awk 
  dnf -y install blkid 
  dnf -y install lsblk 
  dnf -y install mc
  dnf -y install nfs-utils
  yum -y --setopt=tsflags=noscripts install iscsi-initiator-utils
  echo "InitiatorName=$(/sbin/iscsi-iname)" > /etc/iscsi/initiatorname.iscsi
  systemctl enable iscsid
  systemctl start iscsid
  modprobe iscsi_tcp
  touch /etc/NetworkManager/conf.d/rke2-canal.conf
  echo "[keyfile]" > /etc/NetworkManager/conf.d/rke2-canal.conf
  echo "unmanaged-devices=interface-name:cali*;interface-name:flannel*" >> /etc/NetworkManager/conf.d/rke2-canal.conf
  systemctl restart NetworkManager
  sed -i 's/enforcing/disabled/g' /etc/selinux/config
  setenforce disabled
  PUBLIC_IP_ADDR=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)
  echo "$PUBLIC_IP_ADDR rkesandbox.decisyon.site" >> /etc/hosts
  mkdir -p /etc/rancher/rke2/
  echo "token: supercarifragilistichespiralidoso,1" > /etc/rancher/rke2/config.yaml
  echo "tls-san:" >> /etc/rancher/rke2/config.yaml
  echo "  - rkesandbox.decisyon.site" >> /etc/rancher/rke2/config.yaml
  curl -sfL https://get.rke2.io |  sh - 
  mkdir -p /var/lib/rancher/rke2/server/manifests
  chmod -R 765 /var/lib/rancher/rke2/server/manifests
  curl https://raw.githubusercontent.com/longhorn/longhorn/v1.3.2/deploy/longhorn.yaml -o /var/lib/rancher/rke2/server/manifests/rke2-longhorn.yaml
  systemctl enable rke2-server.service
  systemctl start rke2-server.service
  systemctl enable --now cockpit.socket
  EOT
}

##creo una vpc
#module "vpc" {
#  source  = "terraform-aws-modules/vpc/aws"
#  version = "~> 3.0"
#
#  name = local.name
#  cidr = "10.99.0.0/18"
#
#  azs              = ["${var.region}a", "${var.region}b", "${var.region}c"]
#  public_subnets   = ["10.99.0.0/24", "10.99.1.0/24", "10.99.2.0/24"]
#  private_subnets  = ["10.99.3.0/24", "10.99.4.0/24", "10.99.5.0/24"]
#  database_subnets = ["10.99.7.0/24", "10.99.8.0/24", "10.99.9.0/24"]
#
#  tags = local.tags
#}

#utilizzo la vpc di default, recuperandola tramite datasource 

data "aws_vpc" "default" {
  default = true
}

data "aws_availability_zones" "available" {
  state = "available"
}

#definisco i security groups
module "security_group_external" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "${local.name}-external"
  description = "Security group per il traffico pubblico"

  ##utilizzando vpc creata da zero
  #vpc_id      = module.vpc.vpc_id

  #utilizzando vpc di default
  vpc_id = data.aws_vpc.default.id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "https-443-tcp", "all-icmp"]
  egress_rules        = ["all-all"]

  ingress_with_cidr_blocks = [
    {
      from_port   = 22
      to_port     = 22
      description = "Allow SSH from Dcy Office"
      cidr_blocks = "212.66.99.129/32"
      protocol    = "tcp"
    },
    {
      from_port   = 22
      to_port     = 22
      description = "Allow SSH smartworking fpellizz"
      cidr_blocks = "2.236.240.20/32"
      protocol    = "tcp"
    },
    {
      from_port   = 9090
      to_port     = 9090
      description = "Cockpit"
      cidr_blocks = "212.66.99.129/32"
      protocol    = "tcp"
    },
    {
      from_port   = 9345
      to_port     = 9345
      description = "rke2"
      cidr_blocks = "0.0.0.0/0"
      protocol    = "tcp"
    },
    {
      from_port   = 6443
      to_port     = 6443
      description = "rke2 kubernetes"
      cidr_blocks = "0.0.0.0/0"
      protocol    = "tcp"
    }
    
  ]

  tags = var.tags
}

module "security_group_internal" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = "${local.name}-internal"
  description = "Security group per il traffico interno"
  ##utilizzando vpc creata da zero
  #vpc_id      = module.vpc.vpc_id

  #utilizzando vpc di default
  vpc_id       = data.aws_vpc.default.id
  egress_rules = ["all-all"]
  ingress_with_self = [
    {
      rule = "all-all"
    }
  ]

  tags = var.tags
}

module "ec2_master" {
  #source = "../../"
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 4.0"

  name          = "${local.name}-master"
  ami           = var.ami
  key_name      = var.key
  instance_type = "t3a.medium"

  ##utilizzando una vpc appena creata
  #availability_zone = element(module.vpc.azs, 0)
  #subnet_id         = element(module.vpc.private_subnets, 0)
  #vpc_security_group_ids      = [module.security_group.security_group_id]

  #utilizzando una vpc esistente
  availability_zone = "${var.region}a"
  #subnet_id         = element(data.aws_vpc.default.private_subnets, 0)
  vpc_security_group_ids = [module.security_group_external.security_group_id, module.security_group_internal.security_group_id, ]

  #placement_group             = aws_placement_group.web.id
  associate_public_ip_address = true
  #disable_api_stop            = false

  # only one of these can be enabled at a time
  #hibernation = true
  # enclave_options_enabled = true

  user_data_base64 = base64encode(local.user_data)
  #user_data_replace_on_change = true

  #cpu_core_count       = 2 # default 4
  #cpu_threads_per_core = 1 # default 2

  enable_volume_tags = false
  root_block_device = [
    {
      encrypted   = false
      volume_type = "gp2"
      volume_size = 50
      tags = {
        Name = "my-root-block"
      }
    },
  ]
  tags = var.tags
}

#ELASTIC IP
## Chiedo l'assegnazione di un nuovo Elastic IP ad AWS, ma potrei avere un errore se ho raggiunto il limite
#resource "aws_eip" "endpoint" {
#  vpc = true
#}

#resource "aws_eip_association" "eip_assoc" {
#  instance_id   = module.ec2_master.id
#  allocation_id = aws_eip.endpoint.id
#  depends_on = [module.ec2_master]
#}

#Gandi DNS
#resource "gandi_livedns_record" "rkesandbox" {
#  zone       = "decisyon.site"
#  name       = "rkesandbox"
#  type       = "A"
#  ttl        = "300"
#  values     = [aws_eip.endpoint.public_ip]
#  depends_on = [aws_eip_association.eip_assoc]
#}

#Recupero le informazioni di un Elastic IP disponibile nelle regione
data "aws_eip" "endpoint" {
  public_ip = var.elastic_ip
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = module.ec2_master.id
  allocation_id = data.aws_eip.endpoint.id
  depends_on    = [module.ec2_master]
}

#Gandi DNS
resource "gandi_livedns_record" "rkesandbox" {
  zone       = "decisyon.site"
  name       = "rkesandbox"
  type       = "A"
  ttl        = "300"
  values     = [data.aws_eip.endpoint.public_ip]
  depends_on = [aws_eip_association.eip_assoc]
}

#module "ec2_master_ha" {
#  source = "../../"
#
#  name = "${local.name}-master-ha"
#  ami                    = var.ami
#  key_name               = var.key
#  instance_type     = "t3a.medium"
#  
#  ##utilizzando una vpc appena creata
#  #availability_zone = element(module.vpc.azs, 0)
#  #subnet_id         = element(module.vpc.private_subnets, 0)
#  #vpc_security_group_ids      = [module.security_group.security_group_id]
#
#  #utilizzando una vpc esistente
#  availability_zone = element(data.aws_vpc.azs, 0)
#  subnet_id         = element(data.aws_vpc.private_subnets, 0)
#  vpc_security_group_ids      = [module.security_group_external.security_group_id, module.security_group_internal.security_group_id,]
#  
#  #placement_group             = aws_placement_group.web.id
#  associate_public_ip_address = true
#  disable_api_stop            = false
#
#  # only one of these can be enabled at a time
#  #hibernation = true
#  # enclave_options_enabled = true
#
#  user_data_base64            = base64encode(local.user_data)
#  user_data_replace_on_change = true
#
#  #cpu_core_count       = 2 # default 4
#  #cpu_threads_per_core = 1 # default 2
#
#  enable_volume_tags = false
#  root_block_device = [
#    {
#      encrypted   = false
#      volume_type = "gp2"
#      volume_size = 50
#      tags = {
#        Name = "my-root-block"
#      }
#    },
#  ]
#  tags = local.tags
#}
#
#
#resource "aws_eip" "lb" {
#  instance = aws_instance.ec2_master_ha.id
#  vpc      = true
#}
#