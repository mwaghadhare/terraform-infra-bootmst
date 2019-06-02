resource "aws_instance" "monitor" {
  count                  = "${var.number_of_instances}"
  ami                    = "${data.aws_ami.ubuntu.id}"
  key_name               = "${var.key_name}"
  vpc_security_group_ids = ["${var.security_groups}"]
  subnet_id              = "${var.subnet_ids[count.index % 3]}"
  instance_type          = "${var.instance_type}"
  iam_instance_profile   = "${coalesce(var.instance_profile,join("",aws_iam_instance_profile.monitor_iam_profile.*.name))}"
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

resource "null_resource" "chef-bootstrap-monitor" {
  provisioner "chef" {
    environment     = "${var.env}"
    run_list        = ["my_base_cb", "role[${var.role_name}]", "my_graphite::grafana", "role[consul_agent]", "my_consul_register::riemann"]
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
      host                = "${aws_instance.monitor.0.private_ip}"
    }
  }
}


provider "grafana" {
  url  = "http://monitor-000.${var.env}.${var.domain}:3000/"
  auth = "admin:admin"
}


resource "grafana_data_source" "graphite" {
  depends_on = ["null_resource.chef-bootstrap-monitor"]
  type       = "graphite"
  name       = "graphite"
  url        = "http://graphite-000.${var.env}.${var.domain}:8080"
}


resource "grafana_dashboard" "apollo" {
  depends_on = ["grafana_data_source.graphite"]
  config_json = "${file("${path.module}/apollo.json")}"
}


resource "grafana_dashboard" "ep-terminator" {
  depends_on = ["grafana_dashboard.apollo"]
  config_json = "${file("${path.module}/ep-terminator.json")}"
}

resource "grafana_dashboard" "wlc" {
  depends_on = ["grafana_dashboard.ep-terminator"]
  config_json = "${file("${path.module}/wlc.json")}"
}

resource "grafana_dashboard" "client-terminator" {
  depends_on = ["grafana_dashboard.wlc"]
  config_json = "${file("${path.module}/client-terminator.json")}"
}

resource "grafana_dashboard" "location_services" {
  depends_on = ["grafana_dashboard.client-terminator"]
  config_json = "${file("${path.module}/location_services.json")}"
}

resource "grafana_dashboard" "location_engine" {
  depends_on = ["grafana_dashboard.location_services"]
  config_json = "${file("${path.module}/location_engine.json")}"
}


resource "grafana_dashboard" "papi" {
  depends_on = ["grafana_dashboard.location_engine"]
  config_json = "${file("${path.module}/papi.json")}"
}

resource "grafana_dashboard" "papi_container" {
  depends_on = ["grafana_dashboard.papi"]
  config_json = "${file("${path.module}/papi_container.json")}"
}

resource "grafana_dashboard" "client-router" {
  depends_on = ["grafana_dashboard.papi_container"]
  config_json = "${file("${path.module}/client-router.json")}"
}

resource "grafana_dashboard" "storm" {
  depends_on = ["grafana_dashboard.client-router"]
  config_json = "${file("${path.module}/storm.json")}"
}

resource "grafana_dashboard" "kafka" {
  depends_on = ["grafana_dashboard.storm"]
  config_json = "${file("${path.module}/kafka.json")}"
}

resource "grafana_dashboard" "zookeeper" {
  depends_on = ["grafana_dashboard.kafka"]
  config_json = "${file("${path.module}/zookeeper.json")}"
}

resource "grafana_dashboard" "zones" {
  depends_on = ["grafana_dashboard.zookeeper"]
  config_json = "${file("${path.module}/zones.json")}"
}

