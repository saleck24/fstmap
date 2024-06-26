<?php
header("Access-Control-Allow-Origin: *"); 
header("Access-Control-Allow-Methods: GET,POST, OPTIONS");
header("Access-Control-Allow-Headers: Content-Type, Authorization");

// Informations de connexion à la base de données
$servername = "localhost";
$username = "root";
$password = "";
$dbname = "FST_mysql";

// Connexion à la base de données
$conn = new mysqli($servername, $username, $password, $dbname);

// Vérification de la connexion
if ($conn->connect_error) {
    die("Échec de la connexion à la base de données : " . $conn->connect_error);
}

//Traitement des Requêtes
if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    // Si le nom est fourni dans les paramètres de la requête, récupérer les détails de cette adresse spécifique
    $name = isset($_GET['name']) ? $_GET['name'] : '';
    $partial = isset($_GET['partial']) ? $_GET['partial'] : '';

    if ($name) {
        // Recherche d'une adresse par nom
        $stmt = $conn->prepare("SELECT * FROM addresses WHERE name = ?");
        $stmt->bind_param("s", $name);
        $stmt->execute();
        $result = $stmt->get_result();
        $data = $result->fetch_assoc();
        echo json_encode($data ? $data : []);
    } elseif ($partial) {
        // Recherche partielle d'adresses
        $partial = '%' . $partial . '%';
        $stmt = $conn->prepare("SELECT * FROM addresses WHERE name LIKE ?");
        $stmt->bind_param("s", $partial);
        $stmt->execute();
        $result = $stmt->get_result();
        $data = array();

        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }

        echo json_encode($data);
    } else {
        // Récupération de la liste de toutes les adresses
        $result = $conn->query("SELECT * FROM addresses");
        $data = array();

        while ($row = $result->fetch_assoc()) {
            $data[] = $row;
        }

        echo json_encode($data);
    }
}
// Traitement des requêtes POST pour la table users
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents('php://input'), true);

    // Vérification si c'est une demande d'inscription ou de connexion
    if (isset($data['nom']) && isset($data['prenom']) && isset($data['genre']) && isset($data['email']) && isset($data['password'])) {
        // Inscription
        $nom = $data['nom'];
        $prenom = $data['prenom'];
        $genre = $data['genre'];
        $email = $data['email'];
        $password = $data['password'];

        // Vérifier si l'utilisateur existe déjà
        $check_stmt = $conn->prepare("SELECT * FROM users WHERE email = ?");
        $check_stmt->bind_param("s", $email);
        $check_stmt->execute();
        $result = $check_stmt->get_result();

        if ($result->num_rows > 0) {
            // L'utilisateur existe déjà
            echo json_encode(['status' => 'exists']);
        } else {
            // L'utilisateur n'existe pas, l'insérer dans la base de données
            $stmt = $conn->prepare("INSERT INTO users (nom, prenom, genre, email, password) VALUES (?, ?, ?, ?, ?)");
            $stmt->bind_param("sssss", $nom, $prenom, $genre, $email, $password);
            if ($stmt->execute()) {
                echo json_encode(['status' => 'success']);
            } else {
                echo json_encode(['status' => 'error', 'message' => 'Erreur lors de l\'insertion']);
            }
        }
    } else if (isset($data['email']) && isset($data['password'])) {
        // Connexion
        $email = $data['email'];
        $password = $data['password'];

        // Vérifier si l'utilisateur existe et le mot de passe correspond
        $stmt = $conn->prepare("SELECT * FROM users WHERE email = ? AND password = ?");
        $stmt->bind_param("ss", $email, $password);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            // Connexion réussie
            $user = $result->fetch_assoc();
            echo json_encode([
                'status' => 'success',
                'nom' => $user['nom'],
                'prenom' => $user['prenom'],
                'genre' => $user['genre'],
                'email' => $user['email']
            ]);
        } else {
            // Connexion échouée
            echo json_encode(['status' => 'error', 'message' => 'Email ou mot de passe incorrect']);
        }
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Données manquantes']);
    }
}

// Fermer la connexion
$conn->close();
?>
