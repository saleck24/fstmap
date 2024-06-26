import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fstmap/Controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Créer une instance du LoginController
    final LoginController controller = Get.put(LoginController());
    return Scaffold(
      body: Stack(
        children: [
          // Image en arrière-plan
          Positioned.fill(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/fstadm.png"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
                ),
              ),
            ),
          ),
          // Contenu principal
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.email),
                      filled: true,
                      fillColor: Colors.white,
                      errorText: controller.emailController.text.isNotEmpty && !controller.isEmailValid.value
                          ? 'Email invalide'
                          : null,
                    ),
                    onChanged: (value) {
                      controller.validateEmail();
                    },
                  ),
                  const SizedBox(height: 10.0),
                  Obx(() {
                    return TextField(
                      controller: controller.passwordController,
                      obscureText: !controller.showPassword.value,
                      decoration: InputDecoration(
                        labelText: 'Mot de passe',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.lock),
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: IconButton(
                          icon: Icon(controller.showPassword.value
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: controller.togglePasswordVisibility,
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 20.0),
                  Obx(() {
                    return controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: controller.isEmailValid.value
                            ? controller.login
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                        ),
                        child: const Text(
                          "Se connecter",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    );
                  }),
                  Obx(() {
                    return controller.emailIncorrect.value
                        ? const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Email ou mot de passe incorrect, veuillez saisir des identifiants valides ou allez vous inscrire',
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    )
                        : const SizedBox.shrink();
                  }),
                  TextButton(
                    onPressed: () {
                      Get.toNamed('/InscriptionPage');
                    },
                    child: const Text(
                      "Pas encore inscrit ? Créez un compte",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.teal,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
