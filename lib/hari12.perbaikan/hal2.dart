import 'package:flutter/material.dart';

import 'hal3.dart';

class TugasTujuh extends StatelessWidget {
  final String nama;
  const TugasTujuh({super.key, required this.nama});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Halaman Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.info),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => TugasDelapan(nama: nama)),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text(
          "Halo $nama, selamat datang di Home 🎉",
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
