import 'package:flutter/material.dart';

// ---------------------------
// Halaman Tugas 7 (tidak diubah)
// ---------------------------
class TugasTujuh extends StatefulWidget {
  const TugasTujuh({super.key});

  @override
  State<TugasTujuh> createState() => _TugasTujuhState();
}

class _TugasTujuhState extends State<TugasTujuh> {
  String selectedMenu = 'Checkbox';
  bool agreeTerms = false;
  bool darkMode = false;
  String? selectedCategory;
  DateTime? birthDate;
  TimeOfDay? reminderTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(selectedMenu)),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Center(
                child: Text(
                  "Menu Input",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            _drawerItem("Checkbox"),
            _drawerItem("Switch"),
            _drawerItem("Dropdown"),
            _drawerItem("Tanggal"),
            _drawerItem("Jam"),
          ],
        ),
      ),
      body: Container(
        color: darkMode ? Colors.grey[900] : Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: _buildBody(),
      ),
    );
  }

  ListTile _drawerItem(String title) {
    return ListTile(
      title: Text(title),
      onTap: () {
        setState(() {
          selectedMenu = title;
        });
        Navigator.pop(context);
      },
    );
  }

  Widget _buildBody() {
    switch (selectedMenu) {
      case "Checkbox":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Syarat dan Ketentuan",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Checkbox(
                  value: agreeTerms,
                  onChanged: (value) {
                    setState(() {
                      agreeTerms = value!;
                    });
                  },
                ),
                const Expanded(
                  child: Text("Anda setuju dengan syarat dan ketentuan"),
                ),
              ],
            ),
            Text(
              agreeTerms
                  ? "Lanjutkan pendafataran diperbolehkan"
                  : "Anda belum bisa melanjutkan",
              style: TextStyle(color: agreeTerms ? Colors.green : Colors.red),
            ),
          ],
        );

      case "Switch":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Mode Gelap",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              title: const Text("Aktifkan Mode Gelap"),
              value: darkMode,
              onChanged: (value) {
                setState(() {
                  darkMode = value;
                });
              },
            ),
            Text(
              darkMode
                  ? "Mode Gelap Aktif"
                  : "Mode habis gelap terbitlah terang",
              style: TextStyle(color: darkMode ? Colors.white : Colors.black),
            ),
          ],
        );

      case "Dropdown":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pilih Kategori Produk",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: selectedCategory,
              hint: const Text("Pilih kategori"),
              items: ["Elektronik", "Pakaian", "Makanan", "Lainnya"].map((
                item,
              ) {
                return DropdownMenuItem<String>(value: item, child: Text(item));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedCategory = value;
                });
              },
            ),
            if (selectedCategory != null)
              Text("Anda memilih kategori: $selectedCategory"),
          ],
        );

      case "Tanggal":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pilih Tanggal Lahir",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: birthDate ?? DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );
                if (picked != null) {
                  setState(() {
                    birthDate = picked;
                  });
                }
              },
              child: const Text("Pilih Tanggal Lahir"),
            ),
            if (birthDate != null)
              Text(
                "Tanggal Lahir: ${birthDate!.day} ${_monthName(birthDate!.month)} ${birthDate!.year}",
              ),
          ],
        );

      case "Jam":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Atur Pengingat",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () async {
                final picked = await showTimePicker(
                  context: context,
                  initialTime: reminderTime ?? TimeOfDay.now(),
                );
                if (picked != null) {
                  setState(() {
                    reminderTime = picked;
                  });
                }
              },
              child: const Text("Pilih Waktu Pengingat"),
            ),
            if (reminderTime != null)
              Text("Pengingat diatur pukul: ${reminderTime!.format(context)}"),
          ],
        );

      default:
        return const Text("Pilih menu dari drawer");
    }
  }

  String _monthName(int month) {
    const months = [
      "Januari",
      "Februari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember",
    ];
    return months[month - 1];
  }
}

// ---------------------------
// Halaman Tentang Aplikasi
// ---------------------------
class TentangAplikasi extends StatelessWidget {
  const TentangAplikasi({super.key});

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
              "Aplikasi Form & Navigasi",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Aplikasi ini dibuat untuk menampilkan contoh form input "
              "dengan berbagai jenis widget, dilengkapi dengan navigasi "
              "drawer dan bottom navigation bar.",
            ),
            SizedBox(height: 10),
            Text("Pembuat: Nama Kamu"),
            Text("Versi: 1.0.0"),
          ],
        ),
      ),
    );
  }
}

// ---------------------------
// Main dengan BottomNavigationBar
// ---------------------------
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [const TugasTujuh(), const TentangAplikasi()];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: _pages[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.info), label: 'Tentang'),
          ],
        ),
      ),
    );
  }
}
