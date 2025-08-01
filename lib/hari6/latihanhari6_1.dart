import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

class TugasDua extends StatelessWidget {
  const TugasDua({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Lengkap'),
        backgroundColor: const Color.fromARGB(255, 21, 152, 156),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // const Text(
            //   'Kresno Suci Arinugroho',
            //   style: GoogleFonts.new(
            //     fontSize: 28,
            //     fontWeight: FontWeight.bold,
            //   ),
            // ),
            const SizedBox(height: 10),
            Row(
              children: const [
                Icon(
                  Icons.email_outlined,
                  color: Colors.redAccent,
                ),
                SizedBox(width: 5),
                Text(
                  'kresnosucia@gmail.com',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
              const SizedBox(height: 10),
            Row(
            children: const [
                Icon(
                  Icons.phone_outlined,
                  color: Colors.redAccent,
                ),
                SizedBox(width: 5),
                Text(
                  '0811-994-0198',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              ' untuk membantu orang banyak.',
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
