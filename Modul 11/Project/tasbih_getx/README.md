# Modul XI - Manajemen State dengan GetX

Nama: Muhamad Kevin Dwi Arisandi  
NIM: 240605110252

Implementasi aplikasi tasbih digital sesuai Modul 11: penghitung 0–33, progress linear 0–100%, tombol fingerprint untuk menambah, dan reset. Warna latar serta komponen mengikuti contoh modul. Tampilan dibungkus scroll agar dapat diakses di layar pendek.

## Menjalankan

Buka terminal pada folder ini (yang berisi pubspec.yaml):

```bash
flutter pub get
flutter run
```

Untuk mencoba lewat Chrome:

```bash
flutter run -d chrome
```

## Struktur

- lib/main.dart: GetMaterialApp dan registrasi controller melalui initialBinding.
- lib/model/: tempat model, belum membutuhkan kelas data untuk praktikum ini.
- lib/view/home.dart: tampilan stateless, Obx, dan tombol.
- lib/viewmodel/tasbih_controller.dart: RxDouble counter/progress dan metode aksi.
- test/tasbih_controller_test.dart: uji batas maksimum, progress, dan reset.

Registrasi Get.put dilakukan sekali melalui initialBinding; Home mengambilnya melalui Get.find. Ini mempertahankan konsep controller GetX pada modul tanpa membuat controller baru saat build. simple_circular_progress_bar disertakan sesuai daftar dependensi modul, tetapi tidak diimpor karena contoh akhir memakai LinearProgressIndicator.

## Pengujian di komputer sendiri

```bash
flutter analyze
flutter test
```

Coba kondisi 0, 1, 32, 33, ketukan tambahan setelah 33, lalu reset. Ambil screenshot sendiri saat aplikasi dijalankan untuk laporan. Project ini tidak menyertakan screenshot hasil eksekusi atau laporan praktikum.

Kode dan kelengkapan file diperiksa saat penyusunan, tetapi flutter analyze, flutter test, dan build belum dijalankan di lingkungan pembuat karena Flutter SDK tidak tersedia. Jalankan pemeriksaan di atas sebelum pengumpulan.

Folder platform berasal dari scaffold Flutter pada project praktikum yang diunggah, lalu nama aplikasi disesuaikan. Build/cache tidak dibundel. pubspec.lock akan dibuat setelah flutter pub get; sertakan file tersebut ketika commit.
