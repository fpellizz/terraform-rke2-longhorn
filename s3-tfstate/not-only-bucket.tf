#creo un bucket s3 per gli stati remoti
resource "aws_s3_bucket" "terraform_state" {
  bucket = "rke2-terraform-state-bucket"
  versioning {
    enabled = false
  }

  force_destroy = true

  # Enable server-side encryption by default
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

#creo alcune tablele dynamoDB per la gestione dei lock
resource "aws_dynamodb_table" "terraform_locks" {
  name         = "rke2-terraform-dynamo-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_dynamodb_table" "terraform_locks_servers" {
  name         = "rke2-servers-dynamo-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}

resource "aws_dynamodb_table" "terraform_locks_workers" {
  name         = "rke2-workers-dynamo-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
}