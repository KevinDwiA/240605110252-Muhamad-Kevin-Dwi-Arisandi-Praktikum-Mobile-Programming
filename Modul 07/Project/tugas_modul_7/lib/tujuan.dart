import 'package:flutter/material.dart';

class TujuanPage extends StatelessWidget {
  const TujuanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange, // Mengubah background Halaman Tujuan jadi oranye
      appBar: AppBar(
        title: const Text("Ini Halaman Tujuan", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepOrange,
        elevation: 0,
        automaticallyImplyLeading: false, // Menghilangkan tombol back (panah) bawaan di pojok kiri atas
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Untuk berpindah ke halaman baru, gunakan metode Navigator.push(). Metode push() akan menambahkan Route ke dalam tumpukan Route yang dikelola oleh Navigator. Route ini dapat dibuat secara kustom atau menggunakan MaterialPageRoute, yang memiliki animasi transisi sesuai dengan platform yang digunakan.',
              style: TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            // Menggunakan Icon pulau/pohon dalam kotak putih
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: const Icon(Icons.landscape, size: 80, color: Colors.green),
            ),
            const SizedBox(height: 30),
            const Text(
              'Untuk menutup halaman kedua dan kembali ke halaman pertama, gunakan metode Navigator.pop(). Metode pop() akan menghapus Route saat ini dari tumpukan Route yang dikelola oleh Navigator.',
              style: TextStyle(color: Colors.white, fontSize: 14),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Tombol warna biru
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                // Perintah untuk kembali ke halaman sebelumnya
                Navigator.pop(context);
              },
              child: const Text("< Kembali ke home"),
            )
          ],
        ),
      ),
    );
  }
}