resource "aws_instance" "zookeeper-misc" {
  count                  = "${var.number_of_instances}"
  ami                    = "${data.aws_ami.ubuntu.id}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${var.security_groups}"]
  subnet_id              = "${var.subnet_ids[count.index % 3]}"
  instance_type          = "${var.instance_type}"
  iam_instance_profile   = "${coalesce(var.instance_profile,join("",aws_iam_instance_profile.zookeeper-misc_iam_profile.*.name))}"
  ebs_optimized          = "${var.ebs_optimized}"
  source_dest_check      = "${var.source_dest_check}"
  monitoring             = "${var.monitoring}"

  root_block_device {
    volume_type           = "${var.root_volume_type}"
    volume_size           = "${var.root_volume_size}"
    delete_on_termination = "${var.root_delete_on_termination}"
  }

  ebs_block_device {
    device_name           = "${var.data_device_name}"
    volume_size           = "${var.data_volume_size}"
    volume_type           = "${var.data_volume_type}"
    iops		  = "${var.data_iops}"
    delete_on_termination = "${var.data_delete_on_termination}"
  }

  ebs_block_device {
    device_name           = "${var.opt_device_name}"
    volume_size           = "${var.opt_volume_size}"
    volume_type           = "${var.opt_volume_type}"
    delete_on_termination = "${var.opt_delete_on_termination}"
  }

  lifecycle {
    ignore_changes = ["user_data", "ami", "instance_type"]
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

resource "null_resource" "chef-bootstrap-zookeeper-misc" {
  provisioner "chef" {
    environment     = "${var.env}"
    run_list        = ["role[${var.role_name}]"]
    node_name       = "${var.name}-000-${var.env}"
    user_name       = "${var.org_validator}"
    server_url      = "${var.chef_fqdn}"
    user_key        = "${file("~/.chef/${var.org_validator}.pem")}"
    ssl_verify_mode = ":verify_none"
    version         = "12.15.19"

    connection {
      bastion_host        = "${var.bastion_host}"
      bastion_user        = "${var.bastion_user}"
      bastion_private_key = "${file("~/.ssh/${var.env}-${var.region}.pem")}"
      user                = "ubuntu"
      private_key         = "${file("~/.ssh/${var.env}-${var.region}.pem")}"
      host                = "${aws_instance.zookeeper-misc.0.private_ip}"
    }
  }
}

resource "null_resource" "chef-bootstrap-zookeeper-misc-1" {
  depends_on = ["null_resource.chef-bootstrap-zookeeper-misc"]
  count      = "${var.number_of_instances - 1}"

  provisioner "chef" {
    environment     = "${var.env}"
    run_list        = ["role[${var.role_name}]"]
    node_name       = "${var.name}-${format("%03d",count.index + 1)}-${var.env}"
    user_name       = "${var.org_validator}"
    server_url      = "${var.chef_fqdn}"
    user_key        = "${file("~/.chef/${var.org_validator}.pem")}"
    ssl_verify_mode = ":verify_none"
    version         = "12.15.19"

    connection {
      bastion_host        = "${var.bastion_host}"
      bastion_user        = "${var.bastion_user}"
      bastion_private_key = "${file("~/.ssh/${var.env}-${var.region}.pem")}"
      user                = "ubuntu"
      private_key         = "${file("~/.ssh/${var.env}-${var.region}.pem")}"
      host                = "${element(aws_instance.zookeeper-misc.*.private_ip,count.index + 1)}"
    }
  }
}
