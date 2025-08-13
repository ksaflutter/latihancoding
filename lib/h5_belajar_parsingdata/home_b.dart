import 'package:flutter/material.dart';

class HomeBe extends StatelessWidget {
  final String name;
  final String kota;

  const HomeBe({
    super.key,
    required this.name,
    required this.kota,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Konfirmasi Pendaftaran")),
      body: Center(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color.fromARGB(
                255, 7, 31, 139), // warna background container
            borderRadius: BorderRadius.circular(12), // sudut melengkung
          ),
          child: Text(
            "Terima kasih, $name dari $kota telah mendaftar.",
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white, // teks putih
            ),
          ),
        ),
      ),
    );
  }
}
