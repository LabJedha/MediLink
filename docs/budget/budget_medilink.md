# Estimation Budgétaire — Infrastructure IT MediLink

> **Cabinet Médical Pluridisciplinaire — Zone Désert Médical**  
> 8 spécialités · 17 praticiens · 3 infirmiers · Infrastructure IT sécurisée on-premise  
> Jedha Bootcamp 2025 — Projet Final  
> Version : v2.0 · 26 mars 2026

---

## Indicateurs clés

| Indicateur | Valeur |
|------------|--------|
| **CAPEX initial brut** | ~44 200 EUR HT |
| **Aides désert médical estimées** | ~15 000 EUR |
| **CAPEX net après aides** | ~29 200 EUR HT |
| **OPEX annuel** | ~33 800 EUR/an |
| **TCO 3 ans** | ~130 600 EUR HT |
| **Par praticien/mois** | ~214 EUR/praticien/mois |

---

## 1. Contexte et hypothèses

| Élément | Détail |
|---------|--------|
| Type de structure | Cabinet médical pluridisciplinaire fictif — zone désert médical |
| Localisation | Zone sous-dotée en offre de soins (désert médical) |
| Spécialités | Médecine Générale · Pédiatrie · Gynécologie/Sage-femme · Kinésithérapie · Podologie · Chirurgie Dentaire · Orthodontie · Ophtalmologie · Laboratoire |
| Praticiens | 17 (médecins + spécialistes) |
| Infirmiers | 3 |
| Secrétariat | 3 postes administratifs |
| **Total utilisateurs** | **23 personnes** |
| Infrastructure | On-premise + sauvegarde externe AWS S3 |
| Cadre réglementaire | RGPD Art. 9 · ANSSI · HDS (on-premise → non soumis) · NIS2 |
| Amortissement matériel | 5 ans |
| TJM prestataire IT | 500 EUR/jour |

---

## 2. Aides financières — Zone Désert Médical

Le cabinet étant implanté en zone désert médical, plusieurs dispositifs de financement sont mobilisables :

| Dispositif | Organisme | Montant estimé | Conditions |
|-----------|-----------|---------------|------------|
| Aide à l'installation en zone sous-dotée | ARS (Agence Régionale de Santé) | 3 000 – 5 000 EUR | Zone déficitaire classifiée |
| Subvention numérique santé | Conseil Régional | 4 000 – 6 000 EUR | Projet numérique structurant |
| Aide à l'équipement | Conseil Départemental | 2 000 – 4 000 EUR | Cabinet pluridisciplinaire |
| DETR (Dotation Équipement Territoires Ruraux) | Mairie / Préfecture | 2 000 – 3 000 EUR | Zone rurale / semi-rurale |
| **Total aides estimées** | | **~11 000 – 18 000 EUR** | |
| **Retenu (hypothèse conservative)** | | **~15 000 EUR** | |

> Ces aides réduisent directement le CAPEX net. Les montants sont des estimations — chaque dossier est instruit individuellement par les organismes concernés.

---

## 3. CAPEX — Investissement initial

### 3.1 Matériel infrastructure

| Équipement | Spécifications | Prix unit. | Qté | Total HT |
|-----------|---------------|-----------|-----|---------|
| Serveur rack principal | Dell PowerEdge R550 — 128 Go RAM — 2x 2 To SSD NVMe | 5 200 EUR | 1 | 5 200 EUR |
| Serveur secondaire / backup | Dell PowerEdge R350 — 32 Go RAM — 4 To HDD | 2 800 EUR | 1 | 2 800 EUR |
| Pare-feu physique | Netgate 4100 (pfSense Plus) — 4 ports GbE | 780 EUR | 1 | 780 EUR |
| Switch manageable L2 24 ports | Cisco CBS350-24T — VLANs 802.1Q — PoE+ | 650 EUR | 1 | 650 EUR |
| Points d'accès WiFi pro | UniFi U6-Pro — WiFi 6 — multi-SSID/VLAN | 180 EUR | 3 | 540 EUR |
| NAS dédié backup | Synology RS1221+ — 4x 6 To (RAID 5) | 1 900 EUR | 1 | 1 900 EUR |
| Baie réseau 12U | Rack fermé + PDU + ventilation active | 480 EUR | 1 | 480 EUR |
| Onduleur (UPS) | APC Smart-UPS 1500VA — 20 min autonomie | 420 EUR | 2 | 840 EUR |
| Câblage réseau Cat6A | Patch panel + câbles + prises murales | 800 EUR | forfait | 800 EUR |
| **Sous-total matériel** | | | | **13 990 EUR** |

### 3.2 Postes utilisateurs

