# Kartu Musik

**Nama project:** `music_card`

**Nama:** Muhamad Kevin Dwi Arisandi  
**NIM:** 240605110252  
**Mata kuliah:** Praktikum Mobile Programming  
**Materi:** Modul 05

## Deskripsi

Tampilan kartu musik bertema gelap menggunakan Card, Padding, Column, Row, dan Spacer. Kartu memuat ikon album, contoh judul lagu, nama artis, dan tombol favorit.

## Package dan aset

- Dependency tambahan: `cupertino_icons ^1.0.8`.
- Aset pubspec: tidak ada aset khusus yang dideklarasikan.
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

Judul dan nama artis berupa teks contoh. Tombol favorit belum mengubah state dan belum ada pemutaran audio.
