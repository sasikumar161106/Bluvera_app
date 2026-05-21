import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'dashboard_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  // Controllers
  late AnimationController _textController;
  late AnimationController _logoController;
  late AnimationController _buttonGlowController;

  late Animation<Offset> _textSlide;
  late Animation<double> _textFade;
  late Animation<double> _logoFade;
  late Animation<double> _buttonGlow;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final LocalAuthentication _auth = LocalAuthentication();
  bool _isPasswordVisible = false;
  bool _rememberMe = false;
  bool _showAIText = false;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _loadSavedUsername();
  }

  void _initAnimations() {
    _textController =
    AnimationController(vsync: this, duration: const Duration(seconds: 2))
      ..forward();

    _textSlide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOutCubic,
    ));

    _textFade = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeInOut,
    );

    _logoController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) _logoController.forward();
    });

    _logoFade = CurvedAnimation(
      parent: _logoController,
      curve: Curves.easeInOut,
    );

    _buttonGlowController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      lowerBound: 0.0,
      upperBound: 1.0,
    )..repeat(reverse: true);

    _buttonGlow = CurvedAnimation(
      parent: _buttonGlowController,
      curve: Curves.easeInOut,
    );
  }

  // ✅ Single user check
  bool _validateLogin(String username, String password) {
    return username == 'admin' && password == '1630';
  }

  // ✅ Save username if “Remember Me” checked
  Future<void> _saveUsername() async {
    final prefs = await SharedPreferences.getInstance();
    if (_rememberMe) {
      await prefs.setString('username', _usernameController.text);
    } else {
      await prefs.remove('username');
    }
  }

  // ✅ Load saved username
  Future<void> _loadSavedUsername() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString('username');
    if (saved != null) {
      setState(() {
        _usernameController.text = saved;
        _rememberMe = true;
      });
    }
  }

  // ✅ Login Handler
  Future<void> _handleLogin() async {
    HapticFeedback.lightImpact();

    if (_validateLogin(
        _usernameController.text.trim(), _passwordController.text.trim())) {
      setState(() => _showAIText = true);
      await _saveUsername();
      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DashboardScreen()),
        );
      }
    } else {
      _showErrorDialog();
    }
  }

  // ✅ Biometric login
  Future<void> _authenticate() async {
    try {
      bool authenticated = await _auth.authenticate(
        localizedReason: 'Use your fingerprint to login',
        options: const AuthenticationOptions(biometricOnly: true),
      );

      if (authenticated && mounted) {
        _usernameController.text = 'admin';
        _passwordController.text = '1630';
        await _handleLogin();
      }
    } catch (e) {
      debugPrint("Biometric error: $e");
    }
  }

  // ✅ Error popup
  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF002C59),
        title: const Text(
          "Login Failed",
          style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),
        ),
        content: const Text(
          "Invalid username or password. Try again!",
          style: TextStyle(color: Colors.white70, fontFamily: 'Poppins'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              "OK",
              style: TextStyle(color: Colors.lightBlueAccent),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textController.dispose();
    _logoController.dispose();
    _buttonGlowController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final glowDecoration = BoxDecoration(
      color: Colors.black.withOpacity(0.2),
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.blueAccent.withOpacity(0.5),
          blurRadius: 20,
          spreadRadius: 2,
        ),
      ],
      border: Border.all(color: Colors.lightBlueAccent.withOpacity(0.7)),
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF001B3E),
              Color(0xFF002C59),
              Color(0xFF0A6CF1),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FadeTransition(
                  opacity: _textFade,
                  child: SlideTransition(
                    position: _textSlide,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 40),

                        // 🌟 Greeting
                        const Text(
                          "Hi! Let’s Make it Smart Today",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                            shadows: [
                              Shadow(
                                blurRadius: 15,
                                color: Colors.blueAccent,
                                offset: Offset(0, 0),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 50),

                        // Username Field
                        Container(
                          decoration: glowDecoration,
                          child: TextField(
                            controller: _usernameController,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                            ),
                            decoration: const InputDecoration(
                              hintText: 'Username',
                              hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white70,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(16),
                              prefixIcon: Icon(Icons.person,
                                  color: Colors.lightBlueAccent),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Password Field with Visibility
                        Container(
                          decoration: glowDecoration,
                          child: TextField(
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            style: const TextStyle(
                              fontFamily: 'Poppins',
                              color: Colors.white,
                            ),
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: const TextStyle(
                                fontFamily: 'Poppins',
                                color: Colors.white70,
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.all(16),
                              prefixIcon: const Icon(Icons.lock,
                                  color: Colors.lightBlueAccent),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.lightBlueAccent,
                                ),
                                onPressed: () => setState(() =>
                                _isPasswordVisible = !_isPasswordVisible),
                              ),
                            ),
                          ),
                        ),

                        // Remember Me Row + Fingerprint
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: _rememberMe,
                                  onChanged: (v) =>
                                      setState(() => _rememberMe = v!),
                                  activeColor: Colors.lightBlueAccent,
                                ),
                                const Text(
                                  "Remember Me",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: const Icon(Icons.fingerprint,
                                  color: Colors.lightBlueAccent, size: 30),
                              onPressed: _authenticate,
                            ),
                          ],
                        ),

                        const SizedBox(height: 25),

                        // Glowing Login Button
                        AnimatedBuilder(
                          animation: _buttonGlow,
                          builder: (context, child) {
                            return InkWell(
                              onTap: _handleLogin,
                              borderRadius: BorderRadius.circular(15),
                              child: Container(
                                height: 55,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF0A6CF1),
                                      Color(0xFF003F88),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blueAccent.withOpacity(
                                          0.4 + (_buttonGlow.value * 0.4)),
                                      blurRadius:
                                      25 + (_buttonGlow.value * 15),
                                      spreadRadius:
                                      2 + (_buttonGlow.value * 3),
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                                child: const Center(
                                  child: Text(
                                    "LOGIN",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1.3,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // 🔹 Bottom Logo (Fade In)
                FadeTransition(
                  opacity: _logoFade,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Image.asset(
                      'assets/final_logo.png',
                      height: 250,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                if (_showAIText)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: AnimatedTextKit(
                      totalRepeatCount: 1,
                      animatedTexts: [
                        TypewriterAnimatedText(
                          "Analyzing water quality data...",
                          textStyle: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.lightBlueAccent,
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                          ),
                          speed: Duration(milliseconds: 70),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