| Poste | Spécifications | Prix unit. | Qté | Total HT |
|-------|---------------|-----------|-----|---------|
| Postes praticiens | Dell OptiPlex 3000 — 16 Go — SSD 256 Go — Win 11 Pro | 780 EUR | 17 | 13 260 EUR |
| Postes infirmiers | Dell OptiPlex 3000 — 16 Go — SSD 256 Go — Win 11 Pro | 780 EUR | 3 | 2 340 EUR |
| Postes secrétariat | Dell OptiPlex 3000 — 16 Go — SSD 256 Go — Win 11 Pro | 780 EUR | 3 | 2 340 EUR |
| **Sous-total postes** | | | **23 postes** | **17 940 EUR** |

### 3.3 Licences logicielles

| Logiciel | Édition | Coût | Statut |
|---------|---------|------|--------|
| Windows Server 2022 Standard x2 | AD-01 + AD-02 — 16 core inclus | 1 800 EUR | Requis |
| Windows 11 Pro (si non OEM) | 23 postes — si non inclus matériel | 4 600 EUR | Requis |
| pfSense CE | Community Edition | 0 EUR | Gratuit |
| Wazuh SIEM | Open Source — agents illimités | 0 EUR | Gratuit |
| Zabbix | Open Source — hôtes illimités | 0 EUR | Gratuit |
| Passbolt CE | Community Edition | 0 EUR | Gratuit |
| Nginx + MySQL + Samba + UrBackup | Open Source | 0 EUR | Gratuit |
| Certificat TLS | Let's Encrypt — renouvellement auto | 0 EUR | Gratuit |
| **Sous-total licences** | | **~6 400 EUR** | |

### 3.4 Déploiement et intégration

| Prestation | Contenu | Durée | Coût HT |
|-----------|---------|-------|---------|
| Audit et conception architecture | Schéma réseau, plan IP, politique sécurité, RGPD | 3 j | 1 500 EUR |
| Installation infrastructure réseau | Rack, câblage, switch VLANs, pfSense, règles pare-feu | 3 j | 1 500 EUR |
| Déploiement serveurs et VMs | Hyperviseur, AD x2, fichiers Samba, backup UrBackup, monitoring | 4 j | 2 000 EUR |
| Sécurité et accès distants | OpenVPN MFA, Passbolt, jumpboxes, durcissement OS | 2 j | 1 000 EUR |
| Serveur web et base de données | Nginx HTTPS, MySQL, phpMyAdmin, intégration AD | 1 j | 500 EUR |
| Configuration AWS S3 | Bucket S3, IAM Role, chiffrement AES-256, lifecycle policy | 1 j | 500 EUR |
| Tests et recette | Pentest interne, tests VLAN, validation RGPD | 2 j | 1 000 EUR |
| Formation utilisateurs | VPN, Passbolt, postes — 23 utilisateurs | 2 j | 1 000 EUR |
| Documentation technique | PRA/PCA, procédures, registre RGPD Art.30 | 2 j | 1 000 EUR |
| **Sous-total déploiement** | | **20 j** | **10 000 EUR** |

### 3.5 Récapitulatif CAPEX

| Poste | Montant HT |
|-------|-----------|
| Matériel infrastructure | 13 990 EUR |
| Postes utilisateurs (23) | 17 940 EUR |
| Licences logicielles | 6 400 EUR |
| Déploiement et intégration | 10 000 EUR |
| **CAPEX BRUT TOTAL** | **48 330 EUR HT** |
| Aides désert médical (estimées) | - 15 000 EUR |
| **CAPEX NET APRÈS AIDES** | **~33 330 EUR HT** |
| Amortissement annuel (5 ans) | ~6 666 EUR/an |

---

## 4. OPEX — Coûts récurrents annuels

### 4.1 Ressources humaines

| Poste | Détail | Coût annuel |
|-------|--------|------------|
| **Technicien AIS (Admin IT Santé)** | **CDI temps plein — administration système, réseau, sécurité, RGPD, support 23 utilisateurs** | **~32 000 EUR/an** (salaire brut chargé ~42 000 EUR) |
| Astreinte et interventions urgentes | Incidents critiques hors contrat | ~1 000 EUR |

> **Justification du technicien AIS :** avec 23 utilisateurs, 17 praticiens, 8 spécialités, des données de santé sensibles (Art. 9 RGPD) et une infrastructure de 13 VMs + AWS S3, un technicien dédié est indispensable. Il gère : Active Directory, VPN, Passbolt, Wazuh, Zabbix, sauvegardes, conformité RGPD et support quotidien. Le coût est largement justifié par rapport à un prestataire externe (~6 000 EUR/an) qui ne peut pas assurer la réactivité nécessaire pour un cabinet médical.

### 4.2 Licences et abonnements

| Poste | Détail | Coût annuel |
|-------|--------|------------|
| Microsoft 365 Business Basic | Email pro + Teams — 23 utilisateurs × 5 EUR/mois | ~1 380 EUR |
| Antivirus endpoints | ESET Protect Entry — 23 postes | ~690 EUR |
| Domaine web + certificat | Registrar + Let's Encrypt | ~15 EUR |

### 4.3 Infrastructure et connectivité

