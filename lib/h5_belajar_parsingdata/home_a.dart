import 'package:flutter/material.dart';
import 'package:flutter_application_1/h5_belajar_parsingdata/home_b.dart';
import 'package:flutter_application_1/h5_belajar_parsingdata/textform.dart';

class ParsingDataSatu extends StatefulWidget {
  const ParsingDataSatu({super.key});

  @override
  State<ParsingDataSatu> createState() => _ParsingDataSatuState();
}

class _ParsingDataSatuState extends State<ParsingDataSatu> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController domisiliController = TextEditingController();

  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nama   : ${nameController.text}"),
            Text("Email  : ${emailController.text}"),
            Text(
                "No HP  : ${phoneController.text.isEmpty ? 'Tidak ada' : phoneController.text}"),
            Text("Kota   : ${domisiliController.text}"),
            const SizedBox(height: 10),
            const Text("Apakah data Anda sudah benar?"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // No
            child: const Text("No"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Tutup dialog
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HomeBe(
                    name: nameController.text,
                    kota: domisiliController.text,
                  ),
                ),
              );
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Formulir Pendaftaran")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextForm(
                hintText: "Masukkan Nama Lengkap",
                controller: nameController,
                validator: (value) =>
                    value == null || value.isEmpty ? "Nama wajib diisi" : null,
              ),
              const SizedBox(height: 12),
              TextForm(
                hintText: "Masukkan Email",
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Email wajib diisi";
                  } else if (!value.contains("@")) {
                    return "Email tidak valid";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextForm(
                hintText: "Masukkan Nomor HP (opsional)",
                controller: phoneController,
                validator: (value) => null, // Boleh kosong
              ),
              const SizedBox(height: 12),
              TextForm(
                hintText: "Masukkan Kota Domisili",
                controller: domisiliController,
                validator: (value) =>
                    value == null || value.isEmpty ? "Kota wajib diisi" : null,
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 9, 168, 155),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _showConfirmationDialog();
                    }
                  },
                  child: const Text(
                    "Daftar",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
