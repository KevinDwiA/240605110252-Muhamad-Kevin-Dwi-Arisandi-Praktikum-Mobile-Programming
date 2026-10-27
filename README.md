# Praktikum Mobile Programming

**Nama:** Muhamad Kevin Dwi Arisandi  
**NIM:** 240605110252  
**Program Studi:** Teknik Informatika  
**Universitas:** UIN Maulana Malik Ibrahim Malang

Repository pengumpulan project Flutter dan Dart beserta laporan praktikum Mobile Programming.

## Daftar modul

Kode sumber untuk **20 project** dan laporan PDF Modul 01–11 serta UTS telah diunggah. Tautan berikut mengarah ke project dan laporan yang tersedia di repository.

| Materi | Topik | Project | Laporan | Status unggahan |
|---|---|---|---|---|
| [Modul 01](Modul%2001/) | Pengenalan Flutter | [pengujian](Modul%2001/Project/pengujian/pengujian/) | [PDF](Modul%2001/LAPRAK%20MODUL%201.pdf) | Project dan laporan diunggah |
| [Modul 02](Modul%2002/) | Row dan Column | [row_and_column](Modul%2002/Project/row_and_column/) | [PDF](Modul%2002/240605110252_Muhamad%20Kevin%20Dwi%20Arisandi_Modul%202.pdf) | Project dan laporan diunggah |
| [Modul 03](Modul%2003/) | Alignment | [alignment](Modul%2003/Project/alignment/) | [PDF](Modul%2003/LAPRAK%20MODUL%203.pdf) | Project dan laporan diunggah |
| [Modul 04](Modul%2004/) | Expanded dan Flexible | [demo_flexible](Modul%2004/Project/demo_flexible/) | [PDF](Modul%2004/LAPORAN%20MODUL%204.pdf) | Project dan laporan diunggah |
| [Modul 05](Modul%2005/) | Card, SizedBox, dan Spacer | [demo_card](Modul%2005/Project/demo_card/), [demo_sizedbox](Modul%2005/Project/demo_sizedbox/), [music_card](Modul%2005/Project/music_card/) | [PDF](Modul%2005/Laporan_Praktikum_Modul_5_Kevin.pdf) | Project dan laporan diunggah |
| [Modul 06](Modul%2006/) | ListView dan GridView | [demo_gridview](Modul%2006/Project/demo_gridview/), [demo_gridview_builder](Modul%2006/Project/demo_gridview_builder/), [demo_listview](Modul%2006/Project/demo_listview/) | [PDF](Modul%2006/Laporan_Praktikum_Modul_6_Kevin.pdf) | Project dan laporan diunggah |
| [Modul 07](Modul%2007/) | Navigasi antarhalaman | [demo_navigasi](Modul%2007/Project/demo_navigasi/), [demo_navigasi_pageroute](Modul%2007/Project/demo_navigasi_pageroute/), [tugas_modul_7](Modul%2007/Project/tugas_modul_7/) | [PDF](Modul%2007/240605110252_Muhamad%20Kevin%20Dwi%20Arisandi_Modul%207.pdf) | Project dan laporan diunggah |
| [Modul 08](Modul%2008/) | Named Route dan Argumen | [demo_navigasi_namedroute](Modul%2008/Project/demo_navigasi_namedroute/), [tugas_modul_8](Modul%2008/Project/tugas_modul_8/) | [PDF](Modul%2008/240605110252_Muhamad%20Kevin%20Dwi%20Arisandi_Modul%208.pdf) | Project dan laporan diunggah |
| [Modul 09](Modul%2009/) | StatefulWidget dan setState | [counter_app](Modul%2009/Project/counter_app/), [tasbih_digital](Modul%2009/Project/tasbih_digital/) | [PDF](Modul%2009/Laporan_Praktikum_Modul_9_Kevin.pdf) | Project dan laporan diunggah |
| [Modul 10](Modul%2010/) | HTTP API dan Model Data | [game_app](Modul%2010/Project/game_app/) | [PDF](Modul%2010/Laporan_Praktikum_Modul_10_Kevin.pdf) | Project dan laporan diunggah |
| [Modul 11](Modul%2011/) | Manajemen State GetX | [tasbih_getx](Modul%2011/Project/tasbih_getx/) | [PDF](Modul%2011/Laporan_Praktikum_Modul_11_Kevin.pdf) | Project dan laporan diunggah |
| [UTS](UTS/) | Rasa — Penjelajah Resep | [Rasa](UTS/Project/Rasa/) | [PDF](UTS/Project/Rasa/docs/Laporan_Rasa.pdf) | Project dan laporan diunggah |

## Susunan repository

Setiap folder modul memuat laporan PDF dan folder `Project/`. Satu modul dapat memiliki beberapa project percobaan. README pada setiap project menjelaskan isi aplikasi, package dan aset, struktur kode, cara menjalankan, serta batasannya.

Laporan UTS tersedia di `UTS/Project/Rasa/docs/Laporan_Rasa.pdf`.

## Menjalankan project

Buka terminal pada folder project yang berisi `pubspec.yaml`, kemudian jalankan:

```bash
flutter pub get
flutter devices
flutter run -t lib/main.dart
```

Gunakan Flutter SDK yang memenuhi batas versi Dart di `pubspec.yaml` masing-masing project. Pilih perangkat sesuai folder platform yang tersedia. Project yang mengambil data atau gambar dari API memerlukan koneksi internet.

## Memperbarui hasil praktikum

Dari folder utama repository, jalankan:

```bash
git status
git add .
git commit -m "Perbarui hasil praktikum"
git push origin main
```

Folder build dan cache diabaikan melalui `.gitignore`. Status pada tabel menunjukkan keberadaan file yang diunggah, bukan hasil pengujian atau penilaian seluruh project.
