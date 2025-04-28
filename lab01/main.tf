# TODO: Add a random_string resource named "suffix"

resource "random_string" "suffix" {
  length  = 8
  special = false
  upper   = false
}

# TODO: Add an aws_s3_bucket resource named "learning_bucket"
#       using the random suffix to ensure a unique name.
#       Add a tag: Name = "TF Advanced Lab 1 Bucket"

resource "aws_s3_bucket" "learning_bucket" {
  bucket = "tf-adv-lab01-${random_string.suffix.result}"

  tags = {
    Name = "TF Advanced Lab 1 Bucket"
  }
}

resource "aws_s3_bucket" "learning_bucket2" {
  bucket = "tf-adv-lab01-${random_string.suffix.result}-2"

  tags = {
    Name = "TF Advanced Lab 1 Bucket"
  }
}