# MediLink — Infrastructure IT · Cabinet Médical fictif

> **Jedha Bootcamp 2025 — Projet Final**  
> Infrastructure IT sécurisée simulant les besoins d'un cabinet médical  
> Durée : 10 jours · Démarrage : 23 mars 2026

---

## Équipe

| Équipier | Rôle | Périmètre |
|----------|------|-----------|
| **Mohamed** | Infrastructure & Réseau | GNS3 · pfSense · Switch · AD · Jumpbox |
| **Eric** | Sécurité & Accès | OpenVPN · MFA · Wazuh · Pentest accès |
| **Eddy** | Chef de projet technique | Nginx · Passbolt · Doc · Slides Démo Day |
| **Cheima** | BDD · Fichiers · Backup | MySQL · File Server · UrBackup |
| **Emilien** | Monitoring & Pentest réseau | Zabbix · Wazuh (binôme) · Pentest réseau |

---

## Liens rapides

- 📋 [Kanban Notion](https://www.notion.so/8b984243247c411783483b382120f95a?v=5c4355ca51074d87b19f4ea7398cd7a2)
- 🗂️ [Documentation technique](./docs/architecture/)
- 🔐 [Registre RGPD](./docs/rgpd/)
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
| Sauvegarde | UrBackup + Backup Storage | Sauvegardes auto chiffrées |
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

| Jours | Phase | Focus |
|-------|-------|-------|
| J1–J5 | Build | Déploiement de toute l'infrastructure |
| J6–J8 | Pentest | Tests d'intrusion · Corrections · Rapport |
| J9–J10 | Présentation | Répétitions · Démo live · Jury |

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
