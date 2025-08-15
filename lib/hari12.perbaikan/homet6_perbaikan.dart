// import 'package:flutter/material.dart';

// class HalamanHome extends StatefulWidget {
//   const HalamanHome({super.key});

//   @override
//   State<HalamanHome> createState() => _HalamanHomeState();
// }

// class _HalamanHomeState extends State<HalamanHome>
//     with SingleTickerProviderStateMixin {
//   final _formKey = GlobalKey<FormState>();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   late AnimationController _shakeController;
//   late Animation<double> _shakeAnimation;

//   bool _obscurePassword = true;

//   @override
//   void initState() {
//     super.initState();
//     _shakeController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 200),
//     );
//     _shakeAnimation = Tween<double>(
//       begin: 0,
//       end: 8,
//     ).chain(CurveTween(curve: Curves.elasticIn)).animate(_shakeController);
//   }

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     _shakeController.dispose();
//     super.dispose();
//   }

//   void _showConfirmationDialog() {
//     showGeneralDialog(
//       context: context,
//       barrierDismissible: false,
//       barrierLabel: "Konfirmasi",
//       transitionDuration: const Duration(milliseconds: 400),
//       pageBuilder: (context, anim1, anim2) {
//         return Center(
//           child: Material(
//             color: Colors.transparent,
//             child: AnimatedBuilder(
//               animation: _shakeAnimation,
//               builder: (context, child) {
//                 return Transform.translate(
//                   offset: Offset(_shakeAnimation.value, 0),
//                   child: Container(
//                     width: MediaQuery.of(context).size.width * 0.84,
//                     padding: const EdgeInsets.all(20),
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     child: Column(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         const Icon(
//                           Icons.check_circle,
//                           color: Colors.green,
//                           size: 64,
//                         ),
//                         const SizedBox(height: 12),
//                         Text(
//                           "Halo ${_emailController.text}",
//                           style: const TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         const Text(
//                           "Apakah kamu sudah mengisi data dengan benar?",
//                           textAlign: TextAlign.center,
//                         ),
//                         const SizedBox(height: 18),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             OutlinedButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               child: const Text("No"),
//                             ),
//                             ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.green,
//                               ),
//                               onPressed: () {
//                                 Navigator.pop(context);
//                                 Navigator.of(context).push(
//                                   _customPageRoute(
//                                     HalamanSatu(nama: _emailController.text),
//                                   ),
//                                 );
//                               },
//                               child: const Text("Yes"),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         );
//       },
//       transitionBuilder: (context, anim1, anim2, child) {
//         return FadeTransition(
//           opacity: anim1,
//           child: ScaleTransition(
//             scale: CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
//             child: child,
//           ),
//         );
//       },
//     );

//     // Jalanin animasi shake sekali (forward -> reverse)
//     _shakeController.forward().then((_) => _shakeController.reverse());
//   }

//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       _showConfirmationDialog();
//     } else {
//       // kalau mau memberikan feedback getar pada invalid form,
//       // bisa jalankan shake juga:
//       _shakeController.forward().then((_) => _shakeController.reverse());
//     }
//   }

//   Route _customPageRoute(Widget page) {
//     return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) => page,
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         const begin = Offset(1.0, 0.0);
//         const end = Offset.zero;
//         const curve = Curves.easeInOut;
//         var tween = Tween(
//           begin: begin,
//           end: end,
//         ).chain(CurveTween(curve: curve));
//         return SlideTransition(position: animation.drive(tween), child: child);
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final radius = BorderRadius.circular(32.0);

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20),
//             child: Form(
//               key: _formKey,
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Back icon + small "Login" title (top-left)
//                   Row(
//                     children: const [
//                       Icon(Icons.arrow_back_ios_new, size: 18),
//                       SizedBox(width: 8),
//                       Text(
//                         "Login",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 28),

//                   // Welcome Title
//                   const Text(
//                     "Welcome Back",
//                     style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800),
//                   ),
//                   const SizedBox(height: 8),
//                   const Text(
//                     "Sign In to your account",
//                     style: TextStyle(fontSize: 14, color: Colors.grey),
//                   ),

//                   const SizedBox(height: 28),

//                   // Email Label
//                   const Text(
//                     "Email Address",
//                     style: TextStyle(
//                       fontSize: 13,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black54,
//                     ),
//                   ),
//                   const SizedBox(height: 8),

//                   // Email Field (rounded pill)
//                   TextFormField(
//                     controller: _emailController,
//                     keyboardType: TextInputType.emailAddress,
//                     decoration: InputDecoration(
//                       hintText: "helloteja@gmail.com",
//                       filled: true,
//                       fillColor: Colors.white,
//                       contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 20,
//                         vertical: 14,
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: radius,
//                         borderSide: BorderSide(
//                           color: Colors.grey.shade300,
//                           width: 1.5,
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: radius,
//                         borderSide: BorderSide(
//                           color: Colors.grey.shade400,
//                           width: 1.5,
//                         ),
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty)
//                         return "Email tidak boleh kosong";
//                       if (!value.contains('@')) return "Email tidak valid";
//                       return null;
//                     },
//                   ),

