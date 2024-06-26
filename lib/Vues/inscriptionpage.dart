import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fstmap/Controllers/inscription_controller.dart';

class InscriptionPage extends StatelessWidget {
  const InscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Créer une instance du InscriptionController
    final InscriptionController controller = Get.put(InscriptionController());

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
                  image: AssetImage("assets/images/f1.png"),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
                ),
              ),
            ),
          ),
          // Contenu principal
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(vertical: 80.0, horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Nom',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (value) {
                      controller.user.update((user) {
                        user?.nom = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10.0),
                  TextField(
                    decoration: const InputDecoration(
                      labelText: 'Prénom',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person_outline),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (value) {
                      controller.user.update((user) {
                        user?.prenom = value;
                      });
                    },
                  ),
                  const SizedBox(height: 10.0),
                  TextField(
                    controller: controller.emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email),
                      filled: true,
                      fillColor: Colors.white,
                    ),
                    onChanged: (value) {
                      controller.user.update((user) {
                        user?.email = value;
                      });
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
                  const SizedBox(height: 10.0),
                  Obx(() {
                    return TextField(
                      obscureText: !controller.showConfirmPassword.value,
                      decoration: InputDecoration(
                        labelText: 'Confirmer le mot de passe',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.lock_outline),
                        filled: true,
                        fillColor: Colors.white,
                        suffixIcon: IconButton(
                          icon: Icon(controller.showConfirmPassword.value
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: controller.toggleConfirmPasswordVisibility,
                        ),
                      ),
                      onChanged: (value) {
                        controller.confirmPassword = value;
                      },
                    );
                  }),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 7.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          'Genre: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18, // Ajuster la taille ici
                            color: Colors.black, // Couleur plus foncée pour le contraste
                          ),
                        ),
                        Obx(() {
                          return Row(
                            children: [
                              Radio<String>(
                                value: 'Homme',
                                groupValue: controller.selectedGender.value,
                                onChanged: (String? value) {
                                  controller.selectedGender.value = value!;
                                  controller.user.update((user) {
                                    user?.genre = value;
                                  });
                                },
                              ),
                              const Text(
                                'Homme',
                                style: TextStyle(
                                  fontSize: 16, // Ajuster la taille ici
                                  color: Colors.black, // Couleur plus foncée pour le contraste
                                ),
                              ),
                              Radio<String>(
                                value: 'Femme',
                                groupValue: controller.selectedGender.value,
                                onChanged: (String? value) {
                                  controller.selectedGender.value = value!;
                                  controller.user.update((user) {
                                    user?.genre = value;
                                  });
                                },
                              ),
                              const Text(
                                'Femme',
                                style: TextStyle(
                                  fontSize: 16, // Ajuster la taille ici
                                  color: Colors.black, // Couleur plus foncée pour le contraste
                                ),
                              ),
                            ],
                          );
                        }),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.registerUser,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text(
                        "Inscription",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Obx(() {
                    return controller.emailExists.value
                        ? const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Text(
                        'Email existant, veuillez saisir un autre !',
                        style: TextStyle(color: Colors.red),
                      ),
                    )
                        : const SizedBox.shrink();
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
