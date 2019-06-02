data "template_file" "userdata_c" {
  template = "${file("${path.module}/scripts/userdata.sh.tpl")}"

  vars {
    region          = "${var.region}"
    env             = "${var.env}"
    domain          = "${var.domain}"
    private_domain  = "${var.private_domain}"
    zone_id_private = "${var.zone_id_private}"
    zone_id_public  = "${var.zone_id_public}"
  }
}

resource "aws_spot_fleet_request" "storm-supervisors_c" {
  iam_fleet_role                      = "${var.fleet_role}"
  spot_price                          = "${var.spotprice}"
  allocation_strategy                 = "${var.strategy}"
  target_capacity                     = "${var.targetcapacity_c}"
  valid_until                         = "${var.validity}"
  terminate_instances_with_expiration = "${var.terminate_instances}"
  replace_unhealthy_instances         = "${var.replace_unhealthy_instances}"

  launch_specification {
    instance_type          = "${var.m22xlarge}"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    availability_zone      = "${element(split(",", var.fullaz), count.index + 2)}"
    vpc_security_group_ids = ["${var.security_group}"]
    spot_price             = "${var.spotprice}"
    subnet_id              = "${var.subnet_ids[count.index + 2]}"
    weighted_capacity      = "${var.wc-four}"
    user_data              = "${data.template_file.userdata_c.rendered}"
    iam_instance_profile_arn   = "${aws_iam_instance_profile.storm-supervisors_iam_profile.arn}"

    root_block_device {
      volume_size           = "${var.root_volume_size}"
      volume_type           = "${var.root_volume_type}"
      delete_on_termination = "${var.root_delete_on_termination}"
    }

    tags {
      Name = "storm-supervisors-fleet"
    }
  }

  launch_specification {
    instance_type          = "${var.m24xlarge}"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    availability_zone      = "${element(split(",", var.fullaz), count.index + 2)}"
    vpc_security_group_ids = ["${var.security_group}"]
    spot_price             = "${var.spotprice}"
    subnet_id              = "${var.subnet_ids[count.index + 2]}"
    weighted_capacity      = "${var.wc-eight}"
    user_data              = "${data.template_file.userdata_c.rendered}"
    iam_instance_profile_arn   = "${aws_iam_instance_profile.storm-supervisors_iam_profile.arn}"

    root_block_device {
      volume_size           = "${var.root_volume_size}"
      volume_type           = "${var.root_volume_type}"
      delete_on_termination = "${var.root_delete_on_termination}"
    }

    tags {
      Name = "storm-supervisors-fleet"
    }
  }


  launch_specification {
    instance_type          = "${var.m3xlarge}"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    availability_zone      = "${element(split(",", var.fullaz), count.index + 2)}"
    vpc_security_group_ids = ["${var.security_group}"]
    spot_price             = "${var.spotprice}"
    subnet_id              = "${var.subnet_ids[count.index + 2]}"
    weighted_capacity      = "${var.wc-four}"
    user_data              = "${data.template_file.userdata_c.rendered}"
    iam_instance_profile_arn   = "${aws_iam_instance_profile.storm-supervisors_iam_profile.arn}"

    root_block_device {
      volume_size           = "${var.root_volume_size}"
      volume_type           = "${var.root_volume_type}"
      delete_on_termination = "${var.root_delete_on_termination}"
    }

    tags {
      Name = "storm-supervisors-fleet"
    }
  }

  launch_specification {
    instance_type          = "${var.m32xlarge}"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    availability_zone      = "${element(split(",", var.fullaz), count.index + 2)}"
    vpc_security_group_ids = ["${var.security_group}"]
    spot_price             = "${var.spotprice}"
    subnet_id              = "${var.subnet_ids[count.index + 2]}"
    weighted_capacity      = "${var.wc-eight}"
    user_data              = "${data.template_file.userdata_c.rendered}"
    iam_instance_profile_arn   = "${aws_iam_instance_profile.storm-supervisors_iam_profile.arn}"

    root_block_device {
      volume_size           = "${var.root_volume_size}"
      volume_type           = "${var.root_volume_type}"
      delete_on_termination = "${var.root_delete_on_termination}"
    }

    tags {
      Name = "storm-supervisors-fleet"
    }
  }

  launch_specification {
    instance_type          = "${var.m4xlarge}"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    availability_zone      = "${element(split(",", var.fullaz), count.index + 2)}"
    vpc_security_group_ids = ["${var.security_group}"]
    spot_price             = "${var.spotprice}"
    subnet_id              = "${var.subnet_ids[count.index + 2]}"
    weighted_capacity      = "${var.wc-four}"
    user_data              = "${data.template_file.userdata_c.rendered}"
    iam_instance_profile_arn   = "${aws_iam_instance_profile.storm-supervisors_iam_profile.arn}"

    root_block_device {
      volume_size           = "${var.root_volume_size}"
      volume_type           = "${var.root_volume_type}"
      delete_on_termination = "${var.root_delete_on_termination}"
    }

    tags {
      Name = "storm-supervisors-fleet"
    }
  }

  launch_specification {
    instance_type          = "${var.m42xlarge}"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    availability_zone      = "${element(split(",", var.fullaz), count.index + 2)}"
    vpc_security_group_ids = ["${var.security_group}"]
    spot_price             = "${var.spotprice}"
    subnet_id              = "${var.subnet_ids[count.index + 2]}"
    weighted_capacity      = "${var.wc-eight}"
    user_data              = "${data.template_file.userdata_c.rendered}"
    iam_instance_profile_arn   = "${aws_iam_instance_profile.storm-supervisors_iam_profile.arn}"

    root_block_device {
      volume_size           = "${var.root_volume_size}"
      volume_type           = "${var.root_volume_type}"
      delete_on_termination = "${var.root_delete_on_termination}"
    }

    tags {
      Name = "storm-supervisors-fleet"
    }
  }

  launch_specification {
    instance_type          = "${var.m44xlarge}"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    availability_zone      = "${element(split(",", var.fullaz), count.index + 2)}"
    vpc_security_group_ids = ["${var.security_group}"]
    spot_price             = "${var.spotprice}"
    subnet_id              = "${var.subnet_ids[count.index + 2]}"
    weighted_capacity      = "${var.wc-sixteen}"
    user_data              = "${data.template_file.userdata_c.rendered}"
    iam_instance_profile_arn   = "${aws_iam_instance_profile.storm-supervisors_iam_profile.arn}"

    root_block_device {
      volume_size           = "${var.root_volume_size}"
      volume_type           = "${var.root_volume_type}"
      delete_on_termination = "${var.root_delete_on_termination}"
    }

    tags {
      Name = "storm-supervisors-fleet"
    }
  }

  launch_specification {
    instance_type          = "${var.m5xlarge}"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    availability_zone      = "${element(split(",", var.fullaz), count.index + 2)}"
    vpc_security_group_ids = ["${var.security_group}"]
    spot_price             = "${var.spotprice}"
    subnet_id              = "${var.subnet_ids[count.index + 2]}"
    weighted_capacity      = "${var.wc-four}"
    user_data              = "${data.template_file.userdata_c.rendered}"
    iam_instance_profile_arn   = "${aws_iam_instance_profile.storm-supervisors_iam_profile.arn}"

    root_block_device {
      volume_size           = "${var.root_volume_size}"
      volume_type           = "${var.root_volume_type}"
      delete_on_termination = "${var.root_delete_on_termination}"
    }

    tags {
      Name = "storm-supervisors-fleet"
    }
  }

  launch_specification {
    instance_type          = "${var.m52xlarge}"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    availability_zone      = "${element(split(",", var.fullaz), count.index + 2)}"
    vpc_security_group_ids = ["${var.security_group}"]
    spot_price             = "${var.spotprice}"
    subnet_id              = "${var.subnet_ids[count.index + 2]}"
    weighted_capacity      = "${var.wc-eight}"
    user_data              = "${data.template_file.userdata_c.rendered}"
    iam_instance_profile_arn   = "${aws_iam_instance_profile.storm-supervisors_iam_profile.arn}"

    root_block_device {
      volume_size           = "${var.root_volume_size}"
      volume_type           = "${var.root_volume_type}"
      delete_on_termination = "${var.root_delete_on_termination}"
    }

    tags {
      Name = "storm-supervisors-fleet"
    }
  }

  launch_specification {
    instance_type          = "${var.m54xlarge}"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    availability_zone      = "${element(split(",", var.fullaz), count.index + 2)}"
    vpc_security_group_ids = ["${var.security_group}"]
    spot_price             = "${var.spotprice}"
    subnet_id              = "${var.subnet_ids[count.index + 2]}"
    weighted_capacity      = "${var.wc-sixteen}"
    user_data              = "${data.template_file.userdata_c.rendered}"
    iam_instance_profile_arn   = "${aws_iam_instance_profile.storm-supervisors_iam_profile.arn}"

    root_block_device {
      volume_size           = "${var.root_volume_size}"
      volume_type           = "${var.root_volume_type}"
      delete_on_termination = "${var.root_delete_on_termination}"
    }

    tags {
      Name = "storm-supervisors-fleet"
    }
  }

  launch_specification {
    instance_type          = "${var.c3xlarge}"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    availability_zone      = "${element(split(",", var.fullaz), count.index + 2)}"
    vpc_security_group_ids = ["${var.security_group}"]
    spot_price             = "${var.spotprice}"
    subnet_id              = "${var.subnet_ids[count.index + 2]}"
    weighted_capacity      = "${var.wc-four}"
    user_data              = "${data.template_file.userdata_c.rendered}"
    iam_instance_profile_arn   = "${aws_iam_instance_profile.storm-supervisors_iam_profile.arn}"

    root_block_device {
      volume_size           = "${var.root_volume_size}"
      volume_type           = "${var.root_volume_type}"
      delete_on_termination = "${var.root_delete_on_termination}"
    }

    tags {
      Name = "storm-supervisors-fleet"
    }
  }

  launch_specification {
    instance_type          = "${var.c32xlarge}"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    availability_zone      = "${element(split(",", var.fullaz), count.index + 2)}"
    vpc_security_group_ids = ["${var.security_group}"]
    spot_price             = "${var.spotprice}"
    subnet_id              = "${var.subnet_ids[count.index + 2]}"
    weighted_capacity      = "${var.wc-eight}"
    user_data              = "${data.template_file.userdata_c.rendered}"
    iam_instance_profile_arn   = "${aws_iam_instance_profile.storm-supervisors_iam_profile.arn}"

    root_block_device {
      volume_size           = "${var.root_volume_size}"
      volume_type           = "${var.root_volume_type}"
      delete_on_termination = "${var.root_delete_on_termination}"
    }

    tags {
      Name = "storm-supervisors-fleet"
    }
  }

  launch_specification {
    instance_type          = "${var.c34xlarge}"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    availability_zone      = "${element(split(",", var.fullaz), count.index + 2)}"
    vpc_security_group_ids = ["${var.security_group}"]
    spot_price             = "${var.spotprice}"
    subnet_id              = "${var.subnet_ids[count.index + 2]}"
    weighted_capacity      = "${var.wc-sixteen}"
    user_data              = "${data.template_file.userdata_c.rendered}"
    iam_instance_profile_arn   = "${aws_iam_instance_profile.storm-supervisors_iam_profile.arn}"

    root_block_device {
      volume_size           = "${var.root_volume_size}"
      volume_type           = "${var.root_volume_type}"
      delete_on_termination = "${var.root_delete_on_termination}"
    }

    tags {
      Name = "storm-supervisors-fleet"
    }
  }

  launch_specification {
    instance_type          = "${var.c4xlarge}"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    availability_zone      = "${element(split(",", var.fullaz), count.index + 2)}"
    vpc_security_group_ids = ["${var.security_group}"]
    spot_price             = "${var.spotprice}"
    subnet_id              = "${var.subnet_ids[count.index + 2]}"
    weighted_capacity      = "${var.wc-four}"
    user_data              = "${data.template_file.userdata_c.rendered}"
    iam_instance_profile_arn   = "${aws_iam_instance_profile.storm-supervisors_iam_profile.arn}"

    root_block_device {
      volume_size           = "${var.root_volume_size}"
      volume_type           = "${var.root_volume_type}"
      delete_on_termination = "${var.root_delete_on_termination}"
    }

    tags {
      Name = "storm-supervisors-fleet"
    }
  }

  launch_specification {
    instance_type          = "${var.c42xlarge}"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    availability_zone      = "${element(split(",", var.fullaz), count.index + 2)}"
    vpc_security_group_ids = ["${var.security_group}"]
    spot_price             = "${var.spotprice}"
    subnet_id              = "${var.subnet_ids[count.index + 2]}"
    weighted_capacity      = "${var.wc-eight}"
    user_data              = "${data.template_file.userdata_c.rendered}"
    iam_instance_profile_arn   = "${aws_iam_instance_profile.storm-supervisors_iam_profile.arn}"

    root_block_device {
      volume_size           = "${var.root_volume_size}"
      volume_type           = "${var.root_volume_type}"
      delete_on_termination = "${var.root_delete_on_termination}"
    }

    tags {
      Name = "storm-supervisors-fleet"
    }
  }

  launch_specification {
    instance_type          = "${var.c44xlarge}"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    availability_zone      = "${element(split(",", var.fullaz), count.index + 2)}"
    vpc_security_group_ids = ["${var.security_group}"]
    spot_price             = "${var.spotprice}"
    subnet_id              = "${var.subnet_ids[count.index + 2]}"
    weighted_capacity      = "${var.wc-sixteen}"
    user_data              = "${data.template_file.userdata_c.rendered}"
    iam_instance_profile_arn   = "${aws_iam_instance_profile.storm-supervisors_iam_profile.arn}"

    root_block_device {
      volume_size           = "${var.root_volume_size}"
      volume_type           = "${var.root_volume_type}"
      delete_on_termination = "${var.root_delete_on_termination}"
    }

    tags {
      Name = "storm-supervisors-fleet"
    }
  }

  launch_specification {
    instance_type          = "${var.c5xlarge}"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    availability_zone      = "${element(split(",", var.fullaz), count.index + 2)}"
    vpc_security_group_ids = ["${var.security_group}"]
    spot_price             = "${var.spotprice}"
    subnet_id              = "${var.subnet_ids[count.index + 2]}"
    weighted_capacity      = "${var.wc-four}"
    user_data              = "${data.template_file.userdata_c.rendered}"
    iam_instance_profile_arn   = "${aws_iam_instance_profile.storm-supervisors_iam_profile.arn}"

    root_block_device {
      volume_size           = "${var.root_volume_size}"
      volume_type           = "${var.root_volume_type}"
      delete_on_termination = "${var.root_delete_on_termination}"
    }

    tags {
      Name = "storm-supervisors-fleet"
    }
  }

  launch_specification {
    instance_type          = "${var.c52xlarge}"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    availability_zone      = "${element(split(",", var.fullaz), count.index + 2)}"
    vpc_security_group_ids = ["${var.security_group}"]
    spot_price             = "${var.spotprice}"
    subnet_id              = "${var.subnet_ids[count.index + 2]}"
    weighted_capacity      = "${var.wc-eight}"
    user_data              = "${data.template_file.userdata_c.rendered}"
    iam_instance_profile_arn   = "${aws_iam_instance_profile.storm-supervisors_iam_profile.arn}"

    root_block_device {
      volume_size           = "${var.root_volume_size}"
      volume_type           = "${var.root_volume_type}"
      delete_on_termination = "${var.root_delete_on_termination}"
    }

    tags {
      Name = "storm-supervisors-fleet"
    }
  }

  launch_specification {
    instance_type          = "${var.c54xlarge}"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    availability_zone      = "${element(split(",", var.fullaz), count.index + 2)}"
    vpc_security_group_ids = ["${var.security_group}"]
    spot_price             = "${var.spotprice}"
    subnet_id              = "${var.subnet_ids[count.index + 2]}"
    weighted_capacity      = "${var.wc-sixteen}"
    user_data              = "${data.template_file.userdata_c.rendered}"
    iam_instance_profile_arn   = "${aws_iam_instance_profile.storm-supervisors_iam_profile.arn}"

    root_block_device {
      volume_size           = "${var.root_volume_size}"
      volume_type           = "${var.root_volume_type}"
      delete_on_termination = "${var.root_delete_on_termination}"
    }

    tags {
      Name = "storm-supervisors-fleet"
    }
  }

  launch_specification {
    instance_type          = "${var.i3xlarge}"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    availability_zone      = "${element(split(",", var.fullaz), count.index + 2)}"
    vpc_security_group_ids = ["${var.security_group}"]
    spot_price             = "${var.spotprice}"
    subnet_id              = "${var.subnet_ids[count.index + 2]}"
    weighted_capacity      = "${var.wc-four}"
    user_data              = "${data.template_file.userdata_c.rendered}"
    iam_instance_profile_arn   = "${aws_iam_instance_profile.storm-supervisors_iam_profile.arn}"

    root_block_device {
      volume_size           = "${var.root_volume_size}"
      volume_type           = "${var.root_volume_type}"
      delete_on_termination = "${var.root_delete_on_termination}"
    }

    tags {
      Name = "storm-supervisors-fleet"
    }
  }

  launch_specification {
    instance_type          = "${var.i32xlarge}"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    availability_zone      = "${element(split(",", var.fullaz), count.index + 2)}"
    vpc_security_group_ids = ["${var.security_group}"]
    spot_price             = "${var.spotprice}"
    subnet_id              = "${var.subnet_ids[count.index + 2]}"
    weighted_capacity      = "${var.wc-eight}"
    user_data              = "${data.template_file.userdata_c.rendered}"
    iam_instance_profile_arn   = "${aws_iam_instance_profile.storm-supervisors_iam_profile.arn}"

    root_block_device {
      volume_size           = "${var.root_volume_size}"
      volume_type           = "${var.root_volume_type}"
      delete_on_termination = "${var.root_delete_on_termination}"
    }

    tags {
      Name = "storm-supervisors-fleet"
    }
  }

  launch_specification {
    instance_type          = "${var.i34xlarge}"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    availability_zone      = "${element(split(",", var.fullaz), count.index + 2)}"
    vpc_security_group_ids = ["${var.security_group}"]
    spot_price             = "${var.spotprice}"
    subnet_id              = "${var.subnet_ids[count.index + 2]}"
    weighted_capacity      = "${var.wc-sixteen}"
    user_data              = "${data.template_file.userdata_c.rendered}"
    iam_instance_profile_arn   = "${aws_iam_instance_profile.storm-supervisors_iam_profile.arn}"

    root_block_device {
      volume_size           = "${var.root_volume_size}"
      volume_type           = "${var.root_volume_type}"
      delete_on_termination = "${var.root_delete_on_termination}"
    }

    tags {
      Name = "storm-supervisors-fleet"
    }
  }

  launch_specification {
    instance_type          = "${var.r3xlarge}"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    availability_zone      = "${element(split(",", var.fullaz), count.index + 2)}"
    vpc_security_group_ids = ["${var.security_group}"]
    spot_price             = "${var.spotprice}"
    subnet_id              = "${var.subnet_ids[count.index + 2]}"
    weighted_capacity      = "${var.wc-four}"
    user_data              = "${data.template_file.userdata_c.rendered}"
    iam_instance_profile_arn   = "${aws_iam_instance_profile.storm-supervisors_iam_profile.arn}"

    root_block_device {
      volume_size           = "${var.root_volume_size}"
      volume_type           = "${var.root_volume_type}"
      delete_on_termination = "${var.root_delete_on_termination}"
    }

    tags {
      Name = "storm-supervisors-fleet"
    }
  }

  launch_specification {
    instance_type          = "${var.r32xlarge}"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    availability_zone      = "${element(split(",", var.fullaz), count.index + 2)}"
    vpc_security_group_ids = ["${var.security_group}"]
    spot_price             = "${var.spotprice}"
    subnet_id              = "${var.subnet_ids[count.index + 2]}"
    weighted_capacity      = "${var.wc-eight}"
    user_data              = "${data.template_file.userdata_c.rendered}"
    iam_instance_profile_arn   = "${aws_iam_instance_profile.storm-supervisors_iam_profile.arn}"

    root_block_device {
      volume_size           = "${var.root_volume_size}"
      volume_type           = "${var.root_volume_type}"
      delete_on_termination = "${var.root_delete_on_termination}"
    }

    tags {
      Name = "storm-supervisors-fleet"
    }
  }

  launch_specification {
    instance_type          = "${var.r34xlarge}"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    availability_zone      = "${element(split(",", var.fullaz), count.index + 2)}"
    vpc_security_group_ids = ["${var.security_group}"]
    spot_price             = "${var.spotprice}"
    subnet_id              = "${var.subnet_ids[count.index + 2]}"
    weighted_capacity      = "${var.wc-sixteen}"
    user_data              = "${data.template_file.userdata_c.rendered}"
    iam_instance_profile_arn   = "${aws_iam_instance_profile.storm-supervisors_iam_profile.arn}"

    root_block_device {
      volume_size           = "${var.root_volume_size}"
      volume_type           = "${var.root_volume_type}"
      delete_on_termination = "${var.root_delete_on_termination}"
    }

    tags {
      Name = "storm-supervisors-fleet"
    }
  }

  launch_specification {
    instance_type          = "${var.r4xlarge}"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    availability_zone      = "${element(split(",", var.fullaz), count.index + 2)}"
    vpc_security_group_ids = ["${var.security_group}"]
    spot_price             = "${var.spotprice}"
    subnet_id              = "${var.subnet_ids[count.index + 2]}"
    weighted_capacity      = "${var.wc-four}"
    user_data              = "${data.template_file.userdata_c.rendered}"
    iam_instance_profile_arn   = "${aws_iam_instance_profile.storm-supervisors_iam_profile.arn}"

    root_block_device {
      volume_size           = "${var.root_volume_size}"
      volume_type           = "${var.root_volume_type}"
      delete_on_termination = "${var.root_delete_on_termination}"
    }

    tags {
      Name = "storm-supervisors-fleet"
    }
  }

  launch_specification {
    instance_type          = "${var.r42xlarge}"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    availability_zone      = "${element(split(",", var.fullaz), count.index + 2)}"
    vpc_security_group_ids = ["${var.security_group}"]
    spot_price             = "${var.spotprice}"
    subnet_id              = "${var.subnet_ids[count.index + 2]}"
    weighted_capacity      = "${var.wc-eight}"
    user_data              = "${data.template_file.userdata_c.rendered}"
    iam_instance_profile_arn   = "${aws_iam_instance_profile.storm-supervisors_iam_profile.arn}"

    root_block_device {
      volume_size           = "${var.root_volume_size}"
      volume_type           = "${var.root_volume_type}"
      delete_on_termination = "${var.root_delete_on_termination}"
    }

    tags {
      Name = "storm-supervisors-fleet"
    }
  }

  launch_specification {
    instance_type          = "${var.r44xlarge}"
    ami                    = "${var.ami_id}"
    key_name               = "${var.key_name}"
    availability_zone      = "${element(split(",", var.fullaz), count.index + 2)}"
    vpc_security_group_ids = ["${var.security_group}"]
    spot_price             = "${var.spotprice}"
    subnet_id              = "${var.subnet_ids[count.index + 2]}"
    weighted_capacity      = "${var.wc-sixteen}"
    user_data              = "${data.template_file.userdata_c.rendered}"
    iam_instance_profile_arn   = "${aws_iam_instance_profile.storm-supervisors_iam_profile.arn}"

    root_block_device {
      volume_size           = "${var.root_volume_size}"
      volume_type           = "${var.root_volume_type}"
      delete_on_termination = "${var.root_delete_on_termination}"
    }

    tags {
      Name = "storm-supervisors-fleet"
    }
  }
}