//                   const SizedBox(height: 18),

//                   // Password Label
//                   const Text(
//                     "Password",
//                     style: TextStyle(
//                       fontSize: 13,
//                       fontWeight: FontWeight.w500,
//                       color: Colors.black54,
//                     ),
//                   ),
//                   const SizedBox(height: 8),

//                   // Password Field (rounded pill & eye icon)
//                   TextFormField(
//                     controller: _passwordController,
//                     obscureText: _obscurePassword,
//                     decoration: InputDecoration(
//                       hintText: "••••••••",
//                       filled: true,
//                       fillColor: Colors.white,
//                       contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 20,
//                         vertical: 14,
//                       ),
//                       enabledBorder: OutlineInputBorder(
//                         borderRadius: radius,
//                         borderSide: BorderSide(
//                           color: Colors.grey.shade300,
//                           width: 1.5,
//                         ),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderRadius: radius,
//                         borderSide: BorderSide(
//                           color: Colors.grey.shade400,
//                           width: 1.5,
//                         ),
//                       ),
//                       suffixIcon: IconButton(
//                         icon: Icon(
//                           _obscurePassword
//                               ? Icons.visibility_off
//                               : Icons.visibility,
//                           color: Colors.grey,
//                         ),
//                         onPressed: () => setState(() {
//                           _obscurePassword = !_obscurePassword;
//                         }),
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value == null || value.isEmpty)
//                         return "Password tidak boleh kosong";
//                       if (value.length < 6) return "Minimal 6 karakter";
//                       return null;
//                     },
//                   ),

//                   const SizedBox(height: 8),

//                   // Forgot Password (right aligned)
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

//                   const SizedBox(height: 12),

//                   // Login Button (pill-shaped)
//                   SizedBox(
//                     width: double.infinity,
//                     height: 56,
//                     child: ElevatedButton(
//                       onPressed: _submitForm,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(
//                           0xFF2F4BF7,
//                         ), // deep blue like design
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(28),
//                         ),
//                         elevation: 0,
//                       ),
//                       child: const Text(
//                         "Login",
//                         style: TextStyle(
//                           fontSize: 16,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),

//                   const SizedBox(height: 14),

//                   // Small signup hint (center)
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       const Text(
//                         "Don't have an account? ",
//                         style: TextStyle(color: Colors.black54),
//                       ),
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

//                   const SizedBox(height: 18),

//                   // Divider with text
//                   Row(
//                     children: const [
//                       Expanded(child: Divider(thickness: 1)),
//                       SizedBox(width: 10),
//                       Text(
//                         "Or Sign In With",
//                         style: TextStyle(color: Colors.black54),
//                       ),
//                       SizedBox(width: 10),
//                       Expanded(child: Divider(thickness: 1)),
//                     ],
//                   ),

//                   const SizedBox(height: 16),

//                   // Google & Facebook buttons (outlined with light grey background)
//                   Row(
//                     children: [
//                       Expanded(
//                         child: OutlinedButton.icon(
//                           onPressed: () {},
//                           icon: Image.asset(
//                             "assets/images/icongoogle.png",
//                             width: 16,
//                             height: 16,
//                           ),
//                           label: const Text(
//                             "Google",
//                             style: TextStyle(fontWeight: FontWeight.w500),
//                           ),
//                           style: OutlinedButton.styleFrom(
//                             backgroundColor: Colors.grey.shade100,
//                             side: BorderSide(color: Colors.grey.shade200),
//                             padding: const EdgeInsets.symmetric(vertical: 12),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(width: 14),
//                       Expanded(
//                         child: OutlinedButton.icon(
//                           onPressed: () {},
//                           icon: Image.asset(
//                             "assets/images/iconfacebook.png",
//                             width: 16,
//                             height: 16,
//                           ),
//                           label: const Text(
//                             "Facebook",
//                             style: TextStyle(fontWeight: FontWeight.w500),
//                           ),
//                           style: OutlinedButton.styleFrom(
//                             backgroundColor: Colors.grey.shade100,
//                             side: BorderSide(color: Colors.grey.shade200),
//                             padding: const EdgeInsets.symmetric(vertical: 12),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(12),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 22),

//                   // Join Us (left aligned, matches left padding)
//                   Padding(
//                     padding: const EdgeInsets.only(left: 4.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         const Text(
//                           "Don't have an account? ",
//                           style: TextStyle(color: Colors.black54),
//                         ),
//                         GestureDetector(
//                           onTap: () {},
//                           child: const Text(
//                             "Join Us",
//                             style: TextStyle(
//                               color: Colors.orange,
//                               fontWeight: FontWeight.w600,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),

//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
