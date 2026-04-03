# 🗺️ FST Map - Application de Navigation Universitaire

**FST Map** est une application mobile **cross-platform** développée en **Flutter** qui aide les étudiants et nouveaux arrivants de la Faculté des Sciences et Technologies de Nouakchott à naviguer dans le campus.

## ✨ Fonctionnalités Principales

### 🔐 Authentification Utilisateur
- **Inscription** : Création de compte avec validation d'email
- **Connexion** : Authentification sécurisée via email/mot de passe
- **Gestion de profil** : Accès aux informations utilisateur
- **Persistance de session** : Sauvegarde automatique de la dernière route visitée

### 🗺️ Système de Localisation
- **Géolocalisation en temps réel** : Récupération de la position actuelle de l'utilisateur
- **Permissions GPS** : Gestion intelligente des permissions Android/iOS
- **Recherche d'adresses** : Recherche exacte et recherche par suggestion
- **Intégration Google Maps** : Lancement de Google Maps avec itinéraires

### 📂 Catégorisation des Lieux
- **Amphis** : Tous les amphithéâtres (Amphi 1-7)
- **Salles de cours** : Plus de 40 salles réparties sur plusieurs étages
- **Départements** : Biologie, Chimie, Physique, Mathématiques-Informatique, Géologie
- **Administration** : Scolarité, bureaux du Doyen, salles de conférence

### 🎨 Interface Utilisateur
- **Mode clair/sombre** : Thème adaptatif selon les préférences
- **Navigation fluide** : Navigation GetX avec routes nommées
- **Listes expandables** : Catégories pliables pour une meilleure organisation
- **Design Material Design** : Interface moderne et intuitive

---

## 🏗️ Architecture

L'application suit le pattern **MVC (Model-View-Controller)** avec une séparation claire des responsabilités :

```
lib/
├── Controllers/          # Logique métier et gestion d'état
│   ├── inscription_controller.dart    # Gestion inscription/validation
│   ├── login_controller.dart          # Gestion authentification
│   ├── map_controller.dart            # Gestion localisation et recherche
│   └── theme_controller.dart          # Gestion du thème
├── Models/              # Structure des données
│   └── user.dart        # Modèle utilisateur
├── Vues/               # Interface utilisateur
│   ├── loginpage.dart           # Page de connexion
│   ├── inscriptionpage.dart     # Page d'inscription
│   ├── mappage.dart             # Page principale (carte)
│   └── profilepage.dart         # Page profil utilisateur
└── main.dart           # Point d'entrée et configuration

Backend/
└── server_fst_bd.php    # API PHP REST
```

### Pattern d'État avec GetX
- **Reactive Programming** : Variables observables (`.obs`)
- **Gestion centralisée** : Controllers comme gestionnaires d'état
- **Binding dynamique** : UI reactive aux changements d'état

---

## 🛠️ Stack Technologique

### **Frontend**
| Technologie | Version | Utilisation |
|---|---|---|
| **Flutter** | 3.3+ | Framework mobile cross-platform |
| **Dart** | 3.3-4.0 | Langage de programmation |
| **GetX** | 4.6.6 | Gestion d'état et navigation |
| **HTTP** | 1.2.1 | Requêtes HTTP REST |
| **Geolocator** | 12.0.0 | Géolocalisation GPS |
| **Permission Handler** | 11.3.1 | Gestion des permissions |
| **Android Intent Plus** | 5.0.2 | Intégration Google Maps Android |
| **Shared Preferences** | 2.2.3 | Stockage local persistant |
| **Material Design** | Flutter intégré | Design UI |

### **Backend**
| Technologie | Version | Utilisation |
|---|---|---|
| **PHP** | 8.2.13 | Serveur backend |
| **MySQL** | 8.2.0 | Base de données |
| **WampServer** | - | Stack Apache+PHP+MySQL |
| **phpMyAdmin** | 5.2.1 | Gestion BDD |

### **Plateformes Supportées**
- ✅ **Android** (API 21+)
- ✅ **iOS** (11.0+)
- ✅ **Web**
- ✅ **Windows/macOS**

---

## 💾 Base de Données

### Structure
```sql
-- Table Utilisateurs
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(255) NOT NULL,
  prenom VARCHAR(255) NOT NULL,
  genre ENUM('Homme','Femme'),
  email VARCHAR(255) NOT NULL,
  password VARCHAR(255) NOT NULL
);

-- Table Adresses/Lieux
CREATE TABLE addresses (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name TEXT NOT NULL,
  description TEXT,
  latitude DOUBLE NOT NULL,
  longitude DOUBLE NOT NULL
);
```

### Données
- **Utilisateurs** : Gestion des comptes avec authentification
- **Adresses** : 52 lieux catalogués avec coordonnées GPS et descriptions

---

## 🚀 Installation et Configuration

### Prérequis
- Flutter SDK 3.3+
- Dart SDK (inclus dans Flutter)
- WampServer (Apache + PHP + MySQL)
- Android SDK / iOS SDK

### Étapes d'Installation

#### 1. Cloner le Repository
```bash
git clone https://github.com/saleck24/fstmap.git
cd fstmap
```

#### 2. Installer les Dépendances Flutter
```bash
flutter pub get
```

