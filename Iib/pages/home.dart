import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PromoHard"),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          "Carregando promoções...",
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
