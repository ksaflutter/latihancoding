import 'package:flutter/material.dart';
import 'package:flutter_application_1/tugas_14/models/user_model.dart';

class UserDetailPage extends StatelessWidget {
  final Welcome user;

  const UserDetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(user.name ?? "Detail User")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 104, 105, 105),
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16), // jarak dari border atas
              Center(
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(8.0), // biar foto ikut border
                  child: user.image == ""
                      ? const SizedBox(
                          width: 100,
                          height: 150,
                          child: Placeholder(),
                        )
                      : Image.network(
                          user.image ?? "",
                          width: 140,
                          height: 200,
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                          // ada shadownya

                          // biar rapi di dalam kotak
                        ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nama: ${user.name ?? ""}",
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 243, 47, 33))),
                    Text("Alias: ${user.alternateNames.join(", ")}"),
                    Text("Gender: ${user.gender ?? ""}"),
                    Text("Species: ${user.species ?? ""}"),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
