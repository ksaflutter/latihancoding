import 'package:flutter/material.dart';
import 'package:flutter_application_1/vespario_tugas16/extension/navigation.dart';
import 'package:flutter_application_1/vespario_tugas16/preference/shared_preference.dart';
import 'package:flutter_application_1/vespario_tugas16/services/api/auth_service.dart';
import 'package:flutter_application_1/vespario_tugas16/theme/app_colors.dart';
import 'package:flutter_application_1/vespario_tugas16/views/home/home_screen.dart';

class RegisterScreenFinal extends StatefulWidget {
  const RegisterScreenFinal({super.key});

  @override
  State<RegisterScreenFinal> createState() => _RegisterScreenFinalState();
}

class _RegisterScreenFinalState extends State<RegisterScreenFinal> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColorsFinal.primaryGradient,
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo and Title
                  const Icon(
                    Icons.motorcycle,
                    size: 80,
                    color: AppColorsFinal.white,
                  ),
                  height(16),
                  const Text(
                    "Vespario",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: AppColorsFinal.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  height(8),
                  const Text(
                    "Book. Fix. Ride.",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColorsFinal.white,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  height(40),

                  // Register Card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: AppColorsFinal.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Daftar",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColorsFinal.darkGray,
                          ),
                        ),
                        height(8),
                        const Text(
                          "Buat akun baru untuk memulai",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColorsFinal.mediumGray,
                          ),
                        ),
                        height(24),

                        // Name Field
                        buildTitle("Nama Lengkap"),
                        height(8),
                        buildTextField(
                          controller: nameController,
                          hintText: "Masukkan nama lengkap anda",
                        ),
                        height(16),

                        // Email Field
                        buildTitle("Email"),
                        height(8),
                        buildTextField(
                          controller: emailController,
                          hintText: "Masukkan email anda",
                          keyboardType: TextInputType.emailAddress,
                        ),
                        height(16),

                        // Password Field
                        buildTitle("Password"),
                        height(8),
                        buildTextField(
                          controller: passwordController,
                          hintText: "Masukkan password anda",
                          isPassword: true,
                        ),
                        height(24),

                        // Register Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : register,
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: AppColorsFinal.white,
                                  )
                                : const Text("Daftar"),
                          ),
                        ),
                        height(20),

                        // Login Link
                        Center(
                          child: TextButton(
                            onPressed: () {
                              context.pop();
                            },
                            child: const Text(
                              "Sudah punya akun? Masuk disini",
                              style: TextStyle(
                                color: AppColorsFinal.mintGreen,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColorsFinal.darkGray,
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hintText,
    bool isPassword = false,
    TextInputType? keyboardType,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword ? !isPasswordVisible : false,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
                icon: Icon(
                  isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                  color: AppColorsFinal.mediumGray,
                ),
              )
            : null,
      ),
    );
  }

  SizedBox height(double height) => SizedBox(height: height);

  Future<void> register() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Semua field harus diisi"),
          backgroundColor: AppColorsFinal.redAccent,
        ),
      );
      return;
    }

    if (password.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Password minimal 6 karakter"),
          backgroundColor: AppColorsFinal.redAccent,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await AuthServiceFinal.registerUser(
        name: name,
        email: email,
        password: password,
      );

      if (response.data?.token != null && response.data?.user != null) {
        await SharedPreferenceFinal.saveUserData(
          token: response.data!.token!,
          userId: response.data!.user!.id!,
          userName: response.data!.user!.name!,
          userEmail: response.data!.user!.email!,
        );

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Registrasi berhasil"),
              backgroundColor: AppColorsFinal.successGreen,
            ),
          );
          context.pushAndRemoveAll(const HomeScreenFinal());
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString().replaceAll("Exception: ", "")),
            backgroundColor: AppColorsFinal.redAccent,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
