-- ============================================
-- MediLink — Schéma base de données
-- Projet Jedha Bootcamp — Cheima
-- ============================================

CREATE DATABASE IF NOT EXISTS medilink CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE medilink;

-- ============================================
-- Table : medecins
-- ============================================
CREATE TABLE IF NOT EXISTS medecins (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    nom         VARCHAR(100) NOT NULL,
    prenom      VARCHAR(100) NOT NULL,
    telephone   VARCHAR(20),
    specialite  VARCHAR(100),
    email       VARCHAR(150),
    rpps        VARCHAR(20) UNIQUE
);

INSERT INTO medecins (nom, prenom, telephone, specialite, email, rpps) VALUES
('DUBOIS',    'Martin',  '04 71 60 11 22', 'Médecine Générale',        'martin.dubois@cabinet.local',    'RPPS10012345'),
('LAURENT',   'Sophie',  '04 71 60 11 22', 'Médecine Générale',        'sophie.laurent@cabinet.local',   'RPPS10012346'),
('CHASSAGNE', 'Pierre',  '04 71 60 11 22', 'Médecine Générale',        'pierre.chassagne@cabinet.local', 'RPPS10012347'),
('FONTAINE',  'Marie',   '04 71 60 11 33', 'Pédiatrie',                'marie.fontaine@cabinet.local',   'RPPS10012348'),
('BERNARD',   'Lucas',   '04 71 60 11 33', 'Pédiatrie',                'lucas.bernard@cabinet.local',    'RPPS10012349'),
('MOREAU',    'Camille', '04 71 60 11 44', 'Gynécologie',              'camille.moreau@cabinet.local',   'RPPS10012350'),
('PETIT',     'Hélène',  '04 71 60 11 44', 'Gynécologie / Sage-femme', 'helene.petit@cabinet.local',     'RPPS10012351'),
('ROUSSEAU',  'Thomas',  '04 71 60 11 55', 'Kinésithérapie',           'thomas.rousseau@cabinet.local',  'RPPS10012352'),
('MARCHAND',  'Julie',   '04 71 60 11 55', 'Kinésithérapie',           'julie.marchand@cabinet.local',   'RPPS10012353'),
('FAURE',     'Michel',  '04 71 60 11 66', 'Podologie',                'michel.faure@cabinet.local',     'RPPS10012354'),
('LEFEBVRE',  'Anne',    '04 71 60 11 66', 'Podologie',                'anne.lefebvre@cabinet.local',    'RPPS10012355'),
('RENARD',    'Paul',    '04 71 60 11 77', 'Chirurgie Dentaire',       'paul.renard@cabinet.local',      'RPPS10012356'),
('DUPUIS',    'Alice',   '04 71 60 11 77', 'Orthodontie',              'alice.dupuis@cabinet.local',     'RPPS10012357'),
('SIMON',     'Claire',  '04 71 60 11 88', 'Ophtalmologie',            'claire.simon@cabinet.local',     'RPPS10012358'),
('AUBERT',    'Marc',    '04 71 60 11 88', 'Ophtalmologie',            'marc.aubert@cabinet.local',      'RPPS10012359'),
('BLANC',     'Nathalie','04 71 60 11 99', 'Laboratoire',              'nathalie.blanc@cabinet.local',   'RPPS10012360'),
('MERCIER',   'Vincent', '04 71 60 11 99', 'Laboratoire',              'vincent.mercier@cabinet.local',  'RPPS10012361');

-- ============================================
-- Table : infirmiers
-- ============================================
CREATE TABLE IF NOT EXISTS infirmiers (
    id          INT AUTO_INCREMENT PRIMARY KEY,
    nom         VARCHAR(100) NOT NULL,
    prenom      VARCHAR(100) NOT NULL,
    telephone   VARCHAR(20),
    specialite  VARCHAR(100),
    email       VARCHAR(150),
    rpps        VARCHAR(20) UNIQUE
);

INSERT INTO infirmiers (nom, prenom, telephone, specialite, email, rpps) VALUES
('GARCIA', 'Lucie',    '04 71 60 22 11', 'Infirmière Généraliste', 'lucie.garcia@cabinet.local',    'RPPS20012001'),
('THOMAS', 'Maxime',   '04 71 60 22 22', 'Infirmier Urgences',     'maxime.thomas@cabinet.local',   'RPPS20012002'),
('PERRIN', 'Isabelle', '04 71 60 22 33', 'Infirmière Pédiatrie',   'isabelle.perrin@cabinet.local', 'RPPS20012003');

-- ============================================
-- Table : patients
-- ============================================
CREATE TABLE IF NOT EXISTS patients (
    id                INT AUTO_INCREMENT PRIMARY KEY,
    nom               VARCHAR(100) NOT NULL,
    prenom            VARCHAR(100) NOT NULL,
    date_naissance    DATE,
    nss               VARCHAR(20) UNIQUE,
    telephone         VARCHAR(20),
    email             VARCHAR(150),
    adresse           VARCHAR(255),
    medecin_referent  VARCHAR(150),
    cree_le           DATE DEFAULT (CURRENT_DATE)
);

INSERT INTO patients (nom, prenom, date_naissance, nss, telephone, email, adresse, medecin_referent, cree_le) VALUES
('DUPONT',  'Marie',   '1985-03-15', '285037500000000', '06 12 34 56 78', 'marie.dupont@email.fr',   '12 rue de la Paix, Paris',        'Dr. DUBOIS Martin',    '2026-03-26'),
('BERNARD', 'Pierre',  '1972-11-08', '172117500000000', '06 98 76 54 32', 'pierre.bernard@email.fr', '5 avenue Victor Hugo, Lyon',      'Dr. LAURENT Sophie',   '2026-03-26'),
('LECLERC', 'Sophie',  '1990-07-22', '290077500000000', '07 11 22 33 44', 'sophie.leclerc@email.fr', '8 boulevard Gambetta, Marseille', 'Dr. FONTAINE Marie',   '2026-03-26'),
('MOREAU',  'Jean',    '1965-05-30', '165057500000000', '06 55 44 33 22', 'jean.moreau@email.fr',    '3 rue du Moulin, Bordeaux',       'Dr. CHASSAGNE Pierre', '2026-03-26'),
('PETIT',   'Camille', '2001-09-14', '201097500000000', '07 66 77 88 99', 'camille.petit@email.fr',  '17 rue des Fleurs, Toulouse',     'Dr. DUBOIS Martin',    '2026-03-26');

-- ============================================
-- Utilisateur applicatif (Nginx/PHP)
-- ============================================
CREATE USER IF NOT EXISTS 'medilink_app'@'localhost' IDENTIFIED BY 'AppMediLink2025!';
GRANT ALL PRIVILEGES ON medilink.* TO 'medilink_app'@'localhost';
FLUSH PRIVILEGES;

-- ============================================
-- Test du compte applicatif
-- mysql -u medilink_app -p'AppMediLink2025!' medilink
-- SELECT nom, prenom FROM patients;
-- EXIT;
-- ============================================