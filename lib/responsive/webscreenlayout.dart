import 'package:flutter/material.dart';

class WebScreenLayout extends StatelessWidget {
  const WebScreenLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Intagram Clone'),
      ),
      body: const Center(
        child: Text('WEb Layout'),
      ),
    );
  }
}
