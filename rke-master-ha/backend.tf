#parametri per utilizzare il backend remoto su bucket S3
terraform {
  backend "s3" {
    bucket         = "rke2-terraform-state-bucket"
    dynamodb_table = "rke2-servers-dynamo-table"
    key            = "state/rke2-masters-ha.tfstate"
    region         = "eu-west-3"
    encrypt        = true
  }
}