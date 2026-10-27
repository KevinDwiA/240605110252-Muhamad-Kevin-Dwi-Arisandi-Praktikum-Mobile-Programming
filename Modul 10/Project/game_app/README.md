# game_app

**Nama:** Muhamad Kevin Dwi Arisandi  
**NIM:** 240605110252  
**Mata kuliah:** Praktikum Mobile Programming  
**Materi:** Modul 10

## Deskripsi

Aplikasi katalog game yang memuat data dari FreeToGame API melalui HTTP dan FutureBuilder. Halaman utama menampilkan maksimal 25 game; memilih game membuka detail berisi persyaratan sistem, hingga tiga screenshot, dan deskripsi dengan ReadMoreText. Model detail menggunakan json_serializable.

## Package dan aset

- Dependency tambahan: `http ^1.1.0`, `json_annotation ^4.9.0`, `readmore ^2.2.0`, `cupertino_icons ^1.0.8`.
- Aset pubspec: tidak ada aset khusus yang dideklarasikan.
- Batas versi Dart SDK: `^3.13.2`.

## Struktur penting

- [lib/main.dart](lib/main.dart)
- [lib/model/detailgame.dart](lib/model/detailgame.dart)
- [lib/model/detailgame.g.dart](lib/model/detailgame.g.dart)
- [lib/model/game.dart](lib/model/game.dart)
- [lib/view/detail.dart](lib/view/detail.dart)
- [lib/view/home.dart](lib/view/home.dart)
- [lib/viewmodel/fetchgame.dart](lib/viewmodel/fetchgame.dart)

Folder yang tersedia: `lib/`, `test/`, `android/`, `ios/`, `web/`, `windows/`, `linux/`, `macos/`.

## Menjalankan

Buka terminal di folder project ini, yaitu folder yang berisi `pubspec.yaml`, kemudian jalankan:

```bash
flutter pub get
flutter devices
flutter run -t lib/main.dart
```

Pilih perangkat yang sesuai dengan folder platform yang tersedia dan gunakan Flutter SDK yang memenuhi batas versi Dart pada `pubspec.yaml`.

Jika model JSON diubah, buat ulang file serialisasi dengan:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Batasan

Memerlukan internet dan struktur respons API yang sesuai. Kolom “Cari game” masih berupa tampilan TextField dan belum memfilter daftar.
