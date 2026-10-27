# row_and_column

**Nama:** Muhamad Kevin Dwi Arisandi  
**NIM:** 240605110252  
**Mata kuliah:** Praktikum Mobile Programming  
**Materi:** Modul 02

## Deskripsi

Latihan penyusunan widget menggunakan Row dan Column. Empat kotak bertuliskan Satu, Dua, Tiga, dan Empat ditampilkan dalam dua baris; setiap kotak memiliki warna, ikon hati, dan teks melalui widget KotakKustom.

## Package dan aset

- Dependency tambahan: `cupertino_icons ^1.0.8`.
- Aset pubspec: tidak ada aset khusus yang dideklarasikan.
- Batas versi Dart SDK: `^3.13.2`.

## Struktur penting

- [lib/main.dart](lib/main.dart)

Folder yang tersedia: `lib/`, `test/`, `android/`.

## Menjalankan

Buka terminal di folder project ini, yaitu folder yang berisi `pubspec.yaml`, kemudian jalankan:

```bash
flutter pub get
flutter devices
flutter run -t lib/main.dart
```

Pilih perangkat yang sesuai dengan folder platform yang tersedia dan gunakan Flutter SDK yang memenuhi batas versi Dart pada `pubspec.yaml`.

## Batasan

Ukuran kotak dan jarak ditentukan secara tetap untuk demonstrasi tata letak.
