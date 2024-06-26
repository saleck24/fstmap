-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : sam. 25 mai 2024 à 19:05
-- Version du serveur : 8.2.0
-- Version de PHP : 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `fst_mysql`
--

-- --------------------------------------------------------

--
-- Structure de la table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
CREATE TABLE IF NOT EXISTS `addresses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `description` text,
  `latitude` double NOT NULL,
  `longitude` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=54 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `addresses`
--

INSERT INTO `addresses` (`id`, `name`, `description`, `latitude`, `longitude`) VALUES
(1, 'scolarité', 'prendre à droite puis à gauche après l\'entrée de la fac côté des bus qui vont à bmd', 18.16076, -15.992994),
(2, 'Département Biologie', 'Aller tout droit après l\'entrée de la fac jusqu\'au premier batiment à gauche', 18.160126, -15.993483),
(3, 'Département Chimie', 'le batiment à gauche collé au département de biologie', 18.159747, -15.993488),
(4, 'Département physique', 'le batiment avant dernier de la rangée des batiments de départements', 18.159014, -15.993479),
(5, 'Département Math-Informatique', 'le dernier batiment de la rangée des batiments de départements', 18.158629, -15.993481),
(6, 'Amphi 1', 'Aller Tout droit après l\'entrée des batiments des salles de cours', 18.161059, -15.99417),
(7, 'Amphi 2', 'La salle à droite collée à l\'amphi 1', 18.161162, -15.994175),
(8, 'Amphi 3', 'la salle à droite collée à l\'amphi 2', 18.161308, -15.994175),
(9, 'Amphi 4', 'la salle à droite collé à l\'amphi 3', 18.161413, -15.994175),
(10, 'Amphi 5', 'la salle à droite collée à l\'amphi 4', 18.16155, -15.994189),
(11, 'Amphi 6', 'La salle tout au fond de la rangée des amphis(1,2,3,4,5)', 18.161635, -15.994189),
(12, 'Amphi 7', 'La salle entre la rangée des amphis(1,2,3,4,5,6) et les batiments des salles de cours.', 18.161735, -15.993972),
(13, 'Département géologie', 'le batiment entre le département de chimie et celui de physique', 18.159436, -15.993471),
(14, 'Bureau du Doyen', '2ème étage du batiment de l\'administration(Decanat).Prendre le couloir à gauche, et c\'est la 3ème porte à droite.', 18.161239, -15.993323),
(15, 'Bureau du Vice-Doyen', '2ème étage du batiment de l\'administration(Decanat). Prendre le couloir à gauche et c\'est la 2ème porte à droite.', 18.161231, -15.993298),
(18, 'salle 9', 'première salle à gauche du rez-de-chaussée\r\ndes batiments des salles en venant de l\'entrée principale de la fac. ', 18.16086, -15.993791),
(19, 'salle 10', 'dernière salle à gauche du rez-de-chaussée du batiment des salles en venant de l\'entrée principale de la fac.', 18.160698, -15.993783),
(20, 'salle 1', 'Première salle à droite du rez-de-chaussée du batiment des salles en venant de l\'entrée principale de la fac.', 18.161021, -15.993795),
(21, 'salle 2', '2ème salle à droite du rez-de-chaussée du batiment des salles en venant de l\'entrée principale de la fac.', 18.16108, -15.993795),
(22, 'salle 3', '3ème salle à droite du rez-de-chaussée du batiment des salles en venant de l\'entrée principale de la fac.', 18.161143, -15.993795),
(23, 'salle 4', '4ème salle à droite du rez-de-chaussée du batiment des salles en venant de l\'entrée principale de la fac.', 18.161217, -15.993791),
(24, 'salle 5', '5ème salle du rez-de-chaussée des batiments de salles en venant de l\'entrée principale de la fac.', 18.16131, -15.993796),
(25, 'salle 6', '6ème salle du rez-de-chaussée des batiments des salles en venant de l\'entrée principale de la fac.', 18.1614, -15.993787),
(26, 'salle 7', 'Avant dernière salle du rez-de-chaussée des batiments des salles en venant de l\'entrée principale de la fac', 18.161488, -15.993791),
(27, 'salle 8', 'dernière salle au rez-de-chaussée des batiments des salles en venant de l\'entrée principale de la fac.', 18.161585, -15.99379),
(28, 'salle 103', 'première salle à gauche du premier étage des batiments des salles.', 18.160898, -15.993791),
(29, 'salle 102', '2ème salle à gauche du 1er étage des batiments des salles.', 18.160796, -15.993792),
(30, 'salle 101', 'dernière salle à gauche au premier étage des batiments des salles.', 18.160698, -15.99379),
(31, 'salle 203', '1ère salle à gauche au 2ème étage des batiments des salles.', 18.1609, -15.993791),
(32, 'salle 202', '2ème salle à gauche au 2ème étage des batiments des salles.', 18.160805, -15.99379),
(33, 'salle 201', 'dernière salle à gauche au 2ème étage des batiments des salles', 18.16071, -15.99379),
(34, 'salle 104', '1ère salle à droite au premier étage des batiments des salles', 18.161024, -15.993795),
(35, 'salle 105', '2ème salle à droite au premier étage des batiments des salles', 18.161083, -15.993799),
(36, 'salle 106', '3ème salle à droite au premier étage des batiments des salles', 18.16114, -15.993787),
(37, 'salle 107', '4ème salle à droite au premier étage des batiments des salles. ', 18.161214, -15.993795),
(38, 'salle 108', '5ème salle à droite au premier étage des batiments des salles', 18.161335, -15.993791),
(39, 'salle 109', '6ème salle à droite au premier étage des batiments des salles', 18.161429, -15.993791),
(40, 'salle 110', 'Avant dernière salle à droite au premier étage des batiments des salles', 18.161516, -15.993782),
(41, 'salle 111', 'dernière salle à droite au premier étage des batiments des salles', 18.161594, -15.993783),
(42, 'salle 204', '1ère salle à droite au 2ème étage des batiments des salles.', 18.161032, -15.993799),
(43, 'salle 205', '2ème salle à droite au 2ème étage des batiments des salles.', 18.161109, -15.993789),
(44, 'salle 206', '3ème salle à droite au 2ème étage des batiments des salles', 18.161183, -15.993789),
(45, 'salle 207', '4ème salle à droite au 2ème étage des batiments des salles.', 18.161276, -15.993789),
(46, 'salle 208', '5ème salle à droite au 2ème étage des  batiments des salles', 18.16136, -15.993785),
(47, 'salle 209', '6ème salle à droite au 2ème étage des batiments des salles', 18.161428, -15.993778),
(48, 'salle 210', 'Avant dernière salle à droite au 2ème étage des batiments des salles.', 18.161522, -15.993787),
(49, 'salle 211', 'dernière salle à droite au 2ème étage des batiments des salles', 18.161587, -15.993781),
(53, 'salle buvette', 'prendre à gauche en venant de l\'entrée principale de la fac', 18.160133, -15.99299),
(52, 'salle conférence 1', 'salle à gauche de la scolarité', 18.160611, -15.993027);

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `genre` enum('Homme','Femme') NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `nom`, `prenom`, `genre`, `email`, `password`) VALUES
(17, 'baya', 'saleck', 'Homme', 'saleckbaya@gmail.com', '123');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
