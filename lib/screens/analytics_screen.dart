import 'package:flutter/material.dart';

class AnalyticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Analytics')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Text('AI Insight'),
                subtitle: Text('TDS increasing for 3 days → Water quality may deteriorate'),
              ),
            ),
            // Add history graphs & correlation charts here
          ],
        ),
      ),
    );
  }
}
