region = "ap-south-1"

tgw_id = "tgw-xxxx"

tgw_onprem_rt_id     = "tgw-rtb-onprem"
tgw_inspection_rt_id = "tgw-rtb-inspection"
tgw_spoke_rt_id      = "tgw-rtb-spoke"

inspection_attachment_id = "tgw-attach-fw"
spoke_attachment_id      = "tgw-attach-spoke"
vpn_attachment_id        = "tgw-attach-vpn"

dx_gateway_name = "central-dxgw"
dx_gateway_asn  = 64520

allowed_prefixes = ["10.0.0.0/8"]

dx_connection_id = "dxcon-xxxx"
onprem_ip        = "1.2.3.4"
onprem_bgp_asn   = 65000