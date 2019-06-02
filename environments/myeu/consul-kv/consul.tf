module "consul" {
  source        = "../../../modules/consul-kv/"
  address       = "${var.address}"
  datacenter    = "${var.datacenter}"
  papi_database = "${var.papi_database}"
  papi_host     = "${var.papi_host}"
}
