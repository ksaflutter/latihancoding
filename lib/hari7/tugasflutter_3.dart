import 'package:flutter/material.dart';

class TugasFluttertiga extends StatelessWidget {
  const TugasFluttertiga({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Formulir & Galeri"),
        backgroundColor: Colors.deepOrange,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // === FORMULIR PENGGUNA ===
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  // TextField: Nama
                  const TextField(
                    decoration: InputDecoration(
                      labelText: "Nama",
                      border: OutlineInputBorder(),
                       focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 4.0),
                      ),
                      hintText: "Masukkan Nama Anda",
                    ),
                  ),
                  const SizedBox(height: 12),

                  // TextField: Email
                  const TextField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                       focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 4.0),
                      ),
                      hintText: "Masukkan Email Anda",
                    ),
                  ),
                  const SizedBox(height: 12),

                  // TextField: No HP
                  const TextField(
                    decoration: InputDecoration(
                      labelText: "No. HP",
                      border: OutlineInputBorder(),
                       focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 4.0),
                      ),
                      hintText: "Masukkan No. HP Anda",
                    ),
                  ),
                  const SizedBox(height: 12),

                  // TextField: Deskripsi
                  const TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      labelText: "Deskripsi",
                      border: OutlineInputBorder(),
                       focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red, width: 4.0),
                      ),
                      hintText: "Ceritakan siapa Anda",
                      
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // === GALERI GRIDVIEW ===
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: List.generate(6, (index) {
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors
                              .primaries[index % Colors.primaries.length][200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      Center(
                        child: Text(
                          'Button ${index + 1}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}