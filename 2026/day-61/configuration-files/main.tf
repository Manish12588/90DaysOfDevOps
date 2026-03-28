provider aws {

region = "us-west-2"
}

resource aws_s3_buket s3_bucket {
bucket = "first-terraform-learning-bucket"

}