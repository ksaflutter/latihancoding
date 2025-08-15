import 'package:flutter/material.dart';

import 'model/produk_model.dart';

class HalList9 extends StatefulWidget {
  final String showListType; // basic, map, model

  const HalList9({super.key, required this.showListType});

  @override
  State<HalList9> createState() => _HalList9State();
}

class _HalList9State extends State<HalList9> {
  final List<String> alatOlahraga = [
    'Treadmill',
    'Dumbbell',
    'Sepeda statis',
    'Resistance band',
    'Pull-up bar',
    'Matras yoga',
    'Foam roller',
    'Tali skipping',
    'Kettlebell',
    'Balance ball',
  ];

  final List<Map<String, dynamic>> daftarAlatOlahraga = [
    {
      'nama': 'Treadmill',
      'icon': Icons.directions_run,
      'deskripsi':
          'Alat olahraga berupa mesin yang digunakan untuk berlari dan berjalan',
      'warna': Colors.red,
    },
    {
      'nama': 'Dumbbell',
      'icon': Icons.fitness_center,
      'deskripsi':
          'Alat olahraga berupa beban yang digunakan untuk melatih otot',
      'warna': Colors.blue,
    },
    {
      'nama': 'Sepeda statis',
      'icon': Icons.pedal_bike,
      'deskripsi':
          'Alat olahraga berupa sepeda yang digunakan untuk bersepeda tanpa bergerak',
      'warna': Colors.green,
    },
    {
      'nama': 'Resistance band',
      'icon': Icons.sports_handball,
      'deskripsi':
          'Alat olahraga berupa band yang digunakan untuk melatih otot',
      'warna': Colors.yellow,
    },
    {
      'nama': 'Pull-up bar',
      'icon': Icons.bolt,
      'deskripsi':
          'Alat olahraga berupa palang yang digunakan untuk melatih otot',
      'warna': Colors.orange,
    },
    {
      'nama': 'Matras yoga',
      'icon': Icons.self_improvement,
      'deskripsi':
          'Alat olahraga berupa matras yang digunakan untuk berlatih yoga',
      'warna': Colors.purple,
    },
    {
      'nama': 'Foam roller',
      'icon': Icons.spa,
      'deskripsi':
          'Alat olahraga berupa roller yang digunakan untuk melatih otot',
      'warna': Colors.brown,
    },
    {
      'nama': 'Tali skipping',
      'icon': Icons.sports_kabaddi,
      'deskripsi':
          'Alat olahraga berupa tali yang digunakan untuk melatih kecepatan',
      'warna': Colors.grey,
    },
    {
      'nama': 'Kettlebell',
      'icon': Icons.sports_gymnastics,
      'deskripsi':
          'Alat olahraga berupa beban yang digunakan untuk melatih otot',
      'warna': Colors.blue,
    },
    {
      'nama': 'Balance ball',
      'icon': Icons.sports,
      'deskripsi':
          'Alat olahraga berupa bola yang digunakan untuk melatih keseimbangan',
      'warna': Colors.green,
    },
  ];

  final List<ProdukModel> daftarProduk = [
    ProdukModel(
      nama: 'Treadmill',
      icon: Icons.directions_run,
      deskripsi:
          'Alat olahraga berupa mesin yang digunakan untuk berlari dan berjalan',
      warna: Colors.red,
    ),
    ProdukModel(
      nama: 'Dumbbell',
      icon: Icons.fitness_center,
      deskripsi: 'Alat olahraga berupa beban yang digunakan untuk melatih otot',
      warna: Colors.blue,
    ),
    ProdukModel(
      nama: 'Sepeda statis',
      icon: Icons.pedal_bike,
      deskripsi:
          'Alat olahraga berupa sepeda yang digunakan untuk bersepeda tanpa bergerak',
      warna: Colors.green,
    ),
    ProdukModel(
      nama: 'Resistance band',
      icon: Icons.sports_handball,
      deskripsi: 'Alat olahraga berupa band yang digunakan untuk melatih otot',
      warna: Colors.yellow,
    ),
    ProdukModel(
      nama: 'Pull-up bar',
      icon: Icons.bolt,
      deskripsi:
          'Alat olahraga berupa palang yang digunakan untuk melatih otot',
      warna: Colors.orange,
    ),
    ProdukModel(
      nama: 'Matras yoga',
      icon: Icons.self_improvement,
      deskripsi:
          'Alat olahraga berupa matras yang digunakan untuk berlatih yoga',
      warna: Colors.purple,
    ),
    ProdukModel(
      nama: 'Foam roller',
      icon: Icons.spa,
      deskripsi:
          'Alat olahraga berupa roller yang digunakan untuk melatih otot',
      warna: Colors.brown,
    ),
    ProdukModel(
      nama: 'Tali skipping',
      icon: Icons.sports_kabaddi,
      deskripsi:
          'Alat olahraga berupa tali yang digunakan untuk melatih kecepatan',
      warna: Colors.grey,
    ),
    ProdukModel(
      nama: 'Kettlebell',
      icon: Icons.sports_gymnastics,
      deskripsi: 'Alat olahraga berupa beban yang digunakan untuk melatih otot',
      warna: Colors.blue,
    ),
    ProdukModel(
      nama: 'Balance ball',
      icon: Icons.sports,
      deskripsi:
          'Alat olahraga berupa bola yang digunakan untuk melatih keseimbangan',
      warna: Colors.green,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    switch (widget.showListType) {
      case 'basic':
        return ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: alatOlahraga.length,
          itemBuilder: (BuildContext context, int index) {
            final item = alatOlahraga[index];
            return ListTile(title: Text(item));
          },
        );

      case 'map':
        return ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: daftarAlatOlahraga.length,
          itemBuilder: (BuildContext context, int index) {
            final item = daftarAlatOlahraga[index];
            return ListTile(
              leading: Icon(item['icon'] as IconData? ?? Icons.error),
              title: Text(item['nama'] as String? ?? 'No Name'),
              subtitle: Text(item['deskripsi'] as String? ?? 'No Description'),
              trailing: CircleAvatar(
                backgroundColor: item['warna'] as Color? ?? Colors.grey,
              ),
            );
          },
        );

      case 'model':
        return ListView.builder(
          shrinkWrap: true,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: daftarProduk.length,
          itemBuilder: (BuildContext context, int index) {
            final produk = daftarProduk[index];
            return ListTile(
              leading: Icon(produk.icon),
              title: Text(produk.nama),
              subtitle: Text(produk.deskripsi),
              trailing: CircleAvatar(backgroundColor: produk.warna),
            );
          },
        );

      default:
        return const Center(child: Text('Pilih tipe list dari menu drawer'));
    }
  }
}
