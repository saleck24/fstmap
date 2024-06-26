import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/user.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var emailIncorrect = false.obs;
  var isLoading = false.obs;
  var isEmailValid = false.obs;
  var showPassword = false.obs;

  //Méthode qui valide l'email
  void validateEmail() {
    final email = emailController.text;
    isEmailValid.value = GetUtils.isEmail(email);
  }


  //Méthode qui affiche le mot de passe en cliquant sur l'oeil
  void togglePasswordVisibility() {
    showPassword.toggle();
  }

  //méthode qui envoie les informations de connexion
  // au serveur et gère la navigation en fonction de la réponse.
  Future<void> login() async {
    try {
      isLoading.value = true;

      final response = await http.post(
        Uri.parse('http://192.168.100.133/api_fstmap/server_fst_bd.php'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': emailController.text,
          'password': passwordController.text,
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 'success') {
          emailIncorrect.value = false;
          final User user = User(
            nom: responseData['nom']?? '',
            prenom: responseData['prenom']?? '',
            genre: responseData['genre']?? '',
            email: emailController.text,
          );
          // Sauvegarde de l'état de connexion avec SharedPreferences
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          await prefs.setString('user', jsonEncode(user.toJson()));

          // Mise à jour de la dernière route visitée
          await prefs.setString('lastRoute', '/map');

          Get.offNamed('/map', arguments: user);

        } else {
          emailIncorrect.value = true;
        }
      } else {
        Get.snackbar('Erreur', 'Erreur de serveur : ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Erreur', 'Erreur inattendue: $e');
    } finally {
      isLoading.value = false;
    }
  }

}
