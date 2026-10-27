# demo_navigasi

**Nama:** Muhamad Kevin Dwi Arisandi  
**NIM:** 240605110252  
**Mata kuliah:** Praktikum Mobile Programming  
**Materi:** Modul 07

## Deskripsi

Demonstrasi perpindahan antara halaman Home dan Tujuan menggunakan named route. MaterialApp mendefinisikan route / dan /tujuan, tombol membuka tujuan melalui Navigator.pushNamed, dan tombol kembali menggunakan Navigator.pop.

## Package dan aset

- Dependency tambahan: `cupertino_icons ^1.0.8`.
- Aset pubspec: tidak ada aset khusus yang dideklarasikan.
- Batas versi Dart SDK: `^3.13.2`.

## Struktur penting

- [lib/home.dart](lib/home.dart)
- [lib/main.dart](lib/main.dart)
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

Halaman berisi teks dan tombol untuk latihan navigasi tanpa pengiriman data.
