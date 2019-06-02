resource "aws_kms_key" "kms_key" {
  description = "Key for ${var.key_identifier}"

  tags {
    Name = "${var.key_identifier}"
    ENV  = "${var.env}"
  }
}

resource "aws_kms_alias" "kms_key_alias_" {
  name          = "alias/${var.key_identifier}"
  target_key_id = "${aws_kms_key.kms_key.key_id}"
}
