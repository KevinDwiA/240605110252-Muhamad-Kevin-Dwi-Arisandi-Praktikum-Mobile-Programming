# Tasbih Digital dengan GetX

**Nama project:** `tasbih_getx`

**Nama:** Muhamad Kevin Dwi Arisandi  
**NIM:** 240605110252  
**Mata kuliah:** Praktikum Mobile Programming  
**Materi:** Modul 11

## Deskripsi

Aplikasi tasbih digital dengan manajemen state GetX. TasbihController mengelola counter dan progress sebagai variabel reaktif .obs; Obx memperbarui tampilan tanpa setState. Tombol fingerprint menambah hitungan hingga 33, sedangkan reset mengembalikan hitungan dan progress ke nol.

## Package dan aset

- Dependency tambahan: `get ^4.6.5`, `simple_circular_progress_bar ^1.0.2`.
- Aset pubspec: tidak ada aset khusus yang dideklarasikan.
- Batas versi Dart SDK: `>=3.4.0 <4.0.0`.

## Struktur penting

- [lib/main.dart](lib/main.dart)
- [lib/view/home.dart](lib/view/home.dart)
- [lib/viewmodel/tasbih_controller.dart](lib/viewmodel/tasbih_controller.dart)

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

State berada di memori dan kembali ke kondisi awal setelah aplikasi dimulai ulang. Tampilan akhir memakai LinearProgressIndicator; simple_circular_progress_bar tetap tercantum dalam dependensi mengikuti modul.
