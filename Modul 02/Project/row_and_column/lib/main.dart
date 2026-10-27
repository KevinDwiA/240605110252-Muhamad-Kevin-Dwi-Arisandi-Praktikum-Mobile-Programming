import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Row and Column',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Row and Column'),
        ),
        // Langkah 4 & 5 serta Tugas Praktikum digabung di sini
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Pusatkan secara vertikal
            children: [
              // Baris Pertama (Row 1)
              Row(
                mainAxisAlignment: MainAxisAlignment.center, // Pusatkan secara horizontal
                children: [
                  KotakKustom(
                    warnaKotak: Colors.blue,
                    teks: 'Satu',
                  ),
                  const SizedBox(width: 20), // Jarak horizontal
                  KotakKustom(
                    warnaKotak: Colors.green,
                    teks: 'Dua',
                  ),
                ],
              ),
              const SizedBox(height: 20), // Jarak vertikal antar baris
              // Baris Kedua (Row 2)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  KotakKustom(
                    warnaKotak: Colors.orange,
                    teks: 'Tiga',
                  ),
                  const SizedBox(width: 20), // Jarak horizontal
                  KotakKustom(
                    warnaKotak: Colors.purple,
                    teks: 'Empat',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget Kustom yang dimodifikasi untuk memenuhi Tugas Praktikum
class KotakKustom extends StatelessWidget {
  // Variabel untuk menerima warna dan teks yang berbeda
  final Color warnaKotak;
  final String teks;

  const KotakKustom({
    super.key,
    required this.warnaKotak,
    required this.teks,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: warnaKotak, // Menggunakan warna yang dikirim
        border: Border.all(color: Colors.black, width: 2),
        borderRadius: BorderRadius.circular(12),
      ),
      // Menggunakan Column di dalam kotak untuk menyusun Ikon dan Teks
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Pusatkan isi kotak
        children: [
          const Icon(
            Icons.favorite, // Ikon diubah menjadi favorite
            color: Colors.red, // Ikon warna merah
            size: 40,
          ),
          const SizedBox(height: 8), // Jarak antara ikon dan teks
          Text(
            teks, // Teks yang dikirim
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}