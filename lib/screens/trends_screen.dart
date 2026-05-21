import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class TrendsScreen extends StatefulWidget {
  const TrendsScreen({super.key});

  @override
  State<TrendsScreen> createState() => _TrendsScreenState();
}

class _TrendsScreenState extends State<TrendsScreen>
    with SingleTickerProviderStateMixin {
  int _selectedTab = 0;

  final List<String> _tabs = ["pH", "TDS", "Turbidity", "Temp"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001B3E),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            // 🔹 Title
            const Center(
              child: Text(
                "Water Quality Trends",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const SizedBox(height: 20),

            // 🔹 Quality Chart
            _buildChartCard(
              title: "Overall Quality",
              color1: Colors.lightBlueAccent,
              color2: Colors.blueAccent,
              data: [
                FlSpot(0, 3),
                FlSpot(1, 5),
                FlSpot(2, 7),
                FlSpot(3, 6),
                FlSpot(4, 8),
                FlSpot(5, 7),
              ],
              minY: 0,
              maxY: 10,
            ),
            const SizedBox(height: 30),

            // 🔹 Tabs
            const Center(
              child: Text(
                "Factor Trends",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 16),

            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(_tabs.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTab = index;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: _selectedTab == index
                            ? Colors.blueAccent
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Text(
                        _tabs[index],
                        style: TextStyle(
                          color: _selectedTab == index
                              ? Colors.white
                              : Colors.white70,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Animated Factor Chart
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              transitionBuilder: (child, anim) =>
                  FadeTransition(opacity: anim, child: child),
              child: _buildFactorChart(_selectedTab),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Factor Chart by Tab
  Widget _buildFactorChart(int index) {
    switch (index) {
      case 0:
        return _buildChartCard(
          title: "pH Level",
          color1: Colors.yellowAccent,
          color2: Colors.amber,
          data: [
            FlSpot(0, 6.5),
            FlSpot(1, 6.8),
            FlSpot(2, 7.2),
            FlSpot(3, 7.0),
            FlSpot(4, 7.4),
            FlSpot(5, 7.1),
          ],
          minY: 6,
          maxY: 8,
        );
      case 1:
        return _buildChartCard(
          title: "TDS (ppm)",
          color1: Colors.lightBlueAccent,
          color2: Colors.blue,
          data: [
            FlSpot(0, 200),
            FlSpot(1, 250),
            FlSpot(2, 300),
            FlSpot(3, 320),
            FlSpot(4, 280),
            FlSpot(5, 260),
          ],
          minY: 100,
          maxY: 400,
        );
      case 2:
        return _buildChartCard(
          title: "Turbidity (NTU)",
          color1: Colors.orangeAccent,
          color2: Colors.deepOrange,
          data: [
            FlSpot(0, 2),
            FlSpot(1, 3),
            FlSpot(2, 2.5),
            FlSpot(3, 2.8),
            FlSpot(4, 3.2),
            FlSpot(5, 3.5),
          ],
          minY: 0,
          maxY: 5,
        );
      case 3:
        return _buildChartCard(
          title: "Temperature (°C)",
          color1: Colors.pinkAccent,
          color2: Colors.redAccent,
          data: [
            FlSpot(0, 26),
            FlSpot(1, 27),
            FlSpot(2, 29),
            FlSpot(3, 30),
            FlSpot(4, 28),
            FlSpot(5, 27),
          ],
          minY: 20,
          maxY: 35,
        );
      default:
        return const SizedBox();
    }
  }

  // 🔹 Clean Graph Card (Uniform Style)
  Widget _buildChartCard({
    required String title,
    required List<FlSpot> data,
    required double minY,
    required double maxY,
    required Color color1,
    required Color color2,
  }) {
    return Container(
      key: ValueKey(title),
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
            blurRadius: 12,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "PM",
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Graph
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                minY: minY,
                maxY: maxY,
                gridData: FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 35,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 12),
                        );
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        switch (value.toInt()) {
                          case 0:
                            return const Text("12",
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 12));
                          case 1:
                            return const Text("2",
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 12));
                          case 2:
                            return const Text("4",
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 12));
                          case 3:
                            return const Text("6",
                                style: TextStyle(
                                    color: Colors.white70, fontSize: 12));
                        }
                        return const Text('');
                      },
                    ),
                  ),
                  topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                  rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: Colors.white24, width: 1),
                ),
                lineBarsData: [
                  LineChartBarData(
                    spots: data,
                    isCurved: true,
                    gradient: LinearGradient(
                      colors: [color1, color2],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) =>
                          FlDotCirclePainter(
                            radius: 4,
                            color: Colors.white,
                            strokeWidth: 0,
                          ),
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          color1.withOpacity(0.25),
                          color2.withOpacity(0.05)
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
