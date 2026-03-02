import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'login_page.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingPage(),
    ),
  );
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 97, 105, 255),
            Color(0xFF00ADEF),
            Color.fromARGB(255, 133, 108, 255),
          ],
        ),
      ),
      child: AnimatedSplashScreen(
        splash: Image.asset(
          'assets/logo.png',
          width: 100,
          height: 100,
        ),
        nextScreen: LoginPage(), // goes to login_page.dart
        splashIconSize: 100,
        duration: 3000,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}