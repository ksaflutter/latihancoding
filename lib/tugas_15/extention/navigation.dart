import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  Future<T?> push<T>(Widget page) {
    return Navigator.push(
      this,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  Future<T?> pushReplacement<T>(Widget page) {
    return Navigator.pushReplacement(
      this,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void pop<T>([T? result]) {
    Navigator.pop(this, result);
  }

  Future<T?> pushAndRemoveAll<T>(Widget page) {
    return Navigator.pushAndRemoveUntil(
      this,
      MaterialPageRoute(builder: (context) => page),
      (route) => false,
    );
  }
}
