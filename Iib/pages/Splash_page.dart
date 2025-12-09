import 'package:flutter/material.dart';
import 'home.dart';
import '../main_navigation.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();

    // Animação de fade-in
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        opacity = 1.0;
      });
    });

    // Aguarda 2 segundos e entra no app
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => MainNavigation()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AnimatedOpacity(
          opacity: opacity,
          duration: Duration(seconds: 2),
          curve: Curves.easeInOut,
          child: Text(
            "PROMOHARD",
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  color: Colors.purpleAccent.withOpacity(0.5),
                  blurRadius: 12,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
