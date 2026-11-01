# Workspace Rules - RideOn

## Strict Scope Adherence (Prinsip Utama)
1. **Dilarang keras membuat atau mengimplementasikan apa pun yang tidak disuruh**:
   - Jangan membuat layar, fitur, form, alur, atau file baru di luar instruksi spesifik pengguna.
   - Jika pengguna hanya menyuruh membuat komponen/layar tertentu (misal: SplashScreen), buat **HANYA** komponen tersebut. Jangan menambahkan layar Login, Home, Register, atau navigasi otomatis ke layar lain yang belum diminta.
2. **Minimalis & Presisi**:
   - Implementasikan desain sesuai dengan aset dan instruksi yang diberikan, tanpa improvisasi elemen UI tambahan yang tidak ada di desain Figma.
   - Selesaikan tepat apa yang diminta, lalu tunggu instruksi selanjutnya dari pengguna.
3. **Link figma selalu di chek sebagai acuan dan tiru 99 persen**: https://www.figma.com/design/UgRP3mJS4SwLJ2Z3Pzo7jR/Qcumber?node-id=0-1 **dan prototype**: https://www.figma.com/design/UgRP3mJS4SwLJ2Z3Pzo7jR/Qcumber?node-id=0-1&t=b9tN1lFqwhaAXO4U-1
4. **Konsistensi & Presisi Visual**:
   - Untuk ikon dan gambar, selalu gunakan file aset yang telah disediakan dari folder `assets/images/` dan `assets/icons/`.
   - **JANGAN** membuat ikon atau gambar secara manual (misalnya menggunakan `Icon()` widget, `Image.network()`, atau SVG dari library) jika aset visualnya sudah ada dalam folder aset proyek. Prioritas utama adalah menggunakan aset resmi dari folder `assets/` jika tidak ada baru boleh membuat ikon atau gambar secara manual.
   - Saat menampilkan elemen-elemen notifikasi pada foto (seperti badge pesan, status online, dll.), pastikan untuk: 
      1) Menggunakan ikon yang tersedia di `assets/icons/` jika ada,
      2) Mengatur ukuran (height/width), posisi, dan padding agar proporsional dan terlihat pas dengan desain foto asli.
      3) Mempertahankan spacing dan layout agar konsisten dengan desain utama di figma.
   - **Skala Figma & Flutter Hot Restart**:
      1) Selalu mengacu pada dimensi logical pixel (1x) pada desain Figma agar rasio proporsional.
      2) Saat mengubah CustomClipper atau widget bertanda const, selalu instruksikan atau jalankan Hot Restart (Shift + R / R) agar perubahan langsung diterapkan di runtime perangkat.
5. **selalu gunakan /grill-me /plan dan /compact /plugins /learn untuk menjalankan perintah, lakukan dengan benar dan tepat sesuai dengan fungsinya**
6. **setiap ada file baru dan codingan baru, tambahkan ke main.dart ataupun main_scaffold.dart(sesuai kebutuhan dan fungsinya) untuk menampung layar yang baru dibuat dan aktifkan tombol navigasinya, jika sudah selesai jelaskan kepada user**