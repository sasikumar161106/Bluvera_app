import 'package:flutter/material.dart';
import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _softFadeController;
  late Animation<double> _softFadeAnimation;

  @override
  void initState() {
    super.initState();

    // Fade-in + out animation for logo
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    // Soft fade-in for overall screen
    _softFadeController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..forward();

    _softFadeAnimation = CurvedAnimation(
      parent: _softFadeController,
      curve: Curves.easeInOut,
    );

    // Pulse animation for subtle logo breathing
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    _navigateToLogin();
  }

  _navigateToLogin() async {
    await Future.delayed(const Duration(seconds: 5));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
    }
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _softFadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final fadeAnimation =
    CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut);
    final scaleAnimation = Tween(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    return Scaffold(
      body: FadeTransition(
        opacity: _softFadeAnimation, // 🔹 Entire screen softly fades in
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF002C59),
                Color(0xFF0A6CF1),
                Color(0xFF001B3E),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Center(
            child: FadeTransition(
              opacity: fadeAnimation,
              child: ScaleTransition(
                scale: scaleAnimation,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Image.asset(
                    'assets/final_logo.png',
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
