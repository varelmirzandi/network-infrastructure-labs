# RB951Ui-2nD Home Network Configuration (`rb951ui-home-lab.rsc`)

Ringkasan konfigurasi dasar router MikroTik RB951Ui-2nD (RouterOS v7) untuk segmentasi port/interface, pembatasan bandwidth sederhana, serta akses keluar jaringan:

- **WAN & NAT:** `ether1` menerima IP via DHCP client dengan `srcnat` (`masquerade`) agar trafik LAN dapat keluar ke jaringan hulu.
- **LAN & Bridge:** `ether2` dan `wlan1` digabungkan ke dalam `bridge1` (`172.16.9.1/24`), sementara `ether3`, `ether4`, dan `ether5` dipisah ke subnet masing-masing (`192.168.100.1/24`, `192.168.3.1/24`, dan `192.168.5.1/24`) lengkap dengan DHCP server dan pool.
- **Simple Queue:** Penerapan batas kecepatan per target interface (`bridge1`, `ether3`, `ether4`, `ether5`) untuk menjaga pembagian bandwidth tetap terkendali.
- **Remote & Monitoring:** Klien L2TP disiapkan untuk kebutuhan akses jarak jauh dan RoMON diaktifkan untuk manajemen perangkat.
- **Catatan Keamanan:** Security profile wireless sebaiknya menggunakan `wpa2-psk` dengan `aes-ccm` saja (menghindari `tkip` / mode campuran lama pada produksi bila semua perangkat klien mendukung WPA2-AES), serta pastikan aturan firewall `input`/`forward` dikonfigurasi dengan ketat saat terhubung langsung ke jaringan publik.
