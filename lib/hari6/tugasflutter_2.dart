import 'package:flutter/material.dart';

class TugasFlutterdua extends StatelessWidget {
  const TugasFlutterdua({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Lengkap'),
        backgroundColor: const Color.fromARGB(255, 236, 143, 21),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          // Baris 1: Nama di tengah
          const SizedBox(height: 20),
          Center(
            child: Text(
              'Kresno Suci Arinugroho', 
            style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 196, 20, 79),
              ),
            ),
          ),

          // Baris 2: Email dengan icon
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              padding: const EdgeInsets.all(12),
              color: const Color.fromARGB(255, 236, 206, 206),
              child: Row(
                children: const [
                  Icon(Icons.email, color: Colors.redAccent),
                  SizedBox(width: 10),
                  Text(
                    'kresnosucia@email.com', 
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),

          // Baris 3: Nomor telepon dengan Spacer
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: const [
                Icon(Icons.phone, color: Colors.green),
                SizedBox(width: 10),
                Text(
                  '0811-994-0198',
                  style: TextStyle(fontSize: 16),
                ),
                Spacer(),
                Icon(Icons.check_circle, color: Colors.blue),
              ],
            ),
          ),

          // Baris 4: Kotak Postingan & Followers
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.orange[100],
                    child: const Center(
                      child: Text(
                        'Postingan',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    color: Colors.lightBlue[100],
                    child: const Center(
                      child: Text(
                        'Followers',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Baris 5: Deskripsi Profil
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Freelance Digital Strategist | AI & Mobile Dev Enthusiast | Building Purpose-Driven Tech Solutions',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
          ),

          // Baris 6: Hiasan visual di bawah
          const SizedBox(height: 30),
          Container(
            height: 15,
            color: const Color.fromARGB(255, 236, 143, 21),
          ),

          const SizedBox(height: 10),
          Container(
            height: 15,
            color: const Color.fromARGB(255, 236, 143, 21),
          ),
        ],
      ),
    );
  }
}
