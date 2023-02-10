resource "aws_s3_bucket" "backend" {
    bucket = "entertainment720-test" # must be unique
}

# s3 version control since terraform doesn't have it
resource "aws_s3_bucket_versioning" "backend" {
    bucket = aws_s3_bucket.backend.id
    versioning_configuration {
        status = "Enabled"
    }
}

# s3 resource bucket policy
data "aws_iam_policy_document" "backend" {
    statement {
        sid = "LetEveryoneView"
        principals {
            type = "AWS"
            identifiers = ["*"]
        }
        actions = [
            "s3:*"
        ]

        resources = [
            aws_s3_bucket.backend.arn, "${aws_s3_bucket.backend.arn}/*"
        ]
    }
}
# attach a policy
resource "aws_s3_bucket_policy" "backend" {
    bucket = aws_s3_bucket.backend.id
    policy = data.aws_iam_policy_document.backend.json
}