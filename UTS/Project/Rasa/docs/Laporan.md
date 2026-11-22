LAPORAN UTS MOBILE PROGRAMMING

rasa.

Aplikasi Penjelajah Resep Makanan Berbasis Flutter dan REST API

Identitas | Keterangan

Nama | Muhamad Kevin Dwi Arisandi

NIM | [ISI NIM LENGKAP]

Kelas | [ISI KELAS]

Program studi | Teknik Informatika

Universitas | UIN Maulana Malik Ibrahim Malang

Semester soal | Ganjil 2025/2026

[MASUKKAN LOGO FAKULTAS RESMI]

Draf laporan. Lengkapi identitas, logo, screenshot aplikasi, dan hasil pengujian sebelum dikumpulkan. Integrasi API diimplementasikan pada kode; kompilasi dan runtime Flutter belum diverifikasi.


---


1. Pendahuluan

Rasa adalah aplikasi penjelajah resep makanan yang membantu pengguna menemukan ide memasak berdasarkan nama dan kategori. Informasi yang ditampilkan meliputi foto hidangan, nama resep, kategori, asal masakan, bahan beserta takaran, dan instruksi memasak. Data dimuat melalui REST API TheMealDB sehingga antarmuka tidak hanya menampilkan data dummy lokal.

Tema makanan dipilih karena memiliki potensi visual melalui foto hidangan dan kategori yang mudah dipahami. Alur dari beranda, daftar, hingga detail juga sesuai untuk mempelajari layout dan navigasi aplikasi mobile. Tujuan implementasi adalah membangun tiga halaman yang terhubung, memproses respons JSON dari server, serta menangani kondisi loading, hasil kosong, dan kegagalan jaringan.

Sesuai arahan tambahan asisten lab yang disampaikan pengguna, data resep diperoleh melalui API. Aplikasi menggunakan endpoint GET dan bersifat read-only, sehingga tidak memerlukan backend buatan sendiri atau database lokal. Endpoint yang dipakai adalah kategori, pencarian, filter kategori, dan detail berdasarkan ID.

2. Perancangan Antarmuka

Konsep desain dibuat mandiri dengan tampilan editorial kuliner. Terakota menjadi aksen utama, hijau gelap menjadi warna banner, dan krem sebagai latar. Foto hidangan ditampilkan menonjol agar daftar mudah dipindai. Tipografi memakai font Material bawaan, dengan perbedaan ukuran dan ketebalan untuk membedakan judul, nama resep, dan metadata.

Aspek | Rancangan

Palet | #B74423 terakota; #243C30 hijau gelap; #FFFAF3 krem

Komponen | Kartu foto, kategori horizontal, kolom cari, daftar bahan

Responsif | Grid 1/2/3 kolom berdasarkan lebar; konten detail dapat digulir

Navigasi | Navigator.push dan AppBar kembali

Sumber visual | Foto dari TheMealDB; rancangan layout mandiri


---


2.1 Rancangan Tiga Halaman

Gambar berikut merupakan rancangan UI, bukan screenshot Flutter. Area foto menandai lokasi gambar yang nantinya dimuat dari URL API. Nama resep mengikuti respons server.

Beranda memuat banner ajakan menjelajah, daftar kategori horizontal, dan inspirasi resep ayam. Menekan kategori membuka daftar hasil kategori. Tombol pencarian membuka daftar pencarian global. Menekan kartu hasil membawa pengguna ke detail melalui ID resep.

Detail menampilkan foto besar dan informasi lengkap. Bahan disusun sebagai daftar agar mudah dibaca, sedangkan instruksi disajikan dalam teks yang dapat dipilih. Bahasa konten resep tetap mengikuti sumber API, yaitu Inggris. Desain tidak menampilkan informasi kalori atau durasi memasak yang tidak disediakan oleh sumber.


---


3. Implementasi Program

Berkas | Fungsi

lib/main.dart | Entry point RasaApp dan tema Material 3

lib/models/meal.dart | Pemetaan Meal, MealCategory, bahan dan takaran

lib/services/meal_api.dart | HTTP GET, timeout, decoding dan penanganan error

lib/screens/home_screen.dart | Kategori dan inspirasi resep dari server

lib/screens/meal_list_screen.dart | Pencarian global / daftar per kategori

lib/screens/meal_detail_screen.dart | Permintaan detail berdasarkan idMeal

lib/widgets/components.dart | Grid adaptif, kartu, gambar, error dan retry

FutureBuilder mengelola tampilan berdasarkan status Future. Future awal dibuat di initState agar permintaan tidak diulang setiap build. Pemanggilan ulang dilakukan ketika pengguna mengirim pencarian, menekan coba lagi, atau menarik beranda untuk menyegarkan data. Navigator.push menggunakan MaterialPageRoute untuk perpindahan halaman.

```
Navigator.push(context, MaterialPageRoute<void>(
  builder: (_) => MealDetailScreen(id: meal.id),
));
```

Widget utama meliputi Scaffold, AppBar, Container, Column, Row, Card, ListView, GridView.builder, TextField, Image.network, dan RefreshIndicator. Gambar memiliki indikator loading dan fallback ikon jika gagal. ListView menyediakan pengguliran, sedangkan jumlah kolom grid disesuaikan melalui LayoutBuilder.


---


3.1 Integrasi REST API

