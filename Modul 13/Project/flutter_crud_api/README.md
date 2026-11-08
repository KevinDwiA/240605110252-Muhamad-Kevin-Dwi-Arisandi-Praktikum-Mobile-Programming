# Praktikum Modul XIII — CRUD Flutter dengan REST API

Project: `flutter_crud_api`.
Tampilan dan alur mengikuti Modul 13: AppBar indigo, teks awal, tombol +,
form Nama dan Pekerjaan, Card, menu Update/Delete, dialog konfirmasi,
serta SnackBar sukses/gagal.

## Persiapan Windows

1. Ekstrak ZIP. Buka folder `flutter_crud_api` di VS Code.
2. Pastikan Flutter SDK (Dart >= 3.3) terpasang dan periksa `flutter doctor`.
3. Jalankan `siapkan_project.bat`, atau ketik `.\siapkan_project.bat` di PowerShell.
4. Script membuat file platform Android/web, Gradle wrapper, ikon, dan konfigurasi bawaan melalui Flutter SDK lokal, lalu menjalankan `flutter pub get`. Kode aplikasi, pubspec, dan manifest yang sudah ada dipertahankan oleh `flutter create` tanpa `--overwrite`.
5. Jalankan:

```sh
flutter devices
flutter run
```

Pilih HP Android atau Chrome. Untuk Chrome langsung: `flutter run -d chrome`.
Linux/macOS: `bash siapkan_project.sh`.
Jika tidak memakai script, jalankan manual:

```sh
flutter create --platforms=android,web --project-name flutter_crud_api --org com.example --no-pub .
flutter pub get
flutter run
```

ZIP berisi kode sumber dan script pelengkap, bukan project platform hasil generate atau APK siap instal.
Jangan jalankan `flutter run` sebelum menyelesaikan setup pertama.

## Cara mencoba sesuai modul

1. Screenshot tampilan awal.
2. Tekan +, screenshot dialog Tambah Post.
3. Isi Nama dan Pekerjaan, tekan Simpan; tunggu respons API dan screenshot Card.
4. Tekan menu tiga titik > Update. Form berisi nilai sebelumnya.
5. Ubah data, tekan Update; screenshot Card dan SnackBar hijau.
6. Tekan menu tiga titik > Delete; screenshot dialog Konfirmasi Hapus.
7. Tekan Hapus; Card hilang dan muncul SnackBar hijau.
8. Untuk mencoba kegagalan jaringan, putuskan internet perangkat lalu coba Simpan. Tunggu hingga error/timeout muncul, kemudian screenshot SnackBar merah. Aktifkan internet kembali.

Input kosong dicegah dengan validasi pada form. Tombol operasi dinonaktifkan selama request.
Menambah post berikutnya menggantikan Card sebelumnya, sesuai variabel tunggal `createdPost` pada modul.

## API dan perilaku simulasi

Base URL: https://jsonplaceholder.typicode.com/posts
- CREATE: POST /posts, status sukses 201, biasanya ID 101.
- READ: menampilkan respons POST/PUT dalam Card sesuai modul; tidak ada GET tambahan.
- UPDATE: PUT /posts/1, status sukses 200. ID 1 sengaja dipakai sesuai modul karena hasil POST tidak disimpan oleh server. Sesudah update, Card mengikuti ID respons yaitu 1.
- DELETE: DELETE /posts/{id}, status sukses 200 atau 204.

API tidak membutuhkan API key. Operasi tulis hanya simulasi, bukan penyimpanan permanen.
State Card bertahan selama sesi aplikasi; hilang setelah restart/reload.
`createdAt` dicatat oleh aplikasi, bukan tanggal dari API. Label WIB memakai konversi UTC+7 eksplisit.
Dokumentasi: https://jsonplaceholder.typicode.com/guide/

## Struktur dan penjelasan

`lib/main.dart` memuat model Post, MyApp, HomePage, operasi HTTP,
dan dialog input. Nama method penting mengikuti modul:
`createPost`, `updatePost`, `deletePost`, `showAddPostDialog`,
`showUpdatePostDialog`, `showDeleteConfirmationDialog`.
Komentar menjelaskan parsing JSON, async/await, setState, dan simulasi ID 1.

Dependency mengikuti modul: http ^1.1.0, intl ^0.18.1, google_fonts ^6.1.0.
AndroidManifest.xml sudah memiliki permission INTERNET untuk request pada build rilis.
Platform utama Android dan web; iOS tidak disertakan dalam setup.

## Pemeriksaan dan keterbatasan

ZIP, pubspec YAML, dan XML manifest diperiksa saat dikemas.
Flutter SDK tidak tersedia di lingkungan pembuat, sehingga `flutter pub get`,
`flutter analyze`, build Android, dan uji UI/API dari aplikasi belum dijalankan.
Setelah setup, jalankan `flutter analyze` dan coba alur di atas.
Jika google_fonts gagal mengambil font saat offline, sambungkan internet lalu buka ulang aplikasi.
Build APK opsional: `flutter build apk --debug`.
Hasil: `build/app/outputs/flutter-apk/app-debug.apk`.
