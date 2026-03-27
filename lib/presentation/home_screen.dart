import 'dart:math';
import 'package:flutter/material.dart';

/// Main screen that displays text and handles background color changes.
class HomeScreen extends StatefulWidget {
  /// Creates home screen.
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Random _random = Random();
  static const int maxColorValue = 256;
  static const double contrastThreshold = 0.5;
  static const int fullAlpha = 255;

  Color _backgroundColor = Colors.white;
  Color _textColor = Colors.black;

  ///Function to change and update color
  void _changeColor() {
    setState(() {
      _backgroundColor = _generateRandomColor();
      _textColor = _getContrastColor(_backgroundColor);
    });
  }

  ///Function to generate random values for rgb when generating new color
  Color _generateRandomColor() {
    final r = _random.nextInt(maxColorValue);
    final g = _random.nextInt(maxColorValue);
    final b = _random.nextInt(maxColorValue);

    return Color.fromARGB(fullAlpha, r, g, b);
  }

  ///Function to generate text color based on brightness of the background color
  Color _getContrastColor(Color color) {
    return color.computeLuminance() > contrastThreshold
        ? Colors.black
        : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _changeColor,
      child: Scaffold(
        backgroundColor: _backgroundColor,
        body: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
          color: _backgroundColor,
          child: Center(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 500),
              style: TextStyle(
                fontSize: 40,
                color: _textColor,
                fontWeight: FontWeight.bold,
              ),
              child: const Text("Hello There"),
            ),
          ),
        ),
      ),
    );
  }
}
