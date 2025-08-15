// import 'package:flutter/material.dart';
// import 'package:flutter_application_1/hal_belajar_scflite_cr/model/user.dart';

// class Hal6UserScreen extends StatefulWidget {
//   const Hal6UserScreen({super.key});

//   @override
//   State<Hal6UserScreen> createState() => _Hal6UserScreenState();
// }

// class _Hal6UserScreenState extends State<Hal6UserScreen> {
//   List<User> users = [];
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController temaController = TextEditingController();
//   final TextEditingController kotaController = TextEditingController();

//   Future<void> getUser() async {
//     final dataUser = await DbHelper.getAllUsers();
//     setState(() {
//       users = dataUser;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             TextFormConst(hintText: "Nama", controller: nameController),
//             TextFormConst(hintText: "Email", controller: emailController),
//             TextFormConst(hintText: "Tema", controller: temaController),
//             TextFormConst(hintText: "Kota", controller: kotaController),
//             ElevatedButton(
//               onPressed: () async {
//                 final email = emailController.text.trim();
//                 final tema = temaController.text.trim();
//                 final name = nameController.text.trim();
//                 final kota = kotaController.text.trim();
//                 if (email.isEmpty ||
//                     tema.isEmpty ||
//                     name.isEmpty ||
//                     kota.isEmpty) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text(
//                         "Email, Tema, Nama, dan Kota tidak boleh kosong",
//                       ),
//                     ),
//                   );

//                   return;
//                 }
//                 final user =
//                     User(email: email, tema: tema, name: name, kota: kota);
//                 await DbHelper.registerUser(user);
//                 getUser();
//                 await Future.delayed(const Duration(seconds: 3));
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text("Pendaftaran berhasil")),
//                 );
//               },
//               child: Text("Simpan Data"),
//             ),
//             ListView.builder(
//               physics: const NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: users.length,
//               itemBuilder: (BuildContext context, int index) {
//                 final dataUserLogin = users[index];
//                 return ListTile(
//                   title: Text(dataUserLogin.name),
//                   subtitle: Text(dataUserLogin.email),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class TextFormConst extends StatelessWidget {
//   final String hintText;
//   final TextEditingController controller;

//   const TextFormConst({
//     super.key,
//     required this.hintText,
//     required this.controller,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       decoration: InputDecoration(
//         hintText: hintText,
//         border: const OutlineInputBorder(),
//       ),
//     );
//   }
// }

// class DbHelper {
//   static Future<List<User>> getAllUsers() async {
//     // todo: implementasi database disini
//     return <User>[];
//   }

//   static Future<void> registerUser(User user) async {
//     // todo: implementasi database disini
//   }
// }
