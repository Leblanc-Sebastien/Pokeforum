// lib/menu_screen.dart
import 'package:flutter/material.dart';
import 'package:forum_app/screen/connexion_screen.dart';


class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            // Naviguer vers la page de connexion
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ConnexionScreen()),
            );
          },
          child: const Text("Se connecter"),
        ),
        // Ajoutez d'autres boutons ici si nécessaire
      ],
    );
  }
}
