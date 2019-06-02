resource "null_resource" "monitor-service-discovery" {
  count = "${var.number_of_instances}"

  provisioner "remote-exec" {
    inline = ["sudo chef-client -r 'role[${var.role_name}],recipe[my_consul_register::riemann],recipe[riemann2::service]'"]

    connection {
      bastion_host        = "${var.bastion_host}"
      bastion_user        = "${var.bastion_user}"
      bastion_private_key = "${file("~/.ssh/${var.env}-${var.region}.pem")}"
      user                = "ubuntu"
      private_key         = "${file("~/.ssh/${var.env}-${var.region}.pem")}"
      host                = "${element(var.instances, count.index)}"
    }
  }
}
