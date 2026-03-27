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
  int _r = 0;
  int _g = 0;
  int _b = 0;
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
    _r = _random.nextInt(256);
    _g = _random.nextInt(256);
    _b = _random.nextInt(256);

    return Color.fromARGB(255, _r, _g, _b);
  }

  ///Function to generate text color based on brightness of the background color
  Color _getContrastColor(Color color) {
    return color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
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
