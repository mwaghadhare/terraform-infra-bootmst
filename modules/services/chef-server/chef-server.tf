resource "aws_instance" "chef-server" {
  count                  = "${var.number_of_instances}"
  ami                    = "${var.ami_id}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${var.security_groups}"]
  subnet_id              = "${var.subnet_ids[count.index % 3]}"
  instance_type          = "${var.instance_type}"
  iam_instance_profile   = "${coalesce(var.instance_profile,join("",aws_iam_instance_profile.chef-server_iam_profile.*.name))}"
  ebs_optimized          = "${var.ebs_optimized}"
  source_dest_check      = "${var.source_dest_check}"
  monitoring             = "${var.monitoring}"

  root_block_device {
    volume_type           = "${var.root_volume_type}"
    volume_size           = "${var.root_volume_size}"
    delete_on_termination = "${var.root_delete_on_termination}"
  }


  lifecycle {
    ignore_changes = ["user_data", "ami"]
  }

  associate_public_ip_address = true

  tags {
    Name        = "${var.name}-${format("%03d",count.index)}-${var.env}"
    Environment = "${var.env}"
    managed_by  = "terraform"
  }

  volume_tags {
    managed_by  = "terraform"
    Name        = "${var.name}-${format("%03d",count.index)}-${var.env}"
    Environment = "${var.env}"
  }

  user_data = "${file("${path.module}/scripts/userdata.sh")}"
}
