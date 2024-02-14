output "linux_webserver_public_endpoints" {
  value = aws_instance.demo_instance[*].public_dns
}

/*
output "s3_bucket_arn" {
  value = aws_s3_bucket.demo_bucket.arn
}

output "allowed_corp_public_ip" {
  value = var.allow_specific
}
*/