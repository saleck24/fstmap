import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Models/user.dart';

class InscriptionController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  var user = User(nom: '', prenom: '', genre: '', email: '').obs;
  var selectedGender = 'Homme'.obs;
  var emailExists = false.obs;
  var showPassword = false.obs;
  var showConfirmPassword = false.obs;
  var isEmailValid = false.obs;
  var confirmPassword = '';
  var error = RxString('');

  //Méthode qui valide l'email
  void validateEmail() {
    final email = emailController.text;
    isEmailValid.value = GetUtils.isEmail(email);
  }

//Méthode qui valide les champs de saisis
  bool _validateInputs() {
    final email = emailController.text;
    final password = passwordController.text;

    if (user.value.nom.isEmpty ||
        user.value.prenom.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      Get.snackbar(
        'Erreur',
        'Veuillez remplir tous les champs',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        'Erreur',
        'Veuillez entrer un email valide',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    if (password != confirmPassword) {
      Get.snackbar(
        'Erreur',
        'Les mots de passe ne correspondent pas',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    }

    return true;
  }

  // Méthode qui stocke les données des utilisateurs dans la table users
  // Si l'utilisateur est déjà dans la table on ne l'enregistre pas à nouveau
  Future<void> registerUser() async {
    if (!_validateInputs()) {
      return;
    }
    final response = await http.post(
      Uri.parse('http://192.168.100.133/api_fstmap/server_fst_bd.php'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'nom': user.value.nom,
        'prenom': user.value.prenom,
        'genre': user.value.genre,
        'email': user.value.email,
        'password': passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['status'] == 'exists') {
        emailExists.value = true;
        Get.snackbar('Erreur', 'Cet email est déjà utilisé');
      } else if (responseData['status'] == 'success') {
        emailExists.value = false;
        Get.offNamed('/login', arguments: user.value);
      } else {
        // Error during insertion
        Get.snackbar('Erreur', 'Erreur lors de l\'inscription');
      }
    } else {
      Get.snackbar('Erreur', 'Erreur de serveur : ${response.statusCode}');
    }
  }
  //Méthode qui permet d'afficher le mot de passe en cliquant sur l'oeil
  void togglePasswordVisibility() {
    showPassword.toggle();
  }

//Méthode qui permet d'afficher le mot de passe de confirmation en cliquant sur l'oeil
  void toggleConfirmPasswordVisibility() {
    showConfirmPassword.toggle();
  }
}
