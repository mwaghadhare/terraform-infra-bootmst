resource "aws_kms_key" "default" {
  description             = "${var.description}"
  deletion_window_in_days = "${var.deletion_window_in_days}"
  enable_key_rotation     = "${var.enable_key_rotation}"
  tags                    = "${var.tags}"
}

resource "aws_kms_alias" "default" {
  target_key_id = "${aws_kms_key.default.id}"
}