#### 3. Configuration WampServer
1. **Télécharger et installer WampServer**
2. **Démarrer WampServer** et accéder à phpMyAdmin (http://localhost/phpmyadmin)
3. **Créer une nouvelle base de données** : `FST_mysql`
4. **Importer** le fichier `FST_mysql.sql` dans phpMyAdmin

#### 4. Configurer le Script PHP
Éditer le fichier `server_fst_bd.php` et mettre à jour les identifiants :
```php
<?php
$servername = "localhost";
$username = "root";           // Votre username MySQL
$password = "";               // Votre password MySQL
$dbname = "FST_mysql";        // Votre nom de BDD
?>
```

#### 5. Placer le Script PHP
```bash
# Copier server_fst_bd.php dans :
C:\wamp64\www\api_fstmap\server_fst_bd.php
```

#### 6. Configurer l'URL API (Important)
Éditer les contrôleurs et remplacer `192.168.100.133` par votre **IP locale** :
```dart
// Dans inscription_controller.dart, map_controller.dart, login_controller.dart
'http://[VOTRE_IP]/api_fstmap/server_fst_bd.php'
```

#### 7. Lancer l'Application
```bash
# Android
flutter run -d android

# iOS
flutter run -d iphone

# Web
flutter run -d chrome

# Emulator
flutter emulators --launch <emulator_id>
flutter run
```

---

## 📡 API REST

### Endpoints

#### GET - Récupérer les Adresses
```
GET /server_fst_bd.php
GET /server_fst_bd.php?name=Amphi+1          # Recherche exacte
GET /server_fst_bd.php?partial=Amphi         # Recherche partielle
```

#### POST - Inscription
```
POST /server_fst_bd.php
Content-Type: application/json

{
  "nom": "Baya",
  "prenom": "Saleck",
  "genre": "Homme",
  "email": "user@example.com",
  "password": "mot_de_passe"
}

Réponses:
- {"status": "success"}
- {"status": "exists"}      # Email déjà utilisé
- {"status": "error", "message": "..."}
```

#### POST - Connexion
```
POST /server_fst_bd.php
Content-Type: application/json

{
  "email": "user@example.com",
  "password": "mot_de_passe"
}

Réponse:
{
  "status": "success",
  "nom": "Baya",
  "prenom": "Saleck",
  "genre": "Homme",
  "email": "user@example.com"
}
```

---

## 🎯 Fonctionnalités Détaillées

### Inscription & Connexion
- ✅ Validation email en temps réel
- ✅ Vérification de correspondance des mots de passe
- ✅ Détection d'email existant
- ✅ Affichage/masquage des mots de passe
- ✅ Messages d'erreur détaillés

### Page Carte
- ✅ Recherche par nom complet
- ✅ Recherche par suggestion (autocomplétion)
- ✅ Affichage des catégories (Amphis, Salles, Depts, Admin)
- ✅ Listes expandables par catégorie
- ✅ Affichage description + coordonnées GPS
- ✅ Bouton "Voir sur la carte" → Google Maps
- ✅ Itinéraires avec position actuelle

### Thème & Accessibilité
- ✅ Mode clair par défaut
- ✅ Mode sombre adaptatif
- ✅ Persévérance des préférences (SharedPreferences)
- ✅ Navigation maintenue entre sessions

---

## 📋 Controllers

### `LoginController`
Gère l'authentification utilisateur
- Validation des identifiants
- Requête POST vers le serveur
- Gestion des erreurs
- Navigation vers la page carte

### `InscriptionController`
Gère l'enregistrement de nouveaux utilisateurs
- Validation complète des champs
- Vérification email
- Création de compte
- Gestion des doublons

### `MapController`
Cœur de l'application - gestion de la localisation
- Demande de permissions GPS
- Récupération position actuelle
- Recherche d'adresses (exacte/partielle)
- Catégorisation automatique
- Lancement Google Maps avec itinéraires

### `ThemeController`
Gestion du thème de l'application
- Toggle mode clair/sombre
- Persistance du choix utilisateur

---

## 🔒 Sécurité

**Note** : Cette application est à but éducatif. Pour la production :
- [ ] Implémenter le **hashing des mots de passe** (bcrypt)
- [ ] Utiliser des **tokens JWT**
- [ ] Ajouter **HTTPS/SSL**
- [ ] Implémenter **CORS** sécurisé
- [ ] Valider/nettoyer les entrées côté serveur

---

## 🎓 Points Forts du Projet

### Pour les Employeurs
✨ **Compétences Démontrées** :
- Développement **full-stack** (Flutter + PHP + MySQL)
- Gestion d'état avec **GetX** (état réactif)
- API **REST** et intégration backend
- **Géolocalisation** et permissions système
- Bases de données **relationnelles**
- Navigation multi-écrans
- Design **Material Design 3**
- Gestion d'authentification
- Persistance de données locales
- Gestion des erreurs robuste

🎯 **Cas d'Utilisation Réel** :
- Application universitaire pratique
- Aide à la navigation de campus
- Intégration Google Maps
- Système utilisateur complet

---

## 🤝 Contribution

Les contributions sont bienvenues ! Pour contribuer :
1. Fork le repository
2. Créer une branche (`git checkout -b feature/AmazingFeature`)
3. Commit vos changements (`git commit -m 'Add some AmazingFeature'`)
4. Push vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrir une Pull Request

---

## 📄 Licence

Ce projet est sous licence MIT - voir le fichier LICENSE pour les détails.

---

## 👨‍💻 Auteur

**Saleck Baya**  
📧 [saleckbaya5@gmail.com](mailto:saleckbaya5@gmail.com)  
🔗 [GitHub](https://github.com/saleck24)

---

## 📞 Support

Pour toute question ou problème, veuillez ouvrir une **Issue** sur le repository.

---

**Dernière mise à jour** : 2026-04-03
