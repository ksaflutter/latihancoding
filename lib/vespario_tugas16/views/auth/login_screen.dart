import 'package:flutter/material.dart';
import 'package:flutter_application_1/vespario_tugas16/extension/navigation.dart';
import 'package:flutter_application_1/vespario_tugas16/preference/shared_preference.dart';
import 'package:flutter_application_1/vespario_tugas16/services/api/auth_service.dart';
import 'package:flutter_application_1/vespario_tugas16/theme/app_colors.dart';
import 'package:flutter_application_1/vespario_tugas16/views/auth/register_screen.dart';
import 'package:flutter_application_1/vespario_tugas16/views/home/home_screen.dart';

class LoginScreenFinal extends StatefulWidget {
  const LoginScreenFinal({super.key});

  @override
  State<LoginScreenFinal> createState() => _LoginScreenFinalState();
}

class _LoginScreenFinalState extends State<LoginScreenFinal> {
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

                  // Login Card
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
                          "Masuk",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: AppColorsFinal.darkGray,
                          ),
                        ),
                        height(8),
                        const Text(
                          "Silahkan masuk untuk melanjutkan",
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColorsFinal.mediumGray,
                          ),
                        ),
                        height(24),

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

                        // Login Button
                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: isLoading ? null : login,
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: AppColorsFinal.white,
                                  )
                                : const Text("Masuk"),
                          ),
                        ),
                        height(20),

                        // Register Link
                        Center(
                          child: TextButton(
                            onPressed: () {
                              context.push(const RegisterScreenFinal());
                            },
                            child: const Text(
                              "Belum punya akun? Daftar disini",
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

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Email dan password harus diisi"),
          backgroundColor: AppColorsFinal.redAccent,
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await AuthServiceFinal.loginUser(
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
              content: Text("Login berhasil"),
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
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
