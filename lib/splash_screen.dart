import 'package:flutter/material.dart';
import 'package:my_coffee/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          //Full screen background image
          Positioned.fill(
            child: Image.asset(
              'assets/coffee.png',
              fit: BoxFit.cover,
            ),
          ),
          FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTextContent(),
                _buildBottomButton(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTextContent() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 100, horizontal: 60),
      child: Column(
        children: [
          _buildText(
            'Coffee Is Love',
            fontSize: 56,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
          SizedBox(height: 10),
          _buildText(
            'Brewed to Perfection',
            fontSize: 28,
            fontWeight: FontWeight.w500,
            color: Colors.white70,
          ),
        ],
      ),
    );
  }

  Widget _buildText(
    String text, {
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    TextAlign textAlign = TextAlign.start,
  }) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }

  Widget _buildBottomButton() {
    return Padding(
      padding: EdgeInsets.only(bottom: 50),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const HomeScreen(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: _buildText(
          'Book Your Relief',
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.brown,
        ),
      ),
    );
  }
}
