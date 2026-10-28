# Menu Kuliah dengan ListView

**Nama project:** `demo_listview`

**Nama:** Muhamad Kevin Dwi Arisandi  
**NIM:** 240605110252  
**Mata kuliah:** Praktikum Mobile Programming  
**Materi:** Modul 06

## Deskripsi

Menu perkuliahan berbentuk ListView dengan enam ListTile. Setiap item berisi ikon aset lokal, judul, subjudul, latar berwarna, dan ikon bintang.

## Package dan aset

- Dependency tambahan: `cupertino_icons ^1.0.8`.
- Aset pubspec: `assets/icon/`.
- Batas versi Dart SDK: `^3.13.2`.

## Struktur penting

- [lib/main.dart](lib/main.dart)

Folder yang tersedia: `lib/`, `test/`, `android/`, `ios/`, `web/`, `windows/`, `linux/`, `macos/`.

## Menjalankan

Buka terminal di folder project ini, yaitu folder yang berisi `pubspec.yaml`, kemudian jalankan:

```bash
flutter pub get
flutter devices
flutter run -t lib/main.dart
```

Pilih perangkat yang sesuai dengan folder platform yang tersedia dan gunakan Flutter SDK yang memenuhi batas versi Dart pada `pubspec.yaml`.

## Batasan

Daftar merupakan demonstrasi widget; item belum membuka halaman lain.
