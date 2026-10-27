# tasbih_digital

**Nama:** Muhamad Kevin Dwi Arisandi  
**NIM:** 240605110252  
**Mata kuliah:** Praktikum Mobile Programming  
**Materi:** Modul 09

## Deskripsi

Aplikasi tasbih digital dengan penghitung maksimal 33, tombol fingerprint untuk menambah hitungan, dan tombol reset. setState memperbarui hitungan, sedangkan ValueNotifier menggerakkan SimpleCircularProgressBar.

## Package dan aset

- Dependency tambahan: `simple_circular_progress_bar ^1.0.2`, `cupertino_icons ^1.0.8`.
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

Hitungan tidak disimpan setelah aplikasi ditutup. Teks di tengah lingkaran dihitung dari persentase yang dibagi 3, sehingga pada beberapa nilai dapat berbeda dari penghitung di atas.
