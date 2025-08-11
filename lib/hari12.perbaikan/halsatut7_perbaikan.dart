import 'package:flutter/material.dart';

class HalamanSatu extends StatefulWidget {
  final String nama;

  const HalamanSatu({super.key, required this.nama});

  @override
  State<HalamanSatu> createState() => _HalamanSatuState();
}

class _HalamanSatuState extends State<HalamanSatu> {
  String selectedMenu = 'Checkbox';
  bool agreeTerms = false;
  bool darkMode = false;
  String? selectedCategory;
  DateTime? birthDate;
  TimeOfDay? reminderTime;

  // Untuk cek semua drawer sudah terisi
  bool get semuaTerisi =>
      agreeTerms &&
      darkMode &&
      selectedCategory != null &&
      birthDate != null &&
      reminderTime != null;

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.indigo,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _checkAllFilled() {
    if (semuaTerisi) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: GestureDetector(
            onTap: () {
              // aksi kalau klik promo
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("🎉 Promo surprise akan segera dikirim!"),
                  backgroundColor: Colors.green,
                ),
              );
            },
            child: const Text(
              "🎁 Selamat, kamu sudah mengisi semua! Mau mendapatkan promo kejutan? Klik di sini…",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.deepPurple,
          duration: const Duration(seconds: 4),
        ),
      );
    }
  }

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
        child: Column(
          children: [
            // Teks selamat datang
            Text(
              "Selamat datang ${widget.nama} di halaman ini",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: darkMode ? Colors.white : Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              "Silakan lengkapi semua menu yang ada di drawer sebelah kiri.",
              style: TextStyle(
                fontSize: 14,
                color: darkMode ? Colors.white70 : Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            Expanded(child: _buildBody()),
          ],
        ),
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
                    _showSnackBar(
                      agreeTerms
                          ? "✅ Anda setuju dengan syarat dan ketentuan"
                          : "❌ Anda belum menyetujui syarat dan ketentuan",
                    );
                    _checkAllFilled();
                  },
                ),
                const Expanded(
                  child: Text("Saya setuju dengan syarat dan ketentuan"),
                ),
              ],
            ),
          ],
        );

      case "Switch":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: const Text("Aktifkan Mode Gelap"),
              value: darkMode,
              onChanged: (value) {
                setState(() {
                  darkMode = value;
                });
                _showSnackBar(
                  darkMode ? "🌙 Mode Gelap Aktif" : "☀️ Mode Terang Aktif",
                );
                _checkAllFilled();
              },
            ),
          ],
        );

      case "Dropdown":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                _showSnackBar("📦 Kamu sudah memilih $value");
                _checkAllFilled();
              },
            ),
          ],
        );

      case "Tanggal":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  _showSnackBar(
                    "📅 Tanggal lahir dipilih: ${birthDate!.day}/${birthDate!.month}/${birthDate!.year}",
                  );
                  _checkAllFilled();
                }
              },
              child: const Text("Pilih Tanggal Lahir"),
            ),
          ],
        );

      case "Jam":
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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
                  _showSnackBar(
                    "⏰ Waktu pengingat diatur: ${reminderTime!.format(context)}",
                  );
                  _checkAllFilled();
                }
              },
              child: const Text("Pilih Waktu Pengingat"),
            ),
          ],
        );

      default:
        return const Text("Pilih menu dari drawer");
    }
  }
}
