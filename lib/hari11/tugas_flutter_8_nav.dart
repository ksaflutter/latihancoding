import 'package:flutter/material.dart';
import 'package:ppkd_b_3/hari11/tugasflutter_7.dart';

class TugasFlutter8Nav extends StatefulWidget {
  const TugasFlutter8Nav({super.key});

  @override
  State<TugasFlutter8Nav> createState() => _TugasFlutter8NavState();
}

class _TugasFlutter8NavState extends State<TugasFlutter8Nav> {
  int _selectedIndex = 0;

  // 🔹 Daftar halaman
  static final List<Widget> _widgetOptions = <Widget>[
    const TugasTujuh(), // Halaman Tugas 7 (Home + Drawer)
    const TentangAplikasiPage(), // Halaman Tentang
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 🔹 Body hanya halaman yang dipilih
      body: _widgetOptions[_selectedIndex],

      // 🔹 Navigasi bawah
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "Tentang"),
        ],
      ),
    );
  }
}

// 🔹 Halaman Tentang Aplikasi
class TentangAplikasiPage extends StatelessWidget {
  const TentangAplikasiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tentang Aplikasi")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Judul: Aplikasi Form & Navigasi",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(
              "Deskripsi: Aplikasi ini memiliki form input lengkap "
              "dengan navigasi drawer pada halaman Home dan navigasi bawah "
              "menggunakan BottomNavigationBar.",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 12),
            Text("Pembuat: Nama Kamu", style: TextStyle(fontSize: 16)),
            SizedBox(height: 4),
            Text("Versi: 1.0.0", style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
