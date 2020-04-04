resource "tls_private_key" "example" {
  algorithm   = "RSA"
  rsa_bits = "4096"
}

resource "aws_key_pair" "generated_key" {
  key_name   = "ec2-key"
  public_key = "${tls_private_key.example.public_key_openssh}"
}

resource "aws_secretsmanager_secret" "private-key-secret" {
  name = "example"
}

resource "aws_secretsmanager_secret_version" "example" {
  secret_id     = "${aws_secretsmanager_secret.private-key-secret.id}"
  secret_string = "${tls_private_key.example.private_key_pem}"
}