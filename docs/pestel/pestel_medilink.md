# Analyse PESTEL — Infrastructure IT MediLink

> **Cabinet Médical Pluridisciplinaire — Zone Désert Médical**  
> 8 spécialités · 17 praticiens · 3 infirmiers  
> Jedha Bootcamp 2025 — Projet Final  
> Version : v2.0 · 26 mars 2026

---

## Synthèse des facteurs

| Facteur | Niveau d'impact | Orientation | Facteur clé MediLink |
|---------|----------------|-------------|---------------------|
| Politique | **Très élevé** | Opportunité + Contrainte | Désert médical · NIS2 · Plan Cyber · Aides publiques |
| Économique | **Élevé** | Opportunité + Contrainte | ROI open source · Subventions · TCO maîtrisé |
| Social | **Très élevé** | Opportunité forte | Accès aux soins · Confiance patient · Télémédecine |
| Technologique | **Très élevé** | Menace + Opportunité | Ransomware · Zero Trust · IA · AWS cloud |
| Environnemental | **Faible** | Neutre | Virtualisation · DEEE · Sobriété numérique |
| Légal | **Critique** | Contrainte forte | RGPD Art.9 · HDS · PGSSI-S · NIS2 2024 |

---

## P — Politique · Impact Très Élevé

**Orientation : Opportunité + Contrainte**

### Désert médical — contexte favorable aux aides publiques
L'implantation en zone sous-dotée en offre de soins place MediLink dans un contexte politique très favorable. Les pouvoirs publics (État, Régions, Départements, communes) ont fait de la lutte contre les déserts médicaux une priorité nationale. Plusieurs dispositifs de financement sont directement mobilisables pour l'infrastructure IT :
- **ARS** — aides à l'installation en zone déficitaire (~3 000–5 000 EUR)
- **Conseil Régional** — subventions numériques santé (~4 000–6 000 EUR)
- **Conseil Départemental** — aide à l'équipement cabinet pluridisciplinaire (~2 000–4 000 EUR)
- **DETR** (Dotation Équipement Territoires Ruraux) via la Mairie (~2 000–3 000 EUR)

### Directive NIS2 (transposée en droit français 2024)
Les établissements de santé entrent dans le périmètre des **entités essentielles**. Obligations : gestion des risques cyber, tests de sécurité réguliers, notification ANSSI sous 24h en cas d'incident significatif. L'architecture MediLink (pfSense, Wazuh, jumpboxes, VPN MFA) y répond directement.

### Plan Cyber gouvernemental
1 milliard EUR sur 5 ans (ANSSI) — des aides sont accessibles aux structures de santé pour renforcer leur sécurité IT. Opportunité de cofinancement complémentaire.

### Numérique en Santé — Espace Numérique de Santé (ENS)
Le gouvernement pousse l'interopérabilité des SI de santé. L'architecture MediLink devra prévoir à moyen terme des API compatibles (Mon Espace Santé, DMP).

---

## E — Économique · Impact Élevé

**Orientation : Opportunité + Contrainte**

### Aides désert médical — réduction significative du CAPEX
L'implantation en zone désert médical permet de mobiliser ~15 000 EUR de subventions, ramenant le CAPEX brut de ~48 330 EUR à ~**33 330 EUR net**. C'est un avantage décisif par rapport à un cabinet urbain.

### Stack open source — économie >30 000 EUR/an
La combinaison pfSense + Wazuh + Zabbix + Passbolt + Nginx + MySQL + UrBackup permet d'éviter plus de **30 000 EUR/an** de licences propriétaires (Cisco ASA, Splunk SIEM, Veeam Backup, CyberArk PAM).

### Technicien AIS — investissement rentable
Le recrutement d'un technicien AIS dédié (~42 000 EUR/an chargé) est plus économique qu'un MSP externe (~65 000 EUR/an) pour une structure de 23 utilisateurs avec données de santé sensibles. Il garantit aussi la réactivité et la connaissance du contexte réglementaire santé.

### AWS S3 — coût marginal
La sauvegarde externe hors site (ML-AWS-BACKUPCOPY-01) ne coûte que **~120 EUR/an** pour ~500 Go chiffrés — un coût négligeable au regard de la protection apportée (règle 3-2-1, sinistre physique).

### Inflation matérielle post-COVID
Les prix des serveurs et équipements réseau ont augmenté de 20 à 40% depuis 2020. Le CAPEX est ajusté en conséquence — la virtualisation (13 VMs sur 2 serveurs physiques) limite l'impact.

---

## S — Social · Impact Très Élevé

**Orientation : Opportunité forte**

### Désert médical — impact social majeur
Un cabinet pluridisciplinaire en zone désert médical répond à un besoin social critique : l'accès aux soins pour des populations isolées. Avec **8 spécialités** (Médecine Générale, Pédiatrie, Gynécologie, Kinésithérapie, Podologie, Chirurgie Dentaire, Ophtalmologie, Laboratoire), MediLink offre une prise en charge complète sans obliger les patients à se déplacer en zone urbaine.

### Confiance patient et conformité RGPD
Les patients sont de plus en plus sensibles à la protection de leurs données de santé. Un cabinet capable de prouver sa conformité RGPD (registre Art.30, chiffrement, journalisation Wazuh) dispose d'un **avantage concurrentiel réel**. L'infrastructure MediLink est conçue pour cette transparence.

### Télémédecine — essor post-COVID
Le recours aux consultations à distance a triplé depuis 2020. L'architecture VPN MFA + jumpboxes de MediLink permet aux praticiens d'accéder aux dossiers patients à distance de manière sécurisée — directement alignée avec les besoins de télémédecine en zone rurale.

