\# Installation et Sécurisation de MariaDB — ML-SRV-WEB-01

\## Projet MediLink — Cheima | 28/03/2026



\## 1. Installation

\- OS : Debian 12

\- Paquet : mariadb-server (équivalent MySQL sur Debian)

\- Commande : sudo apt update \&\& sudo apt install mariadb-server -y



\## 2. Démarrage

\- sudo systemctl start mariadb

\- sudo systemctl enable mariadb



\## 3. Sécurisation

\- sudo mysql\_secure\_installation

\- Utilisateur root protégé par mot de passe

\- Utilisateurs anonymes supprimés

\- Login root distant désactivé

\- Base de test supprimée

\- bind-address = 127.0.0.1 (pas accessible depuis le réseau)



\## 4. Base de données

\- Nom : medilink

\- Tables : medecins (17), infirmiers (3), patients (5)

\- Utilisateur applicatif : medilink\_app (Nginx/PHP)



\## 5. Vérification

\- sudo ss -tlnp | grep mariadb → 127.0.0.1:3306 uniquement

