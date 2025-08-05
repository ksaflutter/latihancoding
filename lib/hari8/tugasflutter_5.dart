import 'package:flutter/material.dart';

class TugasFlutterLima extends StatefulWidget {
  const TugasFlutterLima({super.key});

  @override
  State<TugasFlutterLima> createState() => _TugasFlutterLimaState();
}

class _TugasFlutterLimaState extends State<TugasFlutterLima> {
  // Variabel state
  String namaSaya = '';
  bool isLiked = false; 
  bool showDeskripsi = false; // kenapa false? karena namanya masih mau di sembunyikan, setelah di klik baru ditampilkan
  int counter = 0;
  bool showInkWellText = false;
  String gestureMessage = ''; // <- tambahan untuk GestureDetector , agar tidak hanya tampil di terminal saja

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Halaman Interaktif Pengguna"),
        foregroundColor: Colors.white,
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // 1. ElevatedButton: Tampilkan Nama
            ElevatedButton(
              onPressed: () {
                setState(() {
                  namaSaya = "Nama saya: Kresno Suci Arinugroho";
                });
              },
              child: const Text("Hayo nama saya siapa?"),
            ),
            const SizedBox(height: 10),
            Text(namaSaya, style: const TextStyle(fontSize: 16)),

            const Divider(
              color: Color.fromARGB(255, 108, 106, 106),
              thickness: 3,
              height: 30,
            ),

            // 2. IconButton: Favorite
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.favorite,
                    color: isLiked ? Colors.red : Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                  },
                ),
                Text(isLiked ? "I love you" : "I no longer love you"),
              ],
            ),

            const Divider(
              color: Color.fromARGB(255, 108, 106, 106),
              thickness: 3,
              height: 30,
            ),

            // 3. TextButton: Lihat Selengkapnya
            TextButton(
              onPressed: () {
                setState(() {
                  showDeskripsi = !showDeskripsi;
                });
              },
              child: const Text("Klik disini untuk lihat selengkapnya"),
            ),
            if (showDeskripsi)
              const Text(
                "Ini adalah deskripsi tambahan tentang pengguna. Informasi ini muncul ketika tombol ditekan.",
              ),

            const Divider(
              color: Color.fromARGB(255, 108, 106, 106),
              thickness: 3,
              height: 30,
            ),

            // 4. InkWell: Area visual
            InkWell(
              onTap: () {
                debugPrint("Kotak disentuh");
                setState(() {
                  showInkWellText = !showInkWellText;
                });
              },
              child: Container(
                height: 80,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 248, 164, 37),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: Text(
                    "Kotak ini disentuh donk",
                    style: TextStyle(fontWeight: FontWeight.bold,color: Color.fromARGB(255, 253, 253, 253)), // gantiin warnanya 
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            if (showInkWellText) const Text("Yeay Kotak sudah disentuh!"),

            const Divider(
              color: Color.fromARGB(255, 108, 106, 106),
              thickness: 3,
              height: 30,
            ),

            // 5. GestureDetector: Teks interaktif
            GestureDetector(
              onTap: () {
                debugPrint("Kok hanya DITEKAN sekali");
                setState(() {
                  gestureMessage = "Kok hanya DITEKAN sekali";
                });
              },
              onDoubleTap: () {
                debugPrint("Ditekan dua kali ya");
                setState(() {
                  gestureMessage = "Ditekan dua kali ya";
                });
              },
              onLongPress: () {
                debugPrint("Tahan yang lama");
                setState(() {
                  gestureMessage = "Tahan yang lama";
                });
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Tekan Aku Sekarang!",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromARGB(255, 241, 48, 22),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    gestureMessage,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),

      // 6. FloatingActionButton
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            counter++;
          });
        },
        backgroundColor: const Color.fromARGB(255, 100, 170, 228),
        child: const Icon(Icons.add),
      ),

      // Counter ditampilkan di bagian bawah
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text("Counter: $counter", style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}
