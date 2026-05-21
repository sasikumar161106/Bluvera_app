import 'package:flutter/material.dart';
import 'dart:math' as math;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoPulseController;
  late AnimationController _cardGlowController;
  late Animation<double> _cardGlowAnimation;

  @override
  void initState() {
    super.initState();

    _logoPulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _cardGlowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _cardGlowAnimation = Tween<double>(begin: 0.3, end: 0.8).animate(
      CurvedAnimation(parent: _cardGlowController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _logoPulseController.dispose();
    _cardGlowController.dispose();
    super.dispose();
  }

  Widget _buildCard(String title, String value, IconData icon) {
    return AnimatedBuilder(
      animation: _cardGlowAnimation,
      builder: (context, child) {
        return Container(
          height: 110,
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Color(0xFF0A6CF1), Color(0xFF001B3E)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.blueAccent.withOpacity(_cardGlowAnimation.value),
                blurRadius: 20,
                spreadRadius: 2,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(icon, size: 40, color: Colors.white),
              const SizedBox(width: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    value,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001B3E),

      appBar: AppBar(
        backgroundColor: const Color(0xFF002C59),
        elevation: 0,
        title: const SizedBox.shrink(),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 🔹 Bigger Bluvera logo (increased size)
              ScaleTransition(
                scale: Tween(begin: 0.9, end: 1.1).animate(
                  CurvedAnimation(
                    parent: _logoPulseController,
                    curve: Curves.easeInOut,
                  ),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/final_logo.png',
                    height: 220, // ⬆️ Increased from 140 to 220
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // 🌊 Quality Report Section
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF0A6CF1), Color(0xFF003F88)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blueAccent.withOpacity(0.4),
                      blurRadius: 25,
                      spreadRadius: 3,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.water_drop,
                        color: Colors.greenAccent, size: 50),
                    SizedBox(height: 10),
                    Text(
                      "Water Quality: GOOD",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      "Safe for usage 💧",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              // 💧 Live Sensor Readings
              _buildCard('pH Level', '7.2', Icons.science),
              _buildCard('TDS', '420 ppm', Icons.opacity),
              _buildCard('Turbidity', '5 NTU', Icons.waves),
              _buildCard('Water Temperature', '28°C', Icons.thermostat),
              _buildCard('Rain Status', 'No Rain', Icons.cloud),
              _buildCard('Air Temperature', '30°C', Icons.sunny),
            ],
          ),
        ),
      ),
    );
  }
}
