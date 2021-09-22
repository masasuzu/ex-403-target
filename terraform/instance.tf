data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-arm64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "main" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t4g.micro"

  subnet_id            = aws_subnet.private["ap-northeast-1a"].id
  iam_instance_profile = aws_iam_instance_profile.ec2.name
  security_groups      = [aws_security_group.main.id]

  user_data = <<EOL
#cloud-config
package_update: true
package_upgrade: true
timezone: Asia/Tokyo
hostname: ${local.name}
packages:
  - nginx
runcmd:
  - [ snap, switch, --channel=candidate, amazon-ssm-agent ]
# DEBUG
output : { all : '| tee -a /var/log/cloud-init-output.log' }
EOL

  tags = local.tags
}