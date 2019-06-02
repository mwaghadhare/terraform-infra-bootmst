resource "aws_instance" "praxis" {
  ami                         = "${data.aws_ami.ubuntu.id}"
  availability_zone           = "${var.fullaz}"
  count                       = "${var.number_of_instances}"
  key_name                    = "${var.key_name}"
  vpc_security_group_ids      = ["${var.security_groups}"]
  subnet_id                   = "${var.subnet_id}"
  instance_type               = "${var.instance_type}"
  iam_instance_profile        = "${coalesce(var.instance_profile,join("",aws_iam_instance_profile.praxis_iam_profile.*.name))}"
  source_dest_check           = false
  associate_public_ip_address = true

  root_block_device {
    volume_type           = "${var.root_volume_type}"
    volume_size           = "${var.root_volume_size}"
    delete_on_termination = "${var.root_delete_on_termination}"
  }

  ebs_block_device {
    device_name           = "${var.device_name}"
    volume_size           = "${var.volume_size}"
    volume_type           = "${var.volume_type}"
    delete_on_termination = "${var.delete_on_termination}"
  }

  lifecycle {
    ignore_changes = ["user_data", "ami"]
  }

  tags {
    managed_by  = "terraform"
    Name        = "${var.name}-${format("%03d",count.index)}-${var.env}"
    Environment = "${var.env}"
  }

  volume_tags {
    managed_by  = "terraform"
    Name        = "${var.name}-${format("%03d",count.index)}-${var.env}"
    Environment = "${var.env}"
  }

  user_data = "${file("${path.module}/scripts/userdata.sh")}"
}

resource "null_resource" "chef-bootstrap-praxis" {
  count = "${var.number_of_instances}"

  provisioner "chef" {
    environment     = "${var.env}"
    run_list        = ["my_base_cb"]
    node_name       = "${var.name}-${format("%03d",count.index)}-${var.env}"
    user_name       = "${var.org_validator}"
    server_url      = "${var.chef_fqdn}"
    user_key        = "${file("~/.chef/${var.org_validator}.pem")}"
    ssl_verify_mode = ":verify_none"
    version         = "12.15.19"

    connection {
      user        = "${var.user}"
      private_key = "${file("~/.ssh/${var.env}-${var.region}.pem")}"
      host        = "${element(aws_instance.praxis.*.private_ip, count.index)}"
    }
  }
}
