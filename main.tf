resource "aws_s3_bucket" "example" {
  bucket = "aitha-test-964241"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
