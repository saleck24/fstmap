import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Models/user.dart';


class ProfilePage extends GetView {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Récupérer les données utilisateur
    final User? user = Get.arguments as User?;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (user != null) ...[
              Text('Nom :  ${user.nom}', style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('Prénom :  ${user.prenom}', style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('Email:  ${user.email}', style: const TextStyle(fontWeight: FontWeight.bold)),
              Text('Genre : ${user.genre}', style: const TextStyle(fontWeight: FontWeight.bold))
            ] /*else ...[
              const Text('Aucun utilisateur n\'est connecté', style: TextStyle(fontWeight: FontWeight.bold)),
            ]*/
          ],
        ),
      ),
    );
  }
}
