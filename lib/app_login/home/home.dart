import 'package:flutter/material.dart';

class AppLoginSatu extends StatelessWidget {
  const AppLoginSatu({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('App Login Satu'),
        ),
        body: const Center(
          child: Text('Welcome to App Login Satu'),
        ),
      ),
    );
  }
}
