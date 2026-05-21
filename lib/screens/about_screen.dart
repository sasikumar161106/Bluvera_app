import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _logoController;

  @override
  void initState() {
    super.initState();
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _logoController.dispose();
    super.dispose();
  }

  Widget _buildInfoCard(String title, String content, IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          colors: [Color(0xFF0A6CF1), Color(0xFF003F88)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blueAccent.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.white, size: 30),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text(content,
                    style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        height: 1.4)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001B3E),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF001B3E), Color(0xFF0A6CF1)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 20),

                // 🔹 Bluvera Logo with Glow
                ScaleTransition(
                  scale: Tween(begin: 0.95, end: 1.05)
                      .animate(CurvedAnimation(
                      parent: _logoController, curve: Curves.easeInOut)),
                  child: Image.asset(
                    'assets/final_logo.png',
                    height: 150,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 15),

                const Text(
                  "BLUVERA",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(height: 10),

                const Text(
                  "Smarter Water, Cleaner Future",
                  style: TextStyle(
                      color: Colors.lightBlueAccent,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),

                const SizedBox(height: 30),

                // 🔹 About Bluvera
                _buildInfoCard(
                  "About Bluvera",
                  "Bluvera is an intelligent water quality monitoring system that integrates IoT and AI to ensure safe and sustainable water management. "
                      "With real-time analysis and smart alerts, Bluvera helps communities and industries maintain optimal water conditions efficiently.",
                  Icons.water_drop_rounded,
                ),

                // 🔹 App Details
                _buildInfoCard(
                  "App Details",
                  "Version: 1.0.0\nPlatform: Flutter\nLast Updated: January 2026",
                  Icons.info_outline_rounded,
                ),

                // 🔹 Developer Info
                _buildInfoCard(
                  "Developed By",
                  "Developed by Sasikumar and Team\nVel Tech High Tech Engineering College\nDepartment of Computer Science Engineering",
                  Icons.code_rounded,
                ),

                // 🔹 Contact Section
                _buildInfoCard(
                  "Contact & Support",
                  "Email: support@bluvera.com\nPhone: +91 98765 43210\nWebsite: www.bluvera.com",
                  Icons.support_agent_rounded,
                ),

                const SizedBox(height: 20),

                // 🔹 Social Icons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.language_rounded,
                        color: Colors.white70, size: 28),
                    SizedBox(width: 20),
                    Icon(Icons.email_rounded, color: Colors.white70, size: 28),
                    SizedBox(width: 20),
                    Icon(Icons.phone_android_rounded,
                        color: Colors.white70, size: 28),
                  ],
                ),

                const SizedBox(height: 40),

                const Divider(color: Colors.white24, thickness: 1),

                const SizedBox(height: 10),
                const Text(
                  "© 2026 Bluvera Systems. All rights reserved.",
                  style: TextStyle(color: Colors.white54, fontSize: 13),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Made with ❤️ for Smart Water Innovation",
                  style: TextStyle(color: Colors.white38, fontSize: 12),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
