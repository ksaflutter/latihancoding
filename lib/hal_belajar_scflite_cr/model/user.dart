// import 'dart:convert';

// import 'package:flutter/material.dart';

// class Hal6UserScreen extends StatefulWidget {
//   const Hal6UserScreen({super.key});

//   @override
//   State<Hal6UserScreen> createState() => _Hal6UserScreenState();
// }

// class _Hal6UserScreenState extends State<Hal6UserScreen> {
//   @override
//   Widget build(BuildContext context) => throw UnimplementedError();
// }

// class User {
//   final String name;
//   final String email;
//   final String tema;
//   final String kota;
//   User(
//       {required this.name,
//       required this.email,
//       required this.tema,
//       required this.kota});

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       'email': email,
//       'name': name,
//       'tema': tema,
//       'kota': kota,
//     };
//   }

//   factory User.fromMap(Map<String, dynamic> map) {
//     return User(
//       email: map['email'] as String,
//       tema: map['tema'] as String,
//       name: map['name'] as String,
//       kota: map['kota'] as String,
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory User.fromJson(String source) =>
//       User.fromMap(json.decode(source) as Map<String, dynamic>);
// }
