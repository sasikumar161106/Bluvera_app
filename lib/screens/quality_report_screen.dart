import 'package:flutter/material.dart';
import 'dart:math' as math;

class QualityReportScreen extends StatefulWidget {
  const QualityReportScreen({super.key});

  @override
  State<QualityReportScreen> createState() => _QualityReportScreenState();
}

class _QualityReportScreenState extends State<QualityReportScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _qualityScore = 85; // Example percentage (0–100)
  String _status = "Safe";
  Color _statusColor = Colors.greenAccent;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _updateQualityStatus();
  }

  void _updateQualityStatus() {
    setState(() {
      if (_qualityScore >= 75) {
        _status = "Safe";
        _statusColor = Colors.greenAccent;
      } else if (_qualityScore >= 50) {
        _status = "Moderate";
        _statusColor = Colors.yellowAccent;
      } else {
        _status = "Unsafe";
        _statusColor = Colors.redAccent;
      }
    });
  }

  Widget _buildParameterCard(String title, String value, IconData icon) {
    return Container(
      height: 100,
      width: double.infinity,
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title,
                  style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                      fontWeight: FontWeight.w500)),
              Text(value,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 🔹 Circular Animated Gauge
  Widget _buildQualityGauge() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          size: const Size(180, 180),
          painter: _GaugePainter(_qualityScore, _statusColor),
        );
      },
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/final_logo.png',
                        height: 50, width: 50, fit: BoxFit.contain),
                    const SizedBox(width: 10),
                    const Text(
                      "Quality Report",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),

                // Quality Gauge
                Stack(
                  alignment: Alignment.center,
                  children: [
                    _buildQualityGauge(),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "${_qualityScore.toInt()}%",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _status,
                          style: TextStyle(
                            color: _statusColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // Parameters
                _buildParameterCard("pH Level", "7.2", Icons.science_rounded),
                const SizedBox(height: 16),
                _buildParameterCard("TDS", "420 ppm", Icons.water_drop_rounded),
                const SizedBox(height: 16),
                _buildParameterCard(
                    "Turbidity", "5 NTU", Icons.waves_rounded),
                const SizedBox(height: 16),
                _buildParameterCard(
                    "Temperature", "28°C", Icons.thermostat_rounded),

                const SizedBox(height: 30),

                // Result Text
                Container(
                  padding:
                  const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  decoration: BoxDecoration(
                    color: _statusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: _statusColor, width: 1.5),
                  ),
                  child: Text(
                    _status == "Safe"
                        ? "✅ Water is safe for use"
                        : _status == "Moderate"
                        ? "⚠️ Water quality is moderate"
                        : "🚫 Water is unsafe for use",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // 🔹 Refresh Button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlueAccent,
        onPressed: () {
          setState(() {
            _qualityScore = (50 + math.Random().nextInt(50)).toDouble();
            _updateQualityStatus();
          });
        },
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }
}

// 🔹 Gauge Painter Class
class _GaugePainter extends CustomPainter {
  final double value;
  final Color color;

  _GaugePainter(this.value, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint base = Paint()
      ..color = Colors.white24
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Paint progress = Paint()
      ..shader = SweepGradient(
        colors: [color, color.withOpacity(0.3)],
        startAngle: -math.pi / 2,
        endAngle: 2 * math.pi,
      ).createShader(Rect.fromCircle(center: size.center(Offset.zero), radius: 90))
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    const double startAngle = -math.pi / 2;
    final double sweepAngle = 2 * math.pi * (value / 100);

    final center = size.center(Offset.zero);
    final radius = size.width / 2;

    canvas.drawCircle(center, radius, base);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle,
        sweepAngle, false, progress);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
