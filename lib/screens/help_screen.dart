import 'package:flutter/material.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  final List<Map<String, dynamic>> faqs = [
    {
      "question": "How do I check live water quality readings?",
      "answer":
      "Go to the Home screen or 'Live Readings' section. You can view real-time pH, TDS, and turbidity data instantly.",
    },
    {
      "question": "How can I receive alerts?",
      "answer":
      "Enable notifications under Settings > Notifications. Bluvera will send you alerts for unsafe water conditions.",
    },
    {
      "question": "How often does data update?",
      "answer":
      "Data is updated every 5 seconds automatically through sensors connected to your Bluvera system.",
    },
    {
      "question": "How can I contact support?",
      "answer":
      "You can reach us anytime via Email, Phone, or the in-app Support Chat.",
    },
  ];

  List<bool> expanded = [];

  @override
  void initState() {
    super.initState();
    expanded = List.generate(faqs.length, (_) => false);

    _fadeController =
    AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..forward();
    _fadeAnimation =
        CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  Widget _buildFAQCard(String question, String answer, int index) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
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
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => setState(() => expanded[index] = !expanded[index]),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      question,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Icon(
                    expanded[index]
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: Colors.white70,
                  ),
                ],
              ),
            ),
            if (expanded[index]) ...[
              const SizedBox(height: 10),
              Text(
                answer,
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildContactCard(
      {required IconData icon,
        required String title,
        required String subtitle,
        required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(16),
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
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 32),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(subtitle,
                    style: const TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickGuideItem(IconData icon, String title) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.blueAccent.withOpacity(0.3),
            border: Border.all(color: Colors.lightBlueAccent, width: 1.5),
          ),
          child: Icon(icon, color: Colors.white, size: 28),
        ),
        const SizedBox(height: 8),
        Text(title,
            style: const TextStyle(color: Colors.white70, fontSize: 13)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001B3E),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF001B3E), Color(0xFF0A6CF1)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/final_logo.png',
                          height: 50, width: 50, fit: BoxFit.contain),
                      const SizedBox(width: 10),
                      const Text(
                        "Help & Support",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // 🔹 FAQs
                const Text(
                  "FAQs",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                ...List.generate(
                  faqs.length,
                      (index) => _buildFAQCard(
                    faqs[index]["question"],
                    faqs[index]["answer"],
                    index,
                  ),
                ),

                const SizedBox(height: 30),

                // 🔹 Contact Support
                const Text(
                  "Contact Support",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 10),
                _buildContactCard(
                    icon: Icons.email_rounded,
                    title: "Email Us",
                    subtitle: "support@bluvera.com",
                    onTap: () {}),
                _buildContactCard(
                    icon: Icons.phone_rounded,
                    title: "Call Support",
                    subtitle: "+91 98765 43210",
                    onTap: () {}),
                _buildContactCard(
                    icon: Icons.chat_rounded,
                    title: "Live Chat",
                    subtitle: "Connect with our team",
                    onTap: () {}),

                const SizedBox(height: 30),

                // 🔹 Quick Guide
                const Center(
                  child: Text(
                    "Quick Guide",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildQuickGuideItem(Icons.home, "Home"),
                    _buildQuickGuideItem(Icons.show_chart, "Trends"),
                    _buildQuickGuideItem(Icons.warning_amber_rounded, "Alerts"),
                    _buildQuickGuideItem(Icons.person, "Profile"),
                  ],
                ),

                const SizedBox(height: 40),
                Center(
                  child: Text(
                    "Need more help? Visit www.bluvera.com/help",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
