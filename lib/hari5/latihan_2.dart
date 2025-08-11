import 'package:flutter/material.dart';

// 👇 INI WIDGET YANG BISA BERUBAH
class HalamanUtama extends StatefulWidget {
  const HalamanUtama({super.key});

  @override
  State<HalamanUtama> createState() => _HalamanUtamaState();
}

class _HalamanUtamaState extends State<HalamanUtama> {
  int angka = 0;

  void tambahAngka() {
    setState(() {
      angka++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gabungan Stateful & Stateless'),
        backgroundColor: Colors.teal,
      ),
      body: Center( // Tambahkan agar konten ditengah layar
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const InfoStatik(), // ✅ Ini stateless widget

            const SizedBox(height: 20),

            Text(
              'Angka sekarang: $angka',
              style: const TextStyle(fontSize: 28),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: tambahAngka,
        child: const Icon(Icons.add),
      ),
    );
  }
}

// ✅ INI STATIS — TANPA Scaffold
class InfoStatik extends StatelessWidget {
  const InfoStatik({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text(
          'Ini adalah info statis',
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 10),
        Text(
          'string yang ini tidak berubah',
          style: TextStyle(fontSize: 24),
        ),
      ],
    );
  }
}
