import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'trends_screen.dart';
import 'alerts_screen.dart';
import 'profile_screen.dart';
import 'quality_report_screen.dart';
import 'notifications_screen.dart';
import 'settings_screen.dart';
import 'help_screen.dart';
import 'about_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    TrendsScreen(),
    AlertsScreen(),
    ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Navigation Helper for Drawer Screens
  void _navigateTo(BuildContext context, Widget screen) {
    Navigator.pop(context); // close drawer
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001B3E),

      // 🔹 Drawer
      drawer: Drawer(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF002C59), Color(0xFF0A6CF1)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: [
                    // 🔹 Drawer Header (Bluvera Logo)
                    DrawerHeader(
                      child: Center(
                        child: Image.asset(
                          'assets/final_logo.png',
                          height: 220,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    // 🔹 Menu Options
                    _buildMenuItem(
                      icon: Icons.analytics,
                      title: 'Quality Report',
                      onTap: () => _navigateTo(context, const QualityReportScreen()),
                    ),
                    _buildMenuItem(
                      icon: Icons.water,
                      title: 'Live Readings',
                      onTap: () {
                        Navigator.pop(context);
                        _onItemTapped(0);
                      },
                    ),
                    _buildMenuItem(
                      icon: Icons.show_chart,
                      title: 'Trends',
                      onTap: () {
                        Navigator.pop(context);
                        _onItemTapped(1);
                      },
                    ),
                    _buildMenuItem(
                      icon: Icons.notifications_active,
                      title: 'Notifications',
                      onTap: () => _navigateTo(context, const NotificationsScreen()),
                    ),
                    _buildMenuItem(
                      icon: Icons.settings,
                      title: 'Settings',
                      onTap: () => _navigateTo(context, const SettingsScreen()),
                    ),
                    _buildMenuItem(
                      icon: Icons.help_outline,
                      title: 'Help / FAQ',
                      onTap: () => _navigateTo(context, const HelpScreen()),
                    ),
                    _buildMenuItem(
                      icon: Icons.info_outline,
                      title: 'About App',
                      onTap: () => _navigateTo(context, const AboutScreen()),
                    ),
                  ],
                ),
              ),

              // 🔹 Profile Section (Bottom)
              InkWell(
                onTap: () => _navigateTo(context, const ProfileScreen()),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    border: Border(
                      top: BorderSide(color: Colors.lightBlueAccent.withOpacity(0.5)),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const RadialGradient(
                            colors: [Color(0xFF0A6CF1), Color(0xFF001B3E)],
                            radius: 0.8,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueAccent.withOpacity(0.5),
                              blurRadius: 10,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Icon(Icons.person, color: Colors.white, size: 32),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Admin',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            'Online',
                            style: TextStyle(color: Colors.greenAccent, fontSize: 13),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios,
                          color: Colors.white70, size: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

      // 🔹 App Bar
      appBar: AppBar(
        backgroundColor: const Color(0xFF002C59),
        elevation: 10,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        centerTitle: true,
        title: const Text(
          'Dashboard',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      // 🔹 Body (Active Tab)
      body: SafeArea(child: _screens[_selectedIndex]),

      // 🔹 Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: const Color(0xFF002C59),
        selectedItemColor: Colors.lightBlueAccent,
        unselectedItemColor: Colors.white70,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.show_chart), label: 'Trends'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Alerts'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  // 🔹 Drawer Menu Item Builder
  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
      hoverColor: Colors.white10,
      splashColor: Colors.blueAccent.withOpacity(0.3),
    );
  }
}
