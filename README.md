Jedha Bootcamp 2025 — Projet Final
Infrastructure IT sécurisée simulant les besoins d'un cabinet médical
Durée : 10 jours · Démarrage : 23 mars 2026


Équipe
ÉquipierRôlePérimètreMohamedInfrastructure & RéseauGNS3 · pfSense · Switch · AD · JumpboxEricSécurité & AccèsOpenVPN · MFA · Wazuh · Pentest accèsEddyChef de projet techniqueNginx · Passbolt · Doc · Slides Démo DayCheimaBDD · Fichiers · BackupMySQL · File Server · UrBackupEmilienMonitoring & Pentest réseauZabbix · Wazuh (binôme) · Pentest réseau

Liens rapides

📋 Kanban Notion
🗂️ Documentation technique
🔐 Registre RGPD
🔍 Rapport de pentest
🎤 Slides Démo Day


Contexte du projet
Le projet MediLink simule l'infrastructure IT d'un cabinet médical fictif.
Les contraintes sont volontairement fortes : données de santé (Article 9 RGPD), segmentation réseau avancée, authentification multi-facteurs, traçabilité des accès.
Objectif : déployer, sécuriser et documenter une infrastructure complète, puis la présenter devant un jury.

Architecture — Vue d'ensemble
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
    └── VLAN 70  · Monitoring    · 192.168.70.0/29  · Wazuh · Zabbix

Machines déployées
#MachineOSVLANIPRAMÉquipier1ML-NET-FW-01FreeBSD (pfSense)——512 MoMohamed2ML-NET-SW-01Cisco IOU L2——256 MoMohamed3ML-SRV-AD-01Windows Server 202220192.168.20.10/274 GoMohamed4ML-SRV-AD-02Windows Server 202220192.168.20.11/274 GoMohamed5ML-SRV-JUMP-01Ubuntu 22.0410192.168.10.10/281 GoMohamed6ML-SRV-JUMP-02Ubuntu 22.0410192.168.10.11/281 GoMohamed7ML-SRV-PASS-01Ubuntu 22.0410192.168.10.12/281 GoEddy8ML-SRV-WEB-01Ubuntu 22.0450192.168.50.2/292 GoEddy + Cheima9ML-SRV-FILE-01Ubuntu 22.0420192.168.20.12/272 GoCheima10ML-SRV-URBACKUP-01Ubuntu 22.0420192.168.20.13/272 GoCheima11ML-SRV-BACKUP-01Ubuntu 22.0420192.168.20.14/271 GoCheima12ML-SRV-WAZUH-01Ubuntu 22.0470192.168.70.3/294 GoEric + Emilien13ML-SRV-ZABBIX-01Ubuntu 22.0470192.168.70.2/292 GoEmilien
Total RAM utilisée : ~26.5 Go · VM Jedha : 40 Go RAM / 8 vCPU / 230 Go stockage

Stack technique
CatégorieOutilRôleRéseau / Pare-feupfSenseFirewall · VLANs · NAT · VPNSwitchCisco IOU L2 (GNS3)Routage inter-VLANsAnnuaireWindows Server AD x2Authentification · DHCP · DNS · GPOAccès sécuriséJumpbox x2 + PassboltSSH/RDP isolé · Gestionnaire MDPVPNOpenVPN + MFAAccès distant · Google AuthenticatorWebNginx + TLSSite vitrine médical · VLAN 50 DMZBase de donnéesMySQL + phpMyAdminDonnées patients · Interface adminFichiersSamba / File ServerPartage de documents · Droits ADSauvegardeUrBackup + Backup StorageSauvegardes auto chiffréesSIEMWazuhDétection d'intrusion · JournalisationMonitoringZabbixSupervision réseau · MétriquesDevOpsGit + GitHubVersionnage configs et scriptsGestion projetNotion (Kanban)Suivi des tâches · Documentation

Structure du repo
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

Planning
JoursPhaseFocusJ1–J5BuildDéploiement de toute l'infrastructureJ6–J8PentestTests d'intrusion · Corrections · RapportJ9–J10PrésentationRépétitions · Démo live · Jury

Conformité RGPD
Les données de santé traitées dans ce projet fictif sont des données sensibles au sens de l'Article 9 du RGPD.
Mesures implémentées :

Chiffrement en transit (TLS 1.2/1.3 sur tous les services exposés)
Segmentation réseau (isolation VLAN 50 DMZ, VLAN 20 Serveurs)
Contrôle d'accès par rôle (Active Directory + GPO)
Journalisation des accès (Wazuh SIEM)
Politique de sauvegarde chiffrée (UrBackup)
Gestionnaire de mots de passe dédié (Passbolt)
Registre des traitements documenté → docs/rgpd/


Hébergement
VM Jedha · GNS3 + VirtualBox · Accès SSH via jumpbox ML-SRV-JUMP-01

MediLink — Cabinet Médical fictif · Jedha Bootcamp 2025 · Confidentiel équipe
