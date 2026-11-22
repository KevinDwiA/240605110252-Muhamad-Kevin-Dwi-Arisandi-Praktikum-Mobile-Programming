# rasa. - Temukan rasa, ciptakan cerita.
Aplikasi Flutter penjelajah resep dunia untuk UTS Mobile Programming.
Tema baru pengganti TugasKu: foto makanan, warna terakota, hijau gelap, dan krem.

## Halaman
1. Beranda: banner, kategori dari server, dan inspirasi resep ayam.
2. Daftar / pencarian: grid responsif, cari resep dan daftar per kategori.
3. Detail: gambar besar, kategori, negara/area, bahan beserta takaran, instruksi.

Navigator.push + MaterialPageRoute menghubungkan ketiganya. Kembali melalui AppBar.
Kategori membuka daftar resep kategori; ikon cari membuka pencarian global.
Pencarian dijalankan ketika tekan Enter/tombol cari, bukan setiap ketikan.
Dalam kategori, pencarian menyaring nama pada hasil kategori dari API.

## API yang dipakai
Penyedia: **TheMealDB** https://www.themealdb.com/api.php
Dokumentasi: https://www.themealdb.com/docs_api_guide.php
Base URL: https://www.themealdb.com/api/json/v1/1/
Test key publik `1` diizinkan penyedia untuk pengembangan/pendidikan.
Tidak perlu membuat backend PHP, database MySQL, akun, atau API key pribadi
untuk tugas demonstrasi ini. Ketentuan publikasi app store berbeda; lihat penyedia.

| Endpoint GET | Penggunaan |
| --- | --- |
| categories.php | Kategori di beranda |
| search.php?s=chicken | Inspirasi ayam pada beranda |
| search.php?s=Arrabiata | Pencarian nama resep global |
| filter.php?c=Seafood | Daftar resep per kategori |
| lookup.php?i=52772 | Detail resep berdasarkan ID |

Semua data resep berasal dari respons HTTP, bukan dummy/JSON lokal. Internet wajib.
Nama, bahan dan instruksi berbahasa Inggris mengikuti sumber API; UI berbahasa Indonesia.
Foto serta resep diberi atribusi TheMealDB. Aplikasi tidak mengklaim resep buatan sendiri.
API tidak menyediakan waktu masak atau kalori yang konsisten; aplikasi tidak mengarangnya.
Aplikasi ini read-only: tidak menyediakan tambah/edit/hapus resep server.

## Menyiapkan Windows (disarankan)
Prasyarat: Flutter SDK dengan Dart >=3.3, ekstensi Flutter VS Code, Android SDK
beserta emulator atau HP debugging. Koneksi internet untuk pub get dan API.

1. Ekstrak ZIP, buka folder **Rasa** (yang berisi setup.ps1).
2. Buka terminal PowerShell, jalankan:

```powershell
flutter --version
powershell -ExecutionPolicy Bypass -File .\setup.ps1
```

3. Skrip membuat folder baru **rasa_app** di sebelah Rasa. Folder yang sudah ada
   tidak ditimpa. Skrip membangkitkan platform Android/web, menyalin kode,
   mengaktifkan izin INTERNET, lalu menjalankan pub get dan analyze.
4. Pilih **File > Open Folder > rasa_app** di VS Code, kemudian:

```sh
flutter devices
flutter run
```

Atau `flutter run -d chrome` untuk web. Gunakan `Dart: Restart Analysis Server`
jika editor masih menyimpan error lama setelah pub get berhasil.

## Cara manual (semua OS)
Dari dalam folder Rasa:
```sh
flutter create --project-name rasa --platforms=android,web .
flutter pub get
flutter analyze
flutter run
```
Pertahankan lib dan pubspec.yaml dari paket ini. Hapus test/widget_test.dart
contoh counter bila flutter create membuatnya (aplikasi ini tidak memakai counter).
Untuk build Android release, tambahkan di android/app/src/main/AndroidManifest.xml,
di dalam <manifest>, sejajar dengan <application>:
```xml
<uses-permission android:name="android.permission.INTERNET" />
```
Skrip Windows melakukan langkah izin ini secara otomatis.

## Struktur kode
- lib/main.dart: tema dan entry point RasaApp.
- lib/models/meal.dart: mapping respons resep, bahan 1..20, kategori.
- lib/services/meal_api.dart: HTTP GET, query URL, timeout 20 detik, decoding JSON.
- lib/screens/: beranda, daftar/pencarian, detail.
- lib/widgets/components.dart: kartu, gambar jaringan, error/retry, grid adaptif.
- docs/: draf laporan, rancangan UI mandiri, checklist pengujian.

Future dibuat di initState dan diperbarui hanya saat submit/retry/refresh untuk
menghindari request berulang pada setiap build. Tidak ada cache persisten.
Respons meals:null dipetakan menjadi daftar kosong. Filter kategori memberikan
ringkasan; detail selalu diambil kembali dengan lookup.php, bukan menampilkan
ringkasan sebagai resep lengkap. Foto gagal dimuat diganti ikon restoran.

## Status verifikasi
- Contoh respons pencarian, kategori, dan detail diperiksa melalui akses web.
- Jalur impor lokal dan delimiter kode diperiksa secara statis.
- Flutter SDK tidak tersedia di lingkungan penyusunan: pub get, analyze,
  build, runtime dan screenshot asli **belum diverifikasi**.
- setup.ps1 juga belum dieksekusi di Windows; baca output jika ada kegagalan.
- UI mockup adalah rancangan, bukan bukti aplikasi sudah berjalan.

## Checklist sebelum pengumpulan
- Jalankan setup dan aplikasi, catat flutter --version dan flutter analyze.
- Uji kategori, pencarian Arrabiata, hasil kosong, detail, kembali, offline/retry.
- Periksa layar sempit dan teks besar; screenshot tiga halaman asli.
- Lengkapi NIM, kelas, logo, hasil pengujian dan screenshot di laporan.
- Upload folder rasa_app lengkap hasil setup ke GitHub, bukan hanya folder Rasa.
- Upload PDF final ke Google Drive dan kumpulkan kedua link.
