import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SingleTickerProviderStateMixin {
  bool _darkMode = true;
  bool _alerts = true;
  bool _sound = true;
  bool _vibration = false;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
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

  Widget _buildSettingTile({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    Color? glowColor,
  }) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: [Color(0xFF0A6CF1), Color(0xFF003F88)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: (glowColor ?? Colors.blueAccent).withOpacity(0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(subtitle,
                      style:
                      const TextStyle(color: Colors.white70, fontSize: 13)),
                ],
              ),
            ),
            if (trailing != null) trailing,
          ],
        ),
      ),
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
            child: Column(
              children: [
                const SizedBox(height: 20),
                // 🔹 Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/final_logo.png',
                        height: 45, width: 45, fit: BoxFit.contain),
                    const SizedBox(width: 10),
                    const Text(
                      "Settings",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // 🔹 General Settings
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("General",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 12),
                _buildSettingTile(
                  icon: Icons.dark_mode_rounded,
                  title: "Dark Mode",
                  subtitle: "Enable or disable dark theme",
                  trailing: Switch(
                    activeColor: Colors.white,
                    inactiveThumbColor: Colors.white70,
                    value: _darkMode,
                    onChanged: (val) {
                      setState(() => _darkMode = val);
                    },
                  ),
                ),
                _buildSettingTile(
                  icon: Icons.language_rounded,
                  title: "Language",
                  subtitle: "Select your preferred language",
                  trailing: const Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.white70, size: 18),
                ),

                const SizedBox(height: 20),

                // 🔹 Notifications
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Notifications",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 12),
                _buildSettingTile(
                  icon: Icons.notifications_active_rounded,
                  title: "Enable Alerts",
                  subtitle: "Get notifications for sensor updates",
                  trailing: Switch(
                    activeColor: Colors.white,
                    value: _alerts,
                    onChanged: (val) {
                      setState(() => _alerts = val);
                    },
                  ),
                  glowColor: Colors.cyanAccent,
                ),
                _buildSettingTile(
                  icon: Icons.volume_up_rounded,
                  title: "Sound",
                  subtitle: "Enable sound for notifications",
                  trailing: Switch(
                    activeColor: Colors.white,
                    value: _sound,
                    onChanged: (val) {
                      setState(() => _sound = val);
                    },
                  ),
                ),
                _buildSettingTile(
                  icon: Icons.vibration_rounded,
                  title: "Vibration",
                  subtitle: "Vibrate for critical alerts",
                  trailing: Switch(
                    activeColor: Colors.white,
                    value: _vibration,
                    onChanged: (val) {
                      setState(() => _vibration = val);
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // 🔹 Account Settings
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Account",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 12),
                _buildSettingTile(
                  icon: Icons.lock_rounded,
                  title: "Change Password",
                  subtitle: "Update your account password",
                  trailing: const Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.white70, size: 18),
                ),
                _buildSettingTile(
                  icon: Icons.privacy_tip_rounded,
                  title: "Privacy Settings",
                  subtitle: "Manage your data sharing preferences",
                  trailing: const Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.white70, size: 18),
                ),

                const SizedBox(height: 20),

                // 🔹 About Section
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("About App",
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontSize: 18,
                          fontWeight: FontWeight.w600)),
                ),
                const SizedBox(height: 12),
                _buildSettingTile(
                  icon: Icons.info_rounded,
                  title: "App Version",
                  subtitle: "Bluvera v1.0.0",
                ),
                _buildSettingTile(
                  icon: Icons.support_agent_rounded,
                  title: "Contact Support",
                  subtitle: "Need help? Reach us anytime.",
                  trailing: const Icon(Icons.arrow_forward_ios_rounded,
                      color: Colors.white70, size: 18),
                ),

                const SizedBox(height: 30),

                // 🔹 Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightBlueAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text("Settings reset to default!")),
                        );
                      },
                      icon: const Icon(Icons.restore, color: Colors.white),
                      label: const Text(
                        "Reset Settings",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: const Text(
                        "Logout",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
