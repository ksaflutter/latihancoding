import 'package:flutter/material.dart';

class Latihanhari81 extends StatelessWidget {
  const Latihanhari81({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Body Playground',
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Eksplorasi Body Widget"),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            const Text("Ini adalah Text biasa", style: TextStyle(fontSize: 20)),
            const SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {},
              child: const Text("Tombol Tekan Saya"),
            ),
            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: const [
                Icon(Icons.star, color: Colors.orange),
                Icon(Icons.favorite, color: Colors.pink),
                Icon(Icons.thumb_up, color: Colors.blue),
              ],
            ),
            const SizedBox(height: 16),

            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Text(
                  "Ini Container",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
            const SizedBox(height: 16),

            InkWell(
              onTap: () => debugPrint("Container disentuh"),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Klik Aku!",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),

            const SizedBox(height: 16),

            GestureDetector(
              onLongPress: () => debugPrint("Long Press dilakukan"),
              child: const Text(
                "Tahan lama teks ini",
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
