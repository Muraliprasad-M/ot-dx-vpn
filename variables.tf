variable "region" {}

variable "tgw_id" {}
variable "tgw_onprem_rt_id" {}
variable "tgw_inspection_rt_id" {}
variable "tgw_spoke_rt_id" {}

variable "inspection_attachment_id" {}
variable "spoke_attachment_id" {}
variable "vpn_attachment_id" {}

variable "dx_gateway_name" {}
variable "dx_gateway_asn" {}
variable "allowed_prefixes" {
  type = list(string)
}

variable "dx_connection_id" {}
variable "onprem_ip" {}
variable "onprem_bgp_asn" {}