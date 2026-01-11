import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to login after 3 seconds (duration of the GIF or desired delay)
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050708),
      body: Center(
        child: Image.asset(
          'assets/Splash-Sreen/splash-Screen.gif',
          fit: BoxFit.contain,
          // Ensure the GIF plays
          gaplessPlayback: true,
        ),
      ),
    );
  }
}
