resource "aws_dx_gateway" "dxgw" {
  name            = var.dx_gateway_name
  amazon_side_asn = var.dx_gateway_asn
}

resource "aws_dx_gateway_association" "dxgw_tgw" {
  dx_gateway_id         = aws_dx_gateway.dxgw.id
  associated_gateway_id = var.tgw_id
  allowed_prefixes      = var.allowed_prefixes
}

resource "aws_dx_transit_virtual_interface" "vif" {
  connection_id    = var.dx_connection_id
  dx_gateway_id    = aws_dx_gateway.dxgw.id
  vlan             = 101
  address_family   = "ipv4"
  bgp_asn          = var.onprem_bgp_asn

  amazon_address   = "169.254.100.1/30"
  customer_address = "169.254.100.2/30"
}

resource "aws_customer_gateway" "cgw" {
  bgp_asn    = var.onprem_bgp_asn
  ip_address = var.onprem_ip
  type       = "ipsec.1"
}

resource "aws_vpn_connection" "vpn" {
  transit_gateway_id  = var.tgw_id
  customer_gateway_id = aws_customer_gateway.cgw.id
  type                = "ipsec.1"
  static_routes_only  = false
}

resource "aws_ec2_transit_gateway_route_table_association" "onprem" {
  transit_gateway_attachment_id  = var.vpn_attachment_id
  transit_gateway_route_table_id = var.tgw_onprem_rt_id
}

resource "aws_ec2_transit_gateway_route_table_association" "inspection" {
  transit_gateway_attachment_id  = var.inspection_attachment_id
  transit_gateway_route_table_id = var.tgw_inspection_rt_id
}

resource "aws_ec2_transit_gateway_route_table_association" "spoke" {
  transit_gateway_attachment_id  = var.spoke_attachment_id
  transit_gateway_route_table_id = var.tgw_spoke_rt_id
}

resource "aws_ec2_transit_gateway_route" "onprem_default" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_route_table_id = var.tgw_onprem_rt_id
  transit_gateway_attachment_id  = var.inspection_attachment_id
}

resource "aws_ec2_transit_gateway_route" "spoke_default" {
  destination_cidr_block         = "0.0.0.0/0"
  transit_gateway_route_table_id = var.tgw_spoke_rt_id
  transit_gateway_attachment_id  = var.inspection_attachment_id
}