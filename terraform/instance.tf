data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "main" {
  ami           = data.aws_ami.ubuntu
  instance_type = "t4g.micro"

  subnet_id = aws_subnet.private["ap-northeast-1a"].id
  iam_instance_profile = aws_iam_instance_profile.ec2.name

  tags = local.tags
}