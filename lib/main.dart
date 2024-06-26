import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Vues/inscriptionpage.dart';
import 'Vues/loginpage.dart';
import 'Vues/mappage.dart';
import 'Vues/profilepage.dart';
import 'Controllers/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String initialRoute = prefs.getString('lastRoute') ?? '/'; // Récupérer la dernière route visitée

  // Vérifier si l'utilisateur est connecté
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  if (!isLoggedIn) {
    initialRoute = '/';
  }


  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());

    return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        themeMode: themeController.themeMode.value,
        theme: ThemeData.light().copyWith(
          primaryColor: Colors.blue,
          hintColor: Colors.blueAccent,
        ),
        darkTheme: ThemeData.dark().copyWith(
          primaryColor: Colors.blue,
          hintColor: Colors.blueAccent,
        ),
        initialRoute: initialRoute,
        getPages: [
          GetPage(name: '/', page: () => const LoginPage()),
          GetPage(name: '/InscriptionPage', page: () => const InscriptionPage()),
          GetPage(name: '/map', page: () => const MapPage()),
          GetPage(name: '/profile', page: () => const ProfilePage()),
        ],
        routingCallback: (routing) async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          if (routing?.current != null) {
            prefs.setString('lastRoute', routing!.current);
          }
          //prefs.setString('lastRoute', routing!.current);
        },
      );
    });
  }
}