variable "listen_address" {
  type    = "string"
  default = "0.0.0.0"
}

variable "listen_port" {
  default = 9100
}

variable "node_exporter_version" {
  type    = "string"
  default = "0.16.0"
}
