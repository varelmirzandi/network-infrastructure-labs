# Sanitized RouterOS 7.17 configuration example (Model: RB951Ui-2nD)
# Catatan: Nilai sensitif/spesifik lingkungan telah disamarkan untuk dokumentasi.

# --- 1. Bridge & Wireless AP ---
/interface bridge
add name=bridge1

/interface wireless
set [ find default-name=wlan1 ] band=2ghz-b/g/n mode=ap-bridge ssid=home-lab-ap

/interface wireless security-profiles
set [ find default=yes ] authentication-types=wpa2-psk group-ciphers=aes-ccm \
    supplicant-identity=MikroTik unicast-ciphers=aes-ccm

/interface bridge port
add bridge=bridge1 interface=ether2
add bridge=bridge1 interface=wlan1

# --- 2. Remote Access / L2TP Client ---
/interface l2tp-client
add comment="example remote management tunnel" connect-to=tunnel.example.net \
    disabled=yes name=vpn-remote-l2tp user=tunnel-user

# --- 3. IP Addressing, DHCP Server & Pools ---
/ip address
add address=172.16.9.1/24 interface=bridge1 network=172.16.9.0
add address=192.168.100.1/24 interface=ether3 network=192.168.100.0
add address=192.168.3.1/24 interface=ether4 network=192.168.3.0
add address=192.168.5.1/24 interface=ether5 network=192.168.5.0

/ip pool
add name=pool_bridge1 ranges=172.16.9.2-172.16.9.254
add name=pool_ether3 ranges=192.168.100.2-192.168.100.254
add name=pool_ether4 ranges=192.168.3.2-192.168.3.254
add name=pool_ether5 ranges=192.168.5.2-192.168.5.254

/ip dhcp-server
add address-pool=pool_bridge1 interface=bridge1 name=dhcp_bridge1
add address-pool=pool_ether3 interface=ether3 name=dhcp_ether3
add address-pool=pool_ether4 interface=ether4 name=dhcp_ether4
add address-pool=pool_ether5 interface=ether5 name=dhcp_ether5

/ip dhcp-server network
add address=172.16.9.0/24 gateway=172.16.9.1
add address=192.168.100.0/24 gateway=192.168.100.1
add address=192.168.3.0/24 gateway=192.168.3.1
add address=192.168.5.0/24 gateway=192.168.5.1

# --- 4. Bandwidth Limiting (Simple Queue) ---
/queue simple
add max-limit=10M/10M name=limit-bridge1 target=bridge1
add max-limit=8M/8M name=limit-ether3 target=ether3
add max-limit=10M/10M name=limit-ether4 target=ether4
add max-limit=10M/10M name=limit-ether5 target=ether5

# --- 5. WAN DHCP Client, Routing, NAT & DNS ---
/ip dhcp-client
add interface=ether1

/ip route
add disabled=no dst-address=0.0.0.0/0 gateway=192.168.1.1 routing-table=main \
    suppress-hw-offload=no

/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1

/ip dns
set allow-remote-requests=yes servers=8.8.8.8,1.1.1.1

/interface detect-internet
set internet-interface-list=all lan-interface-list=all wan-interface-list=all

# --- 6. System & Management ---
/system clock
set time-zone-name=Asia/Jakarta

/system note
set show-at-login=no

/tool romon
set enabled=yes
