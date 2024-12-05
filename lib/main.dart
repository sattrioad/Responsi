import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/favorit_screen.dart';

void main() {
  runApp(Nintendo());
}

class Nintendo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amiibo App',
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/favorites': (context) => FavoriteScreen(),
      },
    );
  }
}
