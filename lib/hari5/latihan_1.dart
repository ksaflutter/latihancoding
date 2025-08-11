import 'package:flutter/material.dart';

class LatihanProfile extends StatelessWidget {
  const LatihanProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi untuk ANDA'),
        backgroundColor: const Color.fromARGB(255, 165, 190, 231),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Selamat Datang di Apps kami',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Icon(
                  Icons.location_on,
                  color: Colors.redAccent,
                ),
                SizedBox(width: 5),
                Text(
                  'Jakarta',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              'Jangan lupa Sholat dan istigfar setiap hari',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            const Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'Bersedekah selagi masih ',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black87,
                    ),
                  ),
                  TextSpan(
                    text: 'mampu',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.red,
                            
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

