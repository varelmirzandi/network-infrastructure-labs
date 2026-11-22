# Checklist Troubleshooting Jaringan (MikroTik RouterOS)

1. **Cek Konektivitas Lapisan Fisik & Interface:** Pastikan kabel/port *up* dan *bridge/VLAN* terpasang pada *interface* yang sesuai.
2. **Verifikasi IP & Gateway:** Periksa *IP address* (`/ip address print`) serta *default route* (`/ip route print`).
3. **Uji Resolusi DNS & Routing:** Jalankan `ping` ke *gateway* lokal, IP publik, dan domain untuk membedakan masalah *routing* vs DNS.
4. **Cek Firewall / NAT:** Pastikan aturan *masquerade/NAT* dan *filter rules* tidak memblokir trafik yang dibutuhkan.
