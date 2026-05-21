import 'package:flutter/material.dart';

class LiveReadingsScreen extends StatelessWidget {
  const LiveReadingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF001B3E),
      appBar: AppBar(
        title: const Text('Live Readings'),
        backgroundColor: const Color(0xFF002C59),
      ),
      body: const Center(
        child: Text(
          '💧 Live Readings Coming Soon!',
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}