Base URL: https://www.themealdb.com/api/json/v1/1/. Angka 1 merupakan test key publik yang diizinkan penyedia untuk pembelajaran dan pengembangan. Aplikasi tidak menggunakan API premium dan tidak membutuhkan akun untuk demonstrasi ini. Ketentuan penggunaan untuk rilis publik mengikuti ketentuan penyedia.

Endpoint GET | Pemakaian

categories.php | Kategori pada beranda

search.php?s=chicken | Inspirasi resep ayam

search.php?s=Arrabiata | Contoh pencarian nama resep

filter.php?c=Seafood | Daftar ringkas resep kategori Seafood

lookup.php?i=52772 | Detail lengkap resep berdasarkan ID

```
final uri = Uri.https('www.themealdb.com',
  '/api/json/v1/1/search.php', {'s': query});
final response = await http.get(uri)
  .timeout(const Duration(seconds: 20));
final json = jsonDecode(utf8.decode(response.bodyBytes));
```

Model menggunakan idMeal, strMeal, strMealThumb, strCategory, strArea, dan strInstructions. Daftar bahan dibentuk dari pasangan strIngredient1 sampai strIngredient20 dan strMeasure1 sampai strMeasure20; nilai kosong diabaikan. Respons meals:null dipetakan menjadi daftar kosong. Hasil kategori hanya memuat ringkasan, sehingga detail selalu diambil melalui lookup.php.

Timeout dibatasi 20 detik. Kegagalan jaringan, status HTTP selain 200, dan kegagalan parsing menghasilkan pesan serta tombol coba lagi. Seluruh permintaan menggunakan HTTPS. Izin INTERNET Android ditambahkan oleh setup.ps1. Tidak ada data resep dummy atau fallback JSON lokal.


---


4. Hasil dan Pembahasan

Kode aplikasi, struktur model, dan alur HTTP telah disusun. Contoh endpoint pencarian, kategori, dan detail dapat dibaca melalui akses web pada saat penyusunan, dengan respons JSON yang sesuai dengan pemetaan model. Pemeriksaan ini membuktikan ketersediaan contoh data saat dicek, bukan keberhasilan runtime aplikasi Flutter.

Flutter SDK tidak tersedia di lingkungan penyusunan. Oleh karena itu pub get, analyze, build, navigasi runtime, dan kesesuaian visual terhadap mockup belum diverifikasi. Screenshot implementasi belum tersedia dan harus ditambahkan setelah aplikasi dijalankan. Skrip Windows juga perlu diverifikasi pada perangkat pengguna.

Skenario uji lokal | Hasil yang diharapkan

Buka beranda dengan internet | Kategori dan resep ayam dimuat dari API

Pilih kategori Seafood | Daftar berasal dari filter.php?c=Seafood

Cari Arrabiata | Hasil pencarian API ditampilkan

Cari nama acak tanpa hasil | Pesan resep tidak ditemukan

Buka kartu resep | lookup.php mengambil bahan dan instruksi

Matikan internet, muat ulang | Pesan gagal dan tombol coba lagi

Aktifkan internet, coba lagi | Data dimuat kembali

Layar sempit / teks besar | Periksa grid, kartu, dan pengguliran

Status seluruh skenario runtime: BELUM DIUJI. Tambahkan hasil aktual, perangkat, versi Flutter, dan screenshot Beranda, Daftar, serta Detail. Bandingkan warna, layout, keterbacaan, dan navigasi dengan rancangan awal sebelum menyimpulkan aplikasi memenuhi tujuan.

5. Kesimpulan

Rasa mengubah tema proyek menjadi penjelajah resep makanan dengan tiga halaman dan integrasi API publik. Pemisahan model, service, screens, dan widgets mendukung keteraturan kode. Pencapaian yang tersedia adalah implementasi sumber dan rancangan, sedangkan keberhasilan akhir perlu dibuktikan melalui pengujian Flutter. Pengembangan selanjutnya dapat mencakup favorit lokal, filter tambahan, dan caching.


---


6. Menjalankan dan Mengumpulkan

Ekstrak ZIP, buka folder Rasa, lalu jalankan perintah berikut di PowerShell. Skrip membangkitkan proyek baru rasa_app di sebelah Rasa, menyalin kode, menambahkan izin jaringan, dan memulihkan dependensi. Jika rasa_app sudah ada, skrip berhenti agar pekerjaan yang ada tidak ditimpa.

```
flutter --version
powershell -ExecutionPolicy Bypass -File .\setup.ps1
```

Buka folder rasa_app melalui VS Code, lalu jalankan flutter run. Jika editor masih menampilkan error setelah pub get berhasil, gunakan Dart: Restart Analysis Server. README menyediakan cara manual untuk sistem operasi lain serta langkah perbaikan dasar.

Lengkapi identitas dan logo pada laporan, jalankan pengujian, lalu masukkan screenshot asli. Sumber teks Laporan.md tersedia agar laporan mudah diedit dan diekspor ulang. Unggah proyek rasa_app lengkap ke GitHub dan PDF final ke Google Drive. Tautan pengumpulan belum dibuat pada paket ini.

Referensi

TheMealDB. Free Recipe API. https://www.themealdb.com/api.php

TheMealDB. API Guide. https://www.themealdb.com/docs_api_guide.php

Flutter. Navigate to a new screen and back. https://docs.flutter.dev/cookbook/navigation/navigation-basics

Acuan: Soal UTS.pdf dan arahan tambahan penggunaan API dari asisten lab yang disampaikan pengguna.