import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fstmap/Controllers/map_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Controllers/theme_controller.dart';
import '../Models/user.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MapController controller = Get.put(MapController());
    final ThemeController themeController = Get.find<ThemeController>();
    final User? user = Get.arguments as User?;
    // Handle the case where user is null
    if (user == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAllNamed('/login');
      });
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('FST Map'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/fstadm.png"),
                  fit: BoxFit.cover,
                  colorFilter:
                  ColorFilter.mode(Colors.black26, BlendMode.darken),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                TextFormField(
                  controller: controller.addressController,
                  decoration: InputDecoration(
                    labelText: 'Adresse',
                    border: const OutlineInputBorder(),
                    prefixIcon: ShaderMask(
                      shaderCallback: (bounds) {
                        return const LinearGradient(
                          colors: [
                            Colors.blue,
                            Colors.green,
                            Colors.orange,
                            Colors.red
                          ],
                          stops: [0.3, 0.5, 0.6, 0.3],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomLeft,
                          tileMode: TileMode.mirror,
                        ).createShader(bounds);
                      },
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(color: Colors.grey.shade300),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.blue),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    controller.searchAddress(
                        controller.addressController.text);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text(
                    'Rechercher',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Obx(() {
                  if (controller.addressName.value != null &&
                      controller.latitude.value != null &&
                      controller.longitude.value != null &&
                      controller.description.value != null) {
                    return Card(
                      child: Column(
                        children: [
                          ListTile(
                            title: Text(
                                'Adresse : ${controller.addressName.value}'),
                            subtitle: Text(
                                'Description :  ${controller.description
                                    .value}\n'
                                    'Latitude :  ${controller.latitude
                                    .value}\n'
                                    'Longitude :  ${controller.longitude
                                    .value}'),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              controller.launchMapWithDirections(
                                  controller.latitude.value!,
                                  controller.longitude.value!);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Icon(
                                  Icons.map,
                                  color: Colors.black,
                                ),
                                Text(
                                  'Afficher sur la carte',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),
                Expanded(
                  child: Obx(() {
                    return ListView(
                      children: controller.categorizedAddresses.keys.map((
                          category) {
                        return Card(
                          child: ExpansionTile(
                            title: Text(category),
                            children: controller
                                .categorizedAddresses[category]!
                                .map((item) {
                              return ListTile(
                                title: Text(item['name']),
                                trailing: ElevatedButton(
                                  onPressed: () {
                                    double latitude = double.parse(
                                        item['latitude'].toString());
                                    double longitude = double.parse(
                                        item['longitude'].toString());
                                    controller.launchMapWithDirections(
                                        latitude, longitude);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    //backgroundColor: Colors.blue,
                                    side: BorderSide(color: Get.isDarkMode
                                        ? Colors.white
                                        : Colors.black),
                                  ),
                                  child: ShaderMask(
                                    shaderCallback: (bounds) {
                                      return const LinearGradient(
                                        colors: [
                                          Colors.blue,
                                          Colors.green,
                                          Colors.orange,
                                          Colors.red
                                        ],
                                        stops: [0.3, 0.5, 0.6, 0.3],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomLeft,
                                        tileMode: TileMode.mirror,
                                      ).createShader(bounds);
                                    },
                                    child: const Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      }).toList(),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: DrawerContent(user: user, themeController: themeController,controller: controller),
      ),
    );
  }
}

class DrawerContent extends StatelessWidget {
  final User user;
  final ThemeController themeController;
  final MapController controller;

  const DrawerContent({
    super.key,
    required this.user,
    required this.themeController,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 150,
          backgroundColor: Colors.blue,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(
                    Icons.account_circle_sharp,
                    size: 80,
                    color: Colors.white,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                '${user.prenom} ${user.nom}',
              ),
              const SizedBox(height: 5),
              const Text(
                "FST de Nouakchott",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: const Icon(Icons.person),
          title: const Text("Profil"),
          onTap: () {
            Get.toNamed('/profile', arguments: user);
          },
        ),
        const SizedBox(height: 10),
        ListTile(
          leading: const Icon(Icons.logout),
          title: const Text("Déconnexion"),
          onTap: () async{
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('lastRoute', Get.currentRoute); // Enregistrer la route actuelle
            // Déconnexion de l'utilisateur
            Get.offAllNamed('/');
            // Changer le mode de thème en mode light
            themeController.changeThemeMode(ThemeMode.light);
          },
        ),
        const Divider(),
        Obx(() {
          return SwitchListTile(
            title: const Text("Mode sombre"),
            secondary: Icon(themeController.themeMode.value == ThemeMode.dark
                ? Icons.dark_mode
                : Icons.light_mode),
            value: themeController.themeMode.value == ThemeMode.dark,
            onChanged: (value) {
              themeController.toggleTheme();
            },
          );
        }),
      ],
    );
  }
}
