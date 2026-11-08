# Lokasi Flutter — Modul 12

Project praktikum pengambilan GPS dan reverse geocoding sesuai Modul 12.
Target utama: Android. Tidak memerlukan Google Maps API key.

## Menjalankan di Windows / VS Code

1. Ekstrak ZIP, buka folder `lokasi_flutter` di VS Code.
2. Pastikan Flutter (Dart >= 3.5), Android SDK, dan perangkat/emulator Android tersedia; periksa dengan `flutter doctor`.
3. Jalankan `siapkan_project.bat` (klik dua kali atau `.\siapkan_project.bat` di terminal PowerShell).
   Script melengkapi file platform Android, Gradle wrapper, dan ikon menggunakan template Flutter di komputer Anda; file kode dan manifest yang sudah ada dipertahankan. Ini wajib karena SDK Flutter tidak tersedia di lingkungan pembuatan ZIP.
4. Aktifkan GPS dan internet pada perangkat, lalu jalankan:

```sh
flutter devices
flutter run
```

Linux/macOS: `bash siapkan_project.sh`, lalu `flutter run`.
Build APK setelah setup: `flutter build apk --debug`.
Hasil: `build/app/outputs/flutter-apk/app-debug.apk`.
Jika Android SDK diminta, pasang platform API 35 atau lebih baru melalui SDK Manager.

## Fitur dan penyesuaian

- Scaffold, Card, ElevatedButton, font Poppins, dan warna indigo mengikuti modul.
- `_getLocation()` memeriksa GPS, meminta izin, mengambil koordinat, kemudian menerjemahkannya menjadi alamat.
- `_isLoading`, `_kecamatan`, `_kota`, dan `_errorMessage` diperbarui dengan `setState()`.
- Ada pemeriksaan `mounted`, batas waktu, dan tombol pengaturan jika GPS mati/izin ditolak permanen.
- `subLocality` ditampilkan sebagai kelurahan/kecamatan sesuai contoh modul; isinya mengikuti penyedia alamat sehingga tingkat administrasinya dapat berbeda.
- Lokasi diperbarui setiap kali tombol ditekan, bukan pelacakan terus-menerus.
- geolocator diperbarui dari versi 7 pada modul ke seri 13 untuk Android modern; geocoding ^3.0.0 dan google_fonts ^6.1.0 mengikuti modul.
- Konfigurasi platform dibuat oleh Flutter SDK lokal, bukan disertakan sebagai hasil build. ZIP ini berisi sumber dan bootstrap, belum APK.

## Screenshot untuk laporan

Ambil screenshot asli dari perangkat/emulator:
1. Awal: buka aplikasi sebelum menekan tombol.
2. Loading: tekan tombol, tangkap saat indikator berputar.
3. Berhasil: izinkan lokasi dan tunggu alamat tampil.
4. Error: matikan GPS lalu tekan tombol; aktifkan kembali setelah screenshot.

Emulator harus diberi lokasi melalui Extended Controls > Location. Jangan memakai Chrome untuk praktikum ini karena reverse geocoding ditujukan untuk platform mobile.

## Validasi

Struktur ZIP, sintaks XML manifest, dan struktur pubspec sudah diperiksa. `flutter pub get`, analisis Dart, build APK, dan GPS belum dijalankan karena Flutter SDK/perangkat Android tidak tersedia di lingkungan pembuatannya. Setelah setup, jalankan `flutter analyze` dan uji empat kondisi di atas.

Referensi paket: https://pub.dev/packages/geolocator dan https://pub.dev/packages/geocoding
