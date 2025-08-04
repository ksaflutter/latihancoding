import 'package:flutter/material.dart';

class TugasFlutterempat extends StatelessWidget {
  const TugasFlutterempat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulir & Daftar Produk"),
        backgroundColor: Colors.teal,
      ),

      // ✅ Langsung pakai ListView sebagai root (tanpa Column)
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          // === FORMULIR PENGGUNA ===
          const TextField(
            decoration: InputDecoration(
              labelText: "Nama",
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 56, 87, 112), width: 4.0),
              ),

              hintText: "Masukkan Nama Anda",
            ),
          ),
          const SizedBox(height: 12),

          const TextField(
            decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 56, 87, 112), width: 4.0),
              ),

              hintText: "Masukkan Email Anda",
            ),
          ),
          const SizedBox(height: 12),

          const TextField(
            decoration: InputDecoration(
              labelText: "No. HP",
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 56, 87, 112), width: 4.0),
              ),

              hintText: "Masukkan No. HP Anda",
            ),
          ),
          const SizedBox(height: 12),

          const TextField(
            maxLines: 3,
            decoration: InputDecoration(
              labelText: "Deskripsi tentang anda ",
              border: OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 56, 87, 112), width: 4.0),
              ),

              hintText: "Ceritakan tentang Anda",
            ),
          ),
          const SizedBox(height: 24),

          const Divider(
            color: Color.fromARGB(255, 56, 87, 112),
            thickness: 2,
          ),

          // === DAFTAR PRODUK ===
          const Text(
            "Daftar Produk",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

          // Produk 1
          ListTile(
            leading: const Icon(Icons.phone_android, color: Colors.blue),
            title: const Text("Smartphone"),
            subtitle: const Text("Rp 2.500.000"),
          ),

          // Produk 2
          ListTile(
            leading: const Icon(Icons.laptop_mac, color: Colors.teal),
            title: const Text("Laptop"),
            subtitle: const Text("Rp 7.800.000"),
          ),

          // Produk 3
          ListTile(
            leading: const Icon(Icons.watch, color: Colors.orange),
            title: const Text("Smartwatch"),
            subtitle: const Text("Rp 1.200.000"),
          ),

          // Produk 4
          ListTile(
            leading: const Icon(Icons.headphones, color: Colors.red),
            title: const Text("Headset"),
            subtitle: const Text("Rp 350.000"),
          ),

          // Produk 5
          ListTile(
            leading: const Icon(Icons.tv, color: Colors.deepPurple),
            title: const Text("Smart TV"),
            subtitle: const Text("Rp 5.000.000"),
          ),

          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
