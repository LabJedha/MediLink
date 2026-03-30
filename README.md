# MediLink — Infrastructure IT · Cabinet Médical fictif 

> **Jedha Bootcamp 2025 — Projet Final**  
> Infrastructure IT sécurisée adaptée aux besoins d’un cabinet médical en zone désertifiée
> 
> Durée : 10 jours · Démarrage : 23 mars 2026
> Gestion du contenu GitHub : Eddy GASSAB

---

## Équipe

| Équipier | Rôle | Périmètre |
|----------|------|-----------|
| **Mohamed SOUAFI** | Infrastructure & Réseau | GNS3 · pfSense · Switch · AD · Jumpbox · OpenVPN|
| **Eric GAYMARD** | Sécurité & Accès | OpenVPN · MFA · Wazuh · Pentest accès · Doc EN |
| **Eddy GASSAB** | Chef de projet technique | Nginx · Passbolt · Doc · Site Web · Slides Démo Day |
| **Cheima ANICHE** | BDD · Fichiers · Backup | MySQL · File Server · UrBackup |
| **Emilien SIEUDAT** | Monitoring & Pentest réseau | Zabbix · Pentest réseau · Doc EN |

---

## Liens rapides

- 📋 [Kanban Notion](https://www.notion.so/8b984243247c411783483b382120f95a?v=5c4355ca51074d87b19f4ea7398cd7a2)
- 🗂️ [Documentation technique](./docs/architecture/)
- 🔬 [Rapport de veille technologique (EN)](./docs/veille/veille_technologique.md)
- 🔐 [Registre RGPD](./docs/rgpd/)
- 💰 [Estimation budgétaire](./docs/budget/budget_medilink.md)
- 📊 [Analyse PESTEL](./docs/pestel/pestel_medilink.md)
- 🌐 [Site vitrine MediLink](https://labjedha.github.io/MediLink/site/)
- 🔍 [Rapport de pentest](./docs/pentest/)
- 🎤 [Slides Démo Day](./presentations/demo-day/)

---

## Contexte du projet

Le projet MediLink simule l'infrastructure IT d'un cabinet médical fictif.  
Les contraintes sont volontairement fortes : données de santé (Article 9 RGPD), segmentation réseau avancée, authentification multi-facteurs, traçabilité des accès.

**Objectif :** déployer, sécuriser et documenter une infrastructure complète, puis la présenter devant un jury.

---

## Architecture — Vue d'ensemble

```
Internet (WAN)
    │
    ▼
ML-NET-FW-01 · pfSense (FreeBSD) — Firewall · NAT · VPN
    │
    ▼
ML-NET-SW-01 · Cisco IOU L2 — Switch · Routage inter-VLANs
    │
    ├── VLAN 10  · Admin IT      · 192.168.10.0/28  · Jumpbox x2 · Passbolt
    ├── VLAN 20  · Serveurs      · 192.168.20.0/27  · AD x2 · Fichiers · Backup
    ├── VLAN 30  · WiFi Interne  · 192.168.30.0/26  · Médecins · Infirmiers
    ├── VLAN 40  · Administratif · 192.168.40.0/27  · RH · Comptabilité
    ├── VLAN 50  · DMZ           · 192.168.50.0/29  · Nginx · MySQL
    ├── VLAN 60  · WiFi Guest    · 192.168.60.0/26  · Patients (Internet only)
    ├── VLAN 70  · Monitoring    · 192.168.70.0/29  · Wazuh · Zabbix
    ├── VLAN 222 · Management    · 192.168.222.0/28 · SW-01 · SW-02 · Gateway · Équipements réseau
    └── VLAN 999 · Parking       · —                · Ports inutilisés · Imprimantes · Non assignés

☁️  AWS S3 (hors site) — Sauvegarde externe chiffrée · Règle 3-2-1 · Fictif / sur plan
```

---

## Machines déployées

| # | Machine | OS | VLAN | IP | RAM | Équipier |
|---|---------|----|----|-----|-----|----------|
| 1 | ML-NET-FW-01 | FreeBSD (pfSense) | — | — | 512 Mo | Mohamed |
| 2 | ML-NET-SW-01 | Cisco IOU L2 | — | — | 256 Mo | Mohamed |
| 3 | ML-SRV-AD-01 | Windows Server 2022 | 20 | 192.168.20.10/27 | 4 Go | Mohamed |
| 4 | ML-SRV-AD-02 | Windows Server 2022 | 20 | 192.168.20.11/27 | 4 Go | Mohamed |
| 5 | ML-SRV-JUMP-01 | Ubuntu 22.04 | 10 | 192.168.10.10/28 | 1 Go | Mohamed |
| 6 | ML-SRV-JUMP-02 | Ubuntu 22.04 | 10 | 192.168.10.11/28 | 1 Go | Mohamed |
| 7 | ML-SRV-PASS-01 | Ubuntu 22.04 | 10 | 192.168.10.12/28 | 1 Go | **Eddy** |
| 8 | ML-SRV-WEB-01 | Ubuntu 22.04 | 50 | 192.168.50.2/29 | 2 Go | **Eddy + Cheima** |
| 9 | ML-SRV-FILE-01 | Ubuntu 22.04 | 20 | 192.168.20.12/27 | 2 Go | Cheima |
| 10 | ML-SRV-URBACKUP-01 | Ubuntu 22.04 | 20 | 192.168.20.13/27 | 2 Go | Cheima |
| 11 | ML-SRV-BACKUP-01 | Ubuntu 22.04 | 20 | 192.168.20.14/27 | 1 Go | Cheima |
| 12 | ML-SRV-WAZUH-01 | Ubuntu 22.04 | 70 | 192.168.70.3/29 | 4 Go | Eric + Emilien |
| 13 | ML-SRV-ZABBIX-01 | Ubuntu 22.04 | 70 | 192.168.70.2/29 | 2 Go | Emilien |
| ☁️ | ML-AWS-BACKUPCOPY-01 | AWS S3 | Cloud | Elastic IP publique AWS | — | Cheima |

**Total RAM utilisée :** ~26.5 Go · VM Jedha : 40 Go RAM / 8 vCPU / 230 Go stockage

> **Mise à jour J4 :** VLAN 222 Management (192.168.222.0/28) et VLAN 999 Parking ajoutés par Mohamed.

---

## Stack technique

| Catégorie | Outil | Rôle |
|-----------|-------|------|
| Réseau / Pare-feu | pfSense | Firewall · VLANs · NAT · VPN |
| Switch | Cisco IOU L2 (GNS3) | Routage inter-VLANs |
| Annuaire | Windows Server AD x2 | Authentification · DHCP · DNS · GPO |
| Accès sécurisé | Jumpbox x2 + Passbolt | SSH/RDP isolé · Gestionnaire MDP |
| VPN | OpenVPN + MFA | Accès distant · Google Authenticator |
| Web | Nginx + TLS | Site vitrine médical · VLAN 50 DMZ |
| Base de données | MySQL + phpMyAdmin | Données patients · Interface admin |
| Fichiers | Samba / File Server | Partage de documents · Droits AD |
| Sauvegarde | UrBackup + Backup Storage | Sauvegardes auto chiffrées · Local |
| Sauvegarde hors site | AWS S3 (fictif) | Sauvegarde externe chiffrée · Règle 3-2-1 |
| SIEM | Wazuh | Détection d'intrusion · Journalisation |
| Monitoring | Zabbix | Supervision réseau · Métriques |
| DevOps | Git + GitHub | Versionnage configs et scripts |
| Gestion projet | Notion (Kanban) | Suivi des tâches · Documentation |

---

## Structure du repo

```
MediLink/
├── README.md
├── docs/
│   ├── architecture/       # Schémas réseau · draw.io
│   ├── rgpd/               # Registre des traitements RGPD
│   ├── pentest/            # Rapport pentest (J7-J8)
│   └── procedures/         # Procédures techniques (SSH, VPN, Passbolt)
├── configs/
│   ├── pfsense/            # Règles pfSense (Mohamed)
│   ├── switch/             # Config Cisco IOU (Mohamed)
│   ├── nginx/              # Config Nginx (Eddy)
│   ├── passbolt/           # Config Passbolt (Eddy)
│   ├── ad/                 # GPO + scripts AD (Mohamed)
│   ├── wazuh/              # Config Wazuh (Eric)
│   └── zabbix/             # Config Zabbix (Emilien)
├── scripts/
│   └── setup/              # Scripts d'installation
└── presentations/
    └── demo-day/           # Slides Démo Day (Eddy)
```

---

## Planning

| Jours | Phase | Équipier | Focus |
|-------|-------|----------|-------|
| J1 | Build | Mohamed | Switch Cisco IOU · 7 VLANs · pfSense début |
| J1 | Build | Eddy | Repo GitHub · Kanban Notion · Ubuntu ML-SRV-WEB-01 |
| J2 | Build | Mohamed | pfSense règles · OpenVPN (binôme Eric) · AD-01 |
| J2 | Build | Eddy | Nginx · HTTPS · Site vitrine · MySQL (binôme Cheima) |
| J2 | Build | Cheima | MySQL · phpMyAdmin · File Server |
| J2 | Build | Eric | OpenVPN + MFA (binôme Mohamed) |
| J2 | Build | Emilien | Zabbix installation |
| J3 | Build | Mohamed | AD-02 · Jumpbox x2 |
| J3 | Build | Eddy | Passbolt CE · Jointure AD · Doc v1 |
| J3 | Build | Cheima | UrBackup · Backup Storage |
| J3 | Build | Eric + Emilien | Wazuh SIEM · Agents |
| J4–J5 | Build | Eddy | Doc technique · RGPD · Slides début |
| J4–J5 | Build | Cheima | Tests intégration Web ↔ BDD |
| J4–J5 | Build | Mohamed | Tests réseau · Connectivité inter-VLANs · Documentation |
| J6–J8 | Pentest | Eric | Pentest accès · Bypass VPN · Authentification |
| J6–J8 | Pentest | Emilien | Pentest réseau · Nmap · VLANs · pfSense |
| J6–J8 | Pentest | Eddy | Rapport pentest consolidé |
| J9–J10 | Présentation | Toute l'équipe | Répétitions · Démo live · Jury |

---

## Conformité RGPD

Les données de santé traitées dans ce projet fictif sont des **données sensibles au sens de l'Article 9 du RGPD**.  
Mesures implémentées :
- Chiffrement en transit (TLS 1.2/1.3 sur tous les services exposés)
- Segmentation réseau (isolation VLAN 50 DMZ, VLAN 20 Serveurs)
- Contrôle d'accès par rôle (Active Directory + GPO)
- Journalisation des accès (Wazuh SIEM)
- Politique de sauvegarde chiffrée (UrBackup)
- Gestionnaire de mots de passe dédié (Passbolt)
- Registre des traitements documenté → [docs/rgpd/](./docs/rgpd/)

---

## Hébergement

VM Jedha · GNS3 + VirtualBox · Accès SSH via jumpbox ML-SRV-JUMP-01

---

*MediLink — Cabinet Médical fictif · Jedha Bootcamp 2025 · Confidentiel équipe*