| Poste | Détail | Coût annuel |
|-------|--------|------------|
| Connexion Internet Pro (fibre) | 1 Gb symétrique + SLA 4h + IP fixe | ~1 800 EUR |
| Ligne de secours 4G/5G | Failover automatique pfSense | ~360 EUR |
| **AWS S3 ML-AWS-BACKUPCOPY-01** | Bucket S3 eu-west-3 Paris · ~500 Go · chiffré · lifecycle 30j | **~120 EUR/an** |

### 4.4 Conformité et sécurité

| Poste | Détail | Coût annuel |
|-------|--------|------------|
| Audit de sécurité annuel | Pentest externe + rapport RGPD | ~3 000 EUR |
| Assurance cyber | Couverture incidents de sécurité | ~1 200 EUR |

### 4.5 Maintenance matériel

| Poste | Détail | Coût annuel |
|-------|--------|------------|
| Contrat support serveurs | Dell ProSupport Plus — intervention J+1 | ~800 EUR |
| Renouvellement consommables | Disques, câbles, petits équipements | ~400 EUR |

### 4.6 Récapitulatif OPEX

| Poste | Montant annuel |
|-------|---------------|
| Technicien AIS (salaire brut chargé) | 42 000 EUR |
| Astreinte / interventions urgentes | 1 000 EUR |
| Microsoft 365 (23 utilisateurs) | 1 380 EUR |
| Antivirus endpoints (23 postes) | 690 EUR |
| Domaine + certificat | 15 EUR |
| Internet Pro + failover 4G | 2 160 EUR |
| AWS S3 ML-AWS-BACKUPCOPY-01 | 120 EUR |
| Audit sécurité annuel | 3 000 EUR |
| Assurance cyber | 1 200 EUR |
| Maintenance matériel | 1 200 EUR |
| **TOTAL OPEX ANNUEL** | **~52 765 EUR/an** |

---

## 5. TCO — Coût total de possession sur 3 ans

| Année | Poste | Montant |
|-------|-------|---------|
| Année 0 | CAPEX net après aides | 33 330 EUR |
| Année 1 | OPEX | 52 765 EUR |
| Année 2 | OPEX | 52 765 EUR |
| Année 3 | OPEX | 52 765 EUR |
| **TCO TOTAL 3 ANS** | | **~191 625 EUR HT** |
| Coût mensuel moyen lissé | | ~5 323 EUR/mois |
| **Par praticien/mois (17)** | | **~261 EUR/praticien/mois** |
| Par utilisateur/mois (23) | | ~193 EUR/utilisateur/mois |
| Amortissement CAPEX (5 ans) | | ~6 666 EUR/an |

---

## 6. Économie réalisée — Stack open source

| Solution | Coût annuel | Commentaire |
|---------|------------|-------------|
| **Stack MediLink (notre projet)** | **~52 765 EUR/an** | Open source + technicien AIS interne |
| Stack propriétaire équivalente | ~85 000 EUR/an | Cisco + Splunk + Veeam + CyberArk + licences |
| MSP externalisé complet | ~65 000 EUR/an | Infogérance totale ESN — SLA garanti |
| SaaS médical certifié HDS | ~45 000 EUR/an | Clé en main mais dépendance éditeur |

**Économie vs stack propriétaire : ~32 000 EUR/an** grâce à la stack 100% open source (pfSense, Wazuh, Zabbix, Nginx, MySQL, Passbolt, UrBackup).

---

## 7. Points clés pour le jury

| Argument | Détail |
|---------|--------|
| **Stack 100% open source** | Économie >30 000 EUR/an vs équivalents propriétaires |
| **Aides désert médical** | ~15 000 EUR de subventions mobilisables — CAPEX net réduit |
| **Technicien AIS dédié** | Indispensable pour 23 utilisateurs + données de santé Art.9 RGPD |
| **AWS S3 hors site** | Règle 3-2-1 · données en UE (eu-west-3 Paris) · ~10 EUR/mois seulement |
| **RGPD natif** | Architecture conçue dès le départ pour la conformité — pas un ajout |
| **Scalabilité** | Hyperviseur + outils open source — ajout de VMs sans surcoût licence |
| **Rentabilisé en** | ~18 mois vs cloud équivalent |

---

## 8. Personnel — Récapitulatif

| Rôle | Personnes | VLAN | Postes |
|------|-----------|------|--------|
| Médecins / Spécialistes | 17 | 30 (WiFi Interne) | 17 postes |
| Infirmiers | 3 | 30 (WiFi Interne) | 3 postes |
| Secrétariat | 3 | 40 (Administratif) | 3 postes |
| **Technicien AIS** | **1** | **10 (Admin IT)** | **1 poste + accès complet** |
| **Total** | **24** | | **24 postes** |

---

*MediLink — Cabinet Médical Pluridisciplinaire fictif · Jedha Bootcamp 2025 · Confidentiel équipe*
