# Rasa - Aplikasi Resep Makanan

**Nama:** Muhamad Kevin Dwi Arisandi  
**NIM:** 240605110252  
**Mata kuliah:** Praktikum Mobile Programming  
**Materi:** UTS

## Deskripsi

Rasa adalah aplikasi penjelajah resep menggunakan REST API TheMealDB. Fitur meliputi kategori makanan, pencarian nama resep, daftar resep per kategori, serta detail bahan dan instruksi memasak. FutureBuilder menampilkan proses pemuatan, dan halaman error menyediakan tombol coba lagi.

## Package dan aset

- Dependency tambahan: `http ^1.2.0`.
- Aset pubspec: tidak ada aset khusus yang dideklarasikan.
- Batas versi Dart SDK: `>=3.3.0 <4.0.0`.

## Struktur penting

- [lib/main.dart](lib/main.dart)
- [lib/models/meal.dart](lib/models/meal.dart)
- [lib/screens/home_screen.dart](lib/screens/home_screen.dart)
- [lib/screens/meal_detail_screen.dart](lib/screens/meal_detail_screen.dart)
- [lib/screens/meal_list_screen.dart](lib/screens/meal_list_screen.dart)
- [lib/services/meal_api.dart](lib/services/meal_api.dart)
- [lib/widgets/components.dart](lib/widgets/components.dart)

Folder yang tersedia: `lib/`, `web/`.

## Menjalankan

Buka terminal di folder project ini, yaitu folder yang berisi `pubspec.yaml`, kemudian jalankan:

```bash
flutter pub get
flutter devices
flutter run -t lib/main.dart
```

Pilih perangkat yang sesuai dengan folder platform yang tersedia dan gunakan Flutter SDK yang memenuhi batas versi Dart pada `pubspec.yaml`.

## Batasan

Memerlukan internet. Isi resep mengikuti bahasa sumber API, terutama bahasa Inggris. Kode saat ini belum menerapkan Shared Preferences, SQLite, atau penyimpanan file; folder platform yang tersedia di repository adalah web.

## Laporan

Laporan PDF berada di folder UTS, sejajar dengan folder Project: [Laporan UTS Rasa](../../Laporan_UTS_Rasa_Kevin.pdf).
