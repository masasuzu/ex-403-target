locals {
  name = "ex-target-403"

  image = "masasuzu/ex-return-403-app:latest"

  default_tags = {
    project   = local.name
    managedby = "terraform"
  }
  tags = {
    Name = local.name
  }
  cidr_block = {
    vpc = "10.20.0.0/16"
    public = {
      "ap-northeast-1a" = "10.20.1.0/24"
      "ap-northeast-1c" = "10.20.3.0/24"
      "ap-northeast-1d" = "10.20.4.0/24"
    }
    private = {
      "ap-northeast-1a" = "10.20.11.0/24"
      "ap-northeast-1c" = "10.20.13.0/24"
      "ap-northeast-1d" = "10.20.14.0/24"
    }
  }
}