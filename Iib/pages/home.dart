import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PromoHard"),
        backgroundColor: Color(0xFF7B1FA2),
      ),
      body: Center(
        child: Text(
          "Carregando promoções...",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
