-- phpMyAdmin SQL Dump
-- version 4.1.14
-- http://www.phpmyadmin.net
--
-- Client :  127.0.0.1
-- Généré le :  Lun 20 Août 2018 à 11:47
-- Version du serveur :  5.6.17
-- Version de PHP :  5.5.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données :  `ventelivresphp`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `livre_activ`(IN `plivre` INT(11))
update livres
set actif = 1
where LivreID = plivre and actif = 2$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `livre_create`(IN `ptitre` VARCHAR(255) CHARSET utf8, IN `pauteur` VARCHAR(255) CHARSET utf8, IN `pprix_unitaire` DECIMAL(10,0), IN `pactif` INT(1))
    NO SQL
INSERT INTO livres (titre, auteur, prix_unitaire, actif)
VALUES(ptitre, pauteur, pprix_unitaire, pactif)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `livre_desactiv`(IN `plivre` INT(11))
update livres set actif = 2 where LivreID = plivre and actif = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `livre_find`(IN `pLivreID` INT(1))
    NO SQL
SELECT * FROM livres WHERE LivreID=pLivreID LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `livre_update`(IN `pLivreID` VARCHAR(255) CHARSET utf8, IN `ptitre` VARCHAR(255) CHARSET utf8, IN `pauteur` VARCHAR(255) CHARSET utf8, IN `pprix_unitaire` DECIMAL(10,0), IN `pactif` INT(1))
    NO SQL
UPDATE livres
SET titre = ptitre, auteur = pauteur, prix_unitaire = pprix_unitaire, actif = pactif
WHERE LivreID = pLivreID$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `utilisateur_activ`(IN `putilisateur` VARCHAR(255))
update utilisateurs
set actif = 1
where utilisateur = putilisateur and actif = 2$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `utilisateur_create`(IN `putilisateur` VARCHAR(255) CHARSET utf8, IN `pcode` VARCHAR(255) CHARSET utf8, IN `pnom` VARCHAR(255) CHARSET utf8, IN `pprenom` VARCHAR(255) CHARSET utf8, IN `padmin` INT(1), IN `pactif` INT(1))
    NO SQL
INSERT INTO utilisateurs
VALUES (putilisateur, pcode, pnom, pprenom, padmin, pactif)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `utilisateur_desactiv`(IN `putilisateur` VARCHAR(255))
update utilisateurs set actif = 2 where utilisateur = putilisateur and actif = 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `utilisateur_exist`(IN `putilisateur` VARCHAR(255))
    NO SQL
SELECT COUNT(*) AS total FROM utilisateurs WHERE utilisateur=putilisateur$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `utilisateur_find`(IN `putilisateur` VARCHAR(255))
    NO SQL
SELECT * FROM utilisateurs WHERE utilisateur=putilisateur LIMIT 1$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `utilisateur_update`(IN `putilisateur` VARCHAR(255) CHARSET utf8, IN `pcode` VARCHAR(255) CHARSET utf8, IN `pnom` VARCHAR(255) CHARSET utf8, IN `pprenom` VARCHAR(255) CHARSET utf8, IN `padmin` INT(1), IN `pactif` INT(1))
    NO SQL
update utilisateurs
set utilisateur = putilisateur, code = pcode, nom = pnom, prenom = pprenom, admin = padmin, actif = pactif
where utilisateur = putilisateur$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `vente_create`(IN `putilisateur` VARCHAR(255) CHARSET utf8)
    NO SQL
INSERT INTO ventes (datevente,etat,utilisateurs_utilisateur)
VALUES (UNIX_TIMESTAMP (now()), 'valide', putilisateur)$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `vente_details_create`(IN `plivreid` INT, IN `pprix_unitaire` FLOAT, IN `pquantite` INT, IN `pidvente` INT)
    NO SQL
INSERT INTO vente_details (livres_LivreID,prix_unitaire,quantite,vente_idvente)
VALUES (plivreid,pprix_unitaire,pquantite,pidvente)$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `livres`
--

CREATE TABLE IF NOT EXISTS `livres` (
  `LivreID` int(11) NOT NULL AUTO_INCREMENT,
  `titre` varchar(255) DEFAULT NULL,
  `auteur` varchar(255) DEFAULT NULL,
  `prix_unitaire` decimal(10,0) DEFAULT NULL,
  `actif` int(1) DEFAULT NULL,
  PRIMARY KEY (`LivreID`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=17 ;

--
-- Contenu de la table `livres`
--

INSERT INTO `livres` (`LivreID`, `titre`, `auteur`, `prix_unitaire`, `actif`) VALUES
(0, 'Le Java pour les nuls', 'R.Diana', '156', 1),
(14, 'L''informatique pour les feignasses', 'De Guglielmo', '122', 0),
(15, 'Gérer ses cours pour les nuls', 'J. Gossiaux', '133', 1),
(16, 'Les Moinseries de l''informatique', 'G. Moins', '99', 0);

-- --------------------------------------------------------

--
-- Structure de la table `utilisateurs`
--

CREATE TABLE IF NOT EXISTS `utilisateurs` (
  `utilisateur` varchar(255) NOT NULL,
  `code` varchar(255) DEFAULT NULL,
  `nom` varchar(255) DEFAULT NULL,
  `prenom` varchar(255) DEFAULT NULL,
  `admin` int(1) DEFAULT NULL,
  `actif` int(1) DEFAULT NULL,
  PRIMARY KEY (`utilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Contenu de la table `utilisateurs`
--

INSERT INTO `utilisateurs` (`utilisateur`, `code`, `nom`, `prenom`, `admin`, `actif`) VALUES
('dinobolt', '1234', 'Gossiaux', 'Jeremy', 1, 0),
('fabian', '4567', 'Gillain', 'Fabian', 0, 1),
('Marylin', '4567', 'Dufrien', 'Marylin', 1, 1),
('snake7345', '1234', 'Bauduin', 'Axel', 1, 0),
('Stefanie', '4567', 'Dormont', 'Stéfanie', 0, 0);

-- --------------------------------------------------------

--
-- Structure de la table `ventes`
--

CREATE TABLE IF NOT EXISTS `ventes` (
  `idvente` int(11) NOT NULL AUTO_INCREMENT,
  `datevente` int(11) DEFAULT NULL,
  `etat` varchar(255) DEFAULT NULL,
  `utilisateurs_utilisateur` varchar(255) NOT NULL,
  PRIMARY KEY (`idvente`,`utilisateurs_utilisateur`),
  KEY `fk_vente_utilisateurs_idx` (`utilisateurs_utilisateur`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Structure de la table `vente_details`
--

CREATE TABLE IF NOT EXISTS `vente_details` (
  `idvente_detail` int(11) NOT NULL AUTO_INCREMENT,
  `quantite` int(11) DEFAULT NULL,
  `prix_unitaire` decimal(10,0) DEFAULT NULL,
  `vente_idvente` int(11) NOT NULL,
  `livres_LivreID` int(11) NOT NULL,
  PRIMARY KEY (`idvente_detail`,`vente_idvente`),
  KEY `fk_vente_detail_livres1_idx` (`livres_LivreID`),
  KEY `fk_vente_detail_vente1_idx` (`vente_idvente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