### Formation des praticiens
Avec 17 praticiens de spécialités variées et des profils techniques hétérogènes, la **formation utilisateurs** est un investissement obligatoire. Le technicien AIS en est le garant au quotidien (support, VPN, Passbolt, postes).

### Réputation et confiance institutionnelle
Une violation de données de santé a des conséquences réputationnelles sévères — particulièrement critique pour un cabinet en désert médical où la **confiance de la communauté locale** est le premier vecteur de patientèle.

---

## T — Technologique · Impact Très Élevé

**Orientation : Menace + Opportunité**

### Ransomwares ciblant la santé
+78% entre 2022 et 2024 (Sophos State of Ransomware 2024). Les cabinets médicaux sont des cibles privilégiées. Le SIEM Wazuh + la segmentation VLAN + les sauvegardes chiffrées (UrBackup + AWS S3) constituent une réponse multicouche argumentée.

### Zero Trust Architecture
La tendance de fond en cybersécurité : ne jamais faire confiance implicitement, même en réseau interne. La segmentation en 9 VLANs, les jumpboxes obligatoires, le VPN MFA et Passbolt de MediLink sont **parfaitement alignés** avec ce paradigme.

### AWS S3 — hybridation cloud maîtrisée
L'intégration d'AWS S3 (ML-AWS-BACKUPCOPY-01) pour la sauvegarde externe démontre une **approche hybride on-premise/cloud** maîtrisée — critère Innovation/Créativité du jury. Données chiffrées AES-256, région Paris (eu-west-3), conformité RGPD garantie.

### Intelligence artificielle générative
Nouveaux vecteurs d'attaque : deepfakes, phishing ultra-ciblé, injection sur outils IA médicaux. L'architecture MediLink devra intégrer ces menaces dans sa politique de sécurité à moyen terme.

### WireGuard — évolution d'OpenVPN
Protocole VPN plus rapide et moderne, déjà intégré dans pfSense. Migration envisageable à moyen terme sans changer l'architecture globale.

---

## E — Environnemental · Impact Faible

**Orientation : Neutre**

### Virtualisation = sobriété numérique
13 VMs sur 2 serveurs physiques — bien meilleure utilisation des ressources vs 13 serveurs dédiés. Conforme aux recommandations du référentiel Green IT (GR491).

### Consommation électrique
~550 W en fonctionnement continu (serveurs, switches, onduleurs). À optimiser via équipements certifiés 80 Plus / Energy Star et gestion de l'alimentation des VMs inactives.

### AWS S3 — empreinte carbone cloud
AWS s'engage sur 100% d'énergie renouvelable d'ici 2025. La région eu-west-3 Paris bénéficie du mix électrique français (majoritairement nucléaire — faible empreinte carbone).

### DEEE (Directive 2012/19/UE)
Le matériel informatique en fin de vie doit être remis à des filières agréées. À intégrer dans le contrat de maintenance avec le prestataire IT / technicien AIS.

---

## L — Légal · Impact Critique

**Orientation : Contrainte forte**

### RGPD (UE 2016/679) — Article 9
Les données de santé sont une **catégorie spéciale** nécessitant des mesures de protection renforcées. MediLink y répond par : chiffrement TLS 1.3 en transit, segmentation VLAN, contrôle d'accès AD, journalisation Wazuh, registre des traitements Art.30 documenté (6 traitements).

### Loi HDS (L.1111-8 Code de santé publique)
Tout hébergement de données de santé **hors locaux de l'établissement** doit être réalisé chez un hébergeur certifié HDS. Le choix **on-premise** de MediLink écarte cette obligation coûteuse (~2 400 EUR/an).

> **Point AWS S3 :** les sauvegardes vers AWS S3 sont des **copies chiffrées** (AES-256 côté client). AWS ne peut pas lire les données. La certification HDS n'est pas requise pour des copies chiffrées de sauvegarde — à confirmer avec un juriste spécialisé en droit de la santé.

### PGSSI-S (ANSSI/ANS)
Référentiel technique de sécurité spécifique aux SI de santé. L'architecture MediLink en respecte les grandes lignes : cloisonnement, authentification forte, supervision, sauvegarde.

### NIS2 transposée (2024)
Les établissements de santé entrent dans le périmètre des **entités essentielles**. Le technicien AIS est le garant de la conformité NIS2 au quotidien : gestion des risques, tests, notification ANSSI.

### Responsabilité du technicien AIS
Le technicien AIS est responsable opérationnel de la sécurité du SI. Il doit être informé des obligations légales (RGPD, NIS2, PGSSI-S) et disposer d'une formation en cybersécurité santé.

---

## Synthèse et recommandations stratégiques

### 1. Le désert médical est un catalyseur, pas un frein
L'implantation en zone sous-dotée génère des **aides financières significatives** (~15 000 EUR) et renforce la légitimité sociale du projet. C'est un avantage compétitif fort pour le dossier jury.

### 2. La stack open source est le bon choix économique ET stratégique
Économie de >30 000 EUR/an en licences · conformité RGPD native · scalabilité sans surcoût · indépendance des éditeurs. Le technicien AIS en est le garant technique au quotidien.

### 3. L'approche hybride on-premise + AWS S3 répond aux exigences modernes
On-premise pour la souveraineté des données et la conformité HDS · AWS S3 pour la résilience hors site (règle 3-2-1) · coût marginal de ~120 EUR/an · critère Innovation/Créativité du jury coché.

### 4. Le cadre légal est non négociable
RGPD, HDS, NIS2 et PGSSI-S structurent toutes les décisions architecturales. Chaque choix technique de MediLink est justifié par une exigence réglementaire.

---

*MediLink — Cabinet Médical Pluridisciplinaire fictif · Jedha Bootcamp 2025 · Confidentiel équipe*
