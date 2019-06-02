provider "consul" {
  address    = "${var.address}"
  datacenter = "${var.datacenter}"
}

resource "consul_keys" "papi_database" {
  key {
    path   = "papi/DATABASE"
    delete = true
    value  = "${var.papi_database}"
  }
}

resource "consul_keys" "papi_host" {
  key {
    path   = "redis/papi/host"
    delete = true
    value  = "${var.papi_host}"
  }
}
