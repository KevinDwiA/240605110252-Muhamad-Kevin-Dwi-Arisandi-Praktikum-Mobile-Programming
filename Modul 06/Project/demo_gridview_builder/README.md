# Daftar Berita dengan GridView.builder

**Nama project:** `demo_gridview_builder`

**Nama:** Muhamad Kevin Dwi Arisandi  
**NIM:** 240605110252  
**Mata kuliah:** Praktikum Mobile Programming  
**Materi:** Modul 06

## Deskripsi

Menampilkan berita kategori teknologi bisnis melalui GridView.builder dua kolom. Data JSON diambil secara asynchronous dengan HTTP dari endpoint https://jakpost.vercel.app/api/category/business/tech, lalu ditampilkan sebagai gambar dan judul berita.

## Package dan aset

- Dependency tambahan: `http ^1.6.0`, `cupertino_icons ^1.0.8`.
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

Memerlukan koneksi internet serta respons API yang sesuai. Kegagalan pengambilan data dicetak ke konsol; belum ada pesan error khusus pada halaman.
