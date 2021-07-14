import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Build() - SplashScreen");
    return Scaffold(
      body: const Center(
        child: const Text('Loading...'),
      ),
    );
  }
}
