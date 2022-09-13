
resource "aws_s3_bucket" "terraform_state" {
  bucket = "bijubayarea-s3-remote-backend-deadbeef"

  force_destroy = true

  // lifecycle {
  //   prevent_destroy = true
  // }

  #server_side_encryption_configuration {
  #      rule {
  #          apply_server_side_encryption_by_default {
  #              sse_algorithm = "AES256"
  #          }
  #      }
  #  }

  tags = {
    Name        = "terraform-state"
    Environment = "staging"
  }
}

/*
resource "aws_s3_bucket" "terraform_state" {
  bucket_prefix = "bijubayarea-s3-remote-backend-"

  versioning {
    enabled = true
  }

  force_destroy = true

  // lifecycle {
  //   prevent_destroy = true
  // }
}
*/

resource "aws_dynamodb_table" "terraform_state_lock" {
  name           = "terraform-state-lock-dynamo"
  #billing_mode   = "PAY_PER_REQUEST"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}