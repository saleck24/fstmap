import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  var themeMode = ThemeMode.light.obs;

  //méthode alternant entre le mode de thème clair
  // et sombre de l'application.Par défault le mode est de thème clair
  void toggleTheme() {
    themeMode.value = themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(themeMode.value);
  }
 //méthode permettant de changer explicitement le mode de thème
  // de l'application en fonction du mode passé en paramètre.
  void changeThemeMode(ThemeMode mode) {
    themeMode.value = mode;
    Get.changeThemeMode(mode);
  }
}
