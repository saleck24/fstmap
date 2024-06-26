import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:http/http.dart' as http;
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';
import '../Models/user.dart';

class MapController extends GetxController {
  final addressController = TextEditingController();
  var userPosition = Rx<Position?>(null);
  var addressName = Rx<String?>(null);
  var latitude = Rx<double?>(null);
  var longitude = Rx<double?>(null);
  var description = Rx<String?>(null);
  var user = Rx<User?>(null);

  var categorizedAddresses = {
    'Amphis': <Map<String, dynamic>>[].obs,
    'Salles': <Map<String, dynamic>>[].obs,
    'Départements': <Map<String, dynamic>>[].obs,
    'Administration': <Map<String, dynamic>>[].obs,
  };

  @override
  void onInit() {
    super.onInit();
    _requestLocationPermission();
    _getAddressCategory();
  }

  // Demande la permission d'accès à la localisation
  Future<void> _requestLocationPermission() async {
    if (await Permission.location.request().isGranted) {
      _getCurrentLocation();
    } else {
      Get.defaultDialog(
        title: 'Autorisation',
        content: const Text(
            'Veuillez autoriser l\'accès à la localisation dans les paramètres du périphérique.'),
        confirm: TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('OK'),
        ),
      );
    }
  }

  // Récupère la position actuelle de l'utilisateur
  Future<void> _getCurrentLocation() async {
    try {
      if (userPosition.value == null) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        userPosition.value = position;
      }
    } catch (e) {
      debugPrint('Erreur lors de la récupération de la position: $e');
    }
  }

  // Recherche une adresse par son nom
  Future<void> searchAddress(String addressName) async {
    if (addressName.isEmpty) {
      Get.defaultDialog(
        title: 'Erreur',
        content: const Text('Veuillez saisir une adresse'),
        confirm: TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('OK'),
        ),
      );
    } else {
      try {
        final response = await http.get(Uri.parse(
            'http://192.168.100.133/api_fstmap/server_fst_bd.php?name=$addressName'));

        if (response.statusCode == 200) {
          Map<String, dynamic> data = json.decode(response.body);
          if (data.isEmpty) {
            suggestAddress(addressName);
          } else {
            double latitude = double.parse(data['latitude'].toString());
            double longitude = double.parse(data['longitude'].toString());
            String description = data['description'];

            this.addressName.value = addressName;
            this.latitude.value = latitude;
            this.longitude.value = longitude;
            this.description.value = description;
          }
        } else {
          suggestAddress(addressName);
        }
      } catch (e) {
        debugPrint('Erreur lors de la recherche de l\'adresse: $e');
        suggestAddress(addressName);
      }
    }
  }

  // Suggère des adresses basées sur une adresse partielle.
  Future<void> suggestAddress(String partialAddress) async {
    if (partialAddress.isEmpty) {
      return;
    }

    try {
      final response = await http.get(
        Uri.parse(
            'http://192.168.100.133/api_fstmap/server_fst_bd.php?partial=$partialAddress'),
      );

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        if (data.isEmpty) {
          Get.defaultDialog(
            title: 'Aucune Addresse',
            content: Text('Aucune adresse commence par "$partialAddress"'),
            confirm: TextButton(
              onPressed: () {
                Get.back();
              },
              child: const Text('OK'),
            ),
          );
          return;
        }

        showDialog(
          context: Get.context!,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Adresses possibles'),
              content: SizedBox(
                width: double.maxFinite,
                height: 300,
                child: Scrollbar(
                  thumbVisibility: true,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (BuildContext context, int index) {
                      var address = data[index];
                      return ListTile(
                        title: Text(address['name']),
                        onTap: () {
                          addressName.value = address['name'];
                          latitude.value = double.parse(address['latitude'].toString());
                          longitude.value = double.parse(address['longitude'].toString());
                          description.value = address['description'];
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  ),
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Annuler'),
                ),
              ],
            );
          },
        );
      } else {
        throw Exception('Échec de la récupération des données');
      }
    } catch (e) {
      debugPrint('Erreur lors de la suggestion d\'adresse: $e');
    }
  }

  // Récupère les catégories d'adresses depuis le serveur.
  Future<void> _getAddressCategory() async {
    final response = await http.get(
        Uri.parse('http://192.168.100.133/api_fstmap/server_fst_bd.php?name='));
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> addresses =
      List<Map<String, dynamic>>.from(json.decode(response.body));
      categorizedAddresses['Amphis']!.value = addresses
          .where((address) => address['name'].startsWith('Amphi'))
          .toList();
      categorizedAddresses['Salles']!.value = addresses
          .where((address) => address['name'].toLowerCase().startsWith('salle'))
          .toList();
      categorizedAddresses['Départements']!.value = addresses
          .where((address) => address['name'].startsWith('Département'))
          .toList();
      categorizedAddresses['Administration']!.value = addresses
          .where((address) =>
      !address['name'].startsWith('Amphi') &&
          !address['name'].startsWith('Département') &&
          !address['name'].toLowerCase().startsWith('salle'))
          .toList();
    } else {
      throw Exception('Failed to load addresses');
    }
  }

  Future<void> launchMapWithDirections(double latitude,
      double longitude) async {
    if (userPosition.value != null) {
      String origin =
          "${userPosition.value!.latitude},${userPosition.value!.longitude}";
      String destination = "$latitude,$longitude";

      final intent = AndroidIntent(
        action: 'action_view',
        data: Uri.encodeFull(
            'https://www.google.com/maps/dir/?api=1&origin=$origin&destination=$destination'),
        package: 'com.google.android.apps.maps',
        flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
      );

      try {
        await intent.launch();
      } catch (e) {
        Get.defaultDialog(
          title: 'Erreur lancement Google Maps',
          content:
          const Text('Impossible de lancer l\'application Google Maps.'),
          confirm: TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('OK'),
          ),
        );
      }
    }
  }

  Widget buildCategoryList(String categoryName,
      List<Map<String, dynamic>> items) {
    return Obx(() {
      return Card(
        child: ExpansionTile(
          title: Text(categoryName),
          children: [
            SizedBox(
              height: 300,
              child: SingleChildScrollView(
                child: Column(
                  children: items.map((item) {
                    return ListTile(
                      title: Text(item['name']),
                      trailing: ElevatedButton(
                        onPressed: () {
                          double latitude = double.parse(
                              item['latitude'].toString());
                          double longitude = double.parse(
                              item['longitude'].toString());
                          launchMapWithDirections(
                              latitude, longitude);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text(
                          'Voir sur la carte',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
