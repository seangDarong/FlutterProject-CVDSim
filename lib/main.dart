import 'package:flutter/material.dart';

void main() {
  runApp(const FontTestApp());
}

class FontTestApp extends StatelessWidget {
  const FontTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Font Test Run'),
          backgroundColor: Colors.blueGrey,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1. Default System Font
              const Text(
                'This is the default font',
                style: TextStyle(fontSize: 18),
              ),
              
              const SizedBox(height: 30),

              // 2. Your Custom DM Sans Font
              const Text(
                'This is DM Sans Regular',
                style: TextStyle(
                  fontFamily: 'DMSans', // Make sure this matches your pubspec.yaml
                  fontSize: 28,
                  fontWeight: FontWeight.normal,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Testing numbers: 1234567890',
                style: TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}