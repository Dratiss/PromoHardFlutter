import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PromoHard',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.red,
        scaffoldBackgroundColor: Color(0xFF121212),
        cardColor: Color(0xFF1E1E1E),
        textTheme: TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Map<String, String>> deals = [
    {
      "title": "RTX 4060 — Kabum",
      "price": "R\$ 1.799",
      "img": "https://via.placeholder.com/150",
    },
    {
      "title": "Ryzen 5 5600X — Amazon",
      "price": "R\$ 799",
      "img": "https://via.placeholder.com/150",
    },
    {
      "title": "Headset HyperX — AliExpress",
      "price": "R\$ 199",
      "img": "https://via.placeholder.com/150",
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PromoHard"),
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        itemCount: deals.length,
        itemBuilder: (context, index) {
          final item = deals[index];
          return Card(
            margin: EdgeInsets.all(12),
            child: ListTile(
              leading: Image.network(item["img"]!),
              title: Text(item["title"]!),
              subtitle: Text(item["price"]!,
                  style: TextStyle(color: Colors.greenAccent)),
            ),
          );
        },
      ),
    );
  }
}
