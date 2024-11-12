// lib/main.dart
import 'package:flutter/material.dart';
import 'package:forum_app/screen/menu_screen.dart';
import 'screen/article_screen.dart';

import 'package:forum_app/screen/menu_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forum Pokehmon',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(), // Remplacez avec votre nouvel écran d'accueil
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
      ),
      body: Column(
        children: [
          const MenuScreen(), // Intégrez le menu ici
          const Expanded(child: ArticlesScreen()), // Intégrer vos articles sous le menu
        ],
      ),
    );
  }
}
