# demo_navigasi_namedroute

**Nama:** Muhamad Kevin Dwi Arisandi  
**NIM:** 240605110252  
**Mata kuliah:** Praktikum Mobile Programming  
**Materi:** Modul 08

## Deskripsi

Mengambil detail game ID 475 dari FreeToGame API. Halaman Home menampilkan informasi game, lalu mengirim cover, judul, deskripsi, dan ringkasan melalui ScreenArguments ke halaman Tujuan menggunakan Navigator.pushNamed.

## Package dan aset

- Dependency tambahan: `http ^1.6.0`, `cupertino_icons ^1.0.8`.
- Aset pubspec: tidak ada aset khusus yang dideklarasikan.
- Batas versi Dart SDK: `^3.13.2`.

## Struktur penting

- [lib/home.dart](lib/home.dart)
- [lib/main.dart](lib/main.dart)
- [lib/screen_arguments.dart](lib/screen_arguments.dart)
- [lib/tujuan.dart](lib/tujuan.dart)

Folder yang tersedia: `lib/`, `test/`, `android/`, `web/`.

## Menjalankan

Buka terminal di folder project ini, yaitu folder yang berisi `pubspec.yaml`, kemudian jalankan:

```bash
flutter pub get
flutter devices
flutter run -t lib/main.dart
```

Pilih perangkat yang sesuai dengan folder platform yang tersedia dan gunakan Flutter SDK yang memenuhi batas versi Dart pada `pubspec.yaml`.

## Batasan

Memerlukan internet dan data API yang sesuai, termasuk daftar screenshot. Penanganan kegagalan jaringan belum ditampilkan secara khusus pada UI.
