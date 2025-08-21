// import 'package:flutter/material.dart';
// //import 'package:ppkd_b_3/hari11/tugasflutter_7.dart';

// class TugasFlutter8 extends StatefulWidget {
//   const TugasFlutter8({super.key});

//   @override
//   State<TugasFlutter8> createState() => _TugasFlutter8State();
// }

// class _TugasFlutter8State extends State<TugasFlutter8> {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           title: const Text("Login Berhasil"),
//           content: const Text("Selamat datang kembali!"),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.pop(context); // Tutup dialog
//                 Navigator.push(
//                   context,
//         //          MaterialPageRoute(builder: (_) => const TugasTujuh()),
//                 );
//               },
//               child: const Text("OK"),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24.0),
//           child: SingleChildScrollView(
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(height: 28),

//                   // 🔙 Back & Title
//                   Row(
//                     children: const [
//                       Icon(Icons.arrow_back_ios_new, size: 18),
//                       SizedBox(width: 8),
//                       Text(
//                         "Login",
//                         style: TextStyle(
//                           fontSize: 18,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 30),

//                   // 👋 Welcome
//                   const Text(
//                     "Welcome Back",
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     "Sign In to your account",
//                     style: TextStyle(fontSize: 14, color: Colors.grey),
//                   ),

//                   const SizedBox(height: 30),

//                   // 📧 Email Field
//                   const Text(
//                     "Email Address",
//                     style: TextStyle(fontWeight: FontWeight.w300),
//                   ),
//                   const SizedBox(height: 8),
//                   TextFormField(
//                     controller: _emailController,
//                     decoration: InputDecoration(
//                       hintText: "helloteja@gmail.com",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(32),
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 12,
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Email tidak boleh kosong";
//                       }
//                       if (!value.contains('@')) return "Email tidak valid";
//                       return null;
//                     },
//                   ),

//                   const SizedBox(height: 20),

//                   // 🔒 Password Field
//                   const Text(
//                     "Password",
//                     style: TextStyle(fontWeight: FontWeight.w300),
//                   ),
//                   const SizedBox(height: 8),
//                   TextFormField(
//                     controller: _passwordController,
//                     obscureText: true,
//                     decoration: InputDecoration(
//                       hintText: "••••••••",
//                       suffixIcon: const Icon(Icons.visibility_off),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(32),
//                       ),
//                       contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 12,
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return "Password tidak boleh kosong";
//                       }
//                       if (value.length < 6) return "Minimal 6 karakter";
//                       return null;
//                     },
//                   ),

//                   const SizedBox(height: 8),

//                   // 🔑 Forgot Password
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: TextButton(
//                       onPressed: () {},
//                       child: const Text(
//                         "Forgot Password?",
//                         style: TextStyle(
//                           color: Colors.orange,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 20),

//                   // 🔵 Login Button
//                   SizedBox(
//                     width: double.infinity,
//                     height: 48,
//                     child: ElevatedButton(
//                       onPressed: _submitForm,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.indigo,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(32),
//                         ),
//                       ),
//                       child: const Text(
//                         "Login",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 16),

//                   // 🆕 Sign Up Text
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text("Don’t have an account? "),
//                       GestureDetector(
//                         onTap: () {},
//                         child: const Text(
//                           "Sign Up",
//                           style: TextStyle(
//                             color: Colors.orange,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 24),

//                   // ➖ Divider
//                   Row(
//                     children: const [
//                       Expanded(child: Divider(thickness: 1)),
//                       SizedBox(width: 8),
//                       Text("Or Sign In With"),
//                       SizedBox(width: 8),
//                       Expanded(child: Divider(thickness: 1)),
//                     ],
//                   ),

//                   const SizedBox(height: 16),

//                   // 🌐 Google & Facebook
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       Expanded(
//                         child: OutlinedButton.icon(
//                           onPressed: () {},
//                           icon: Image.asset(
//                             "assets/images/icongoogle.png",
//                             width: 16,
//                             height: 16,
//                           ),
//                           label: const Text("Google"),
//                           style: OutlinedButton.styleFrom(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 30,
//                               vertical: 12,
//                             ),
//                             backgroundColor: const Color.fromARGB(
//                               248,
//                               238,
//                               237,
//                               237,
//                             ),
//                             side: const BorderSide(
//                               color: Color.fromARGB(248, 238, 237, 237),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 18),
//                       Expanded(
//                         child: OutlinedButton.icon(
//                           onPressed: () {},
//                           icon: Image.asset(
//                             "assets/images/iconfacebook.png",
//                             width: 16,
//                             height: 16,
//                           ),
//                           label: const Text("Facebook"),
//                           style: OutlinedButton.styleFrom(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: 30,
//                               vertical: 12,
//                             ),
//                             backgroundColor: const Color.fromARGB(
//                               248,
//                               238,
//                               237,
//                               237,
//                             ),
//                             side: const BorderSide(
//                               color: Color.fromARGB(248, 238, 237, 237),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 50),

//                   // 🧡 Join Us Text
//                   Padding(padding: const EdgeInsets.all(8.0)),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       const Text("Don’t have an account? "),
//                       GestureDetector(
//                         onTap: () {},
//                         child: const Text(
//                           "Join Us",
//                           style: TextStyle(
//                             color: Colors.orange,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
