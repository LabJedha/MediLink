# Documentation Technique — Architecture MediLink

> **Jedha Bootcamp 2025 — Projet Final**  
> Infrastructure IT — Cabinet Médical fictif  
> Dernière mise à jour : J4 · 26 mars 2026

---

## Sommaire

1. [Vue d'ensemble](#1-vue-densemble)
2. [Segmentation réseau — 7 VLANs](#2-segmentation-réseau--7-vlans)
3. [Machines déployées](#3-machines-déployées)
4. [Règles inter-VLANs pfSense](#4-règles-inter-vlans-pfsense)
5. [Accès SSH — Procédure jumpbox](#5-accès-ssh--procédure-jumpbox)
6. [Flux réseau autorisés](#6-flux-réseau-autorisés)

---

## 1. Vue d'ensemble

L'infrastructure MediLink simule le réseau informatique d'un cabinet médical fictif.  
Elle est hébergée sur une VM Jedha (40 Go RAM / 8 vCPU / 230 Go) via GNS3 + VirtualBox.

```
Internet (WAN)
      │
      ▼
ML-NET-FW-01 · pfSense (FreeBSD)
Firewall · NAT · VPN · Routage inter-VLANs
      │
      ▼
ML-NET-SW-01 · Cisco IOU L2
Switch · Trunk · Ports access par VLAN
      │
      ├── VLAN 10  · Admin IT
      ├── VLAN 20  · Serveurs
      ├── VLAN 30  · WiFi Interne (Médecins/Infirmiers)
      ├── VLAN 40  · Administratif (RH/Comptabilité)
      ├── VLAN 50  · DMZ (Web Server)
      ├── VLAN 60  · WiFi Guest (Patients)
      ├── VLAN 70  · Monitoring (Wazuh/Zabbix)
      ├── VLAN 222 · Management (SW-01 · SW-02 · Gateway · Équipements réseau)
      └── VLAN 999 · Parking (Ports inutilisés · Imprimantes · Non assignés)
```

---

## 2. Segmentation réseau — 7 VLANs

| VLAN | Nom | Réseau | Masque | Hôtes max | Usage |
|------|-----|--------|--------|-----------|-------|
| 10 | Admin IT | 192.168.10.0 | /28 | 14 | Jumpbox · Passbolt |
| 20 | Serveurs | 192.168.20.0 | /27 | 30 | AD · Fichiers · Backup |
| 30 | WiFi Interne | 192.168.30.0 | /26 | 62 | Médecins · Infirmiers |
| 40 | Administratif | 192.168.40.0 | /27 | 30 | RH · Comptabilité |
| 50 | DMZ | 192.168.50.0 | /29 | 6 | Nginx · MySQL |
| 60 | WiFi Guest | 192.168.60.0 | /26 | 62 | Patients · Internet only |
| 70 | Monitoring | 192.168.70.0 | /29 | 6 | Wazuh · Zabbix |
| 222 | Management | 192.168.222.0 | /28 | 14 | SW-01 (192.168.222.2) · SW-02 (192.168.222.1) · Gateway · Équipements réseau |
| 999 | Parking | — | — | — | Ports inutilisés · Imprimantes · Équipements non assignés |

**Principe de sécurité :** chaque VLAN est isolé par défaut. Le trafic inter-VLANs est filtré par des règles pfSense explicites. Tout ce qui n'est pas autorisé est bloqué.

---

## 3. Machines déployées

### ML-NET-FW-01 · pfSense
| Champ | Valeur |
|-------|--------|
| OS | FreeBSD (pfSense CE) |
| Rôle | Firewall · NAT · VPN · Routage inter-VLANs |
| VLAN | WAN + tous VLANs |
| Équipier | Mohamed |
| Services | pfSense WebUI (443) · OpenVPN (1194/UDP) |
| Ports ouverts | 443 (admin, VLAN 10 only) · 1194 UDP (VPN) |

---

### ML-NET-SW-01 · Cisco IOU L2
| Champ | Valeur |
|-------|--------|
| OS | Cisco IOU L2 (GNS3) |
| Rôle | Switch L2 · Trunk vers pfSense · Ports access par VLAN |
| Équipier | Mohamed |
| Config | 7 VLANs configurés · Port trunk vers ML-NET-FW-01 |

---

### ML-SRV-AD-01 · Active Directory Principal
| Champ | Valeur |
|-------|--------|
| OS | Windows Server 2022 |
| VLAN | 20 — Serveurs |
| IP | 192.168.20.10/27 |
| RAM | 4 Go |
| Équipier | Mohamed |
| Rôle | Contrôleur de domaine principal · DHCP · DNS |
| Domaine | cabinet.local |
| Services | AD DS · DNS (53) · DHCP (67/68) · LDAP (389) · LDAPS (636) |
| Ports ouverts | 53 · 67/68 · 88 · 135 · 389 · 445 · 636 · 3268 |

---

### ML-SRV-AD-02 · Active Directory Secondaire
| Champ | Valeur |
|-------|--------|
| OS | Windows Server 2022 |
| VLAN | 20 — Serveurs |
| IP | 192.168.20.11/27 |
| RAM | 4 Go |
| Équipier | Mohamed |
| Rôle | Contrôleur de domaine secondaire · Redondance AD |
| Services | AD DS · DNS · Réplication depuis AD-01 |

---

### ML-SRV-JUMP-01 · Jumpbox principale
| Champ | Valeur |
|-------|--------|
| OS | Ubuntu 22.04 Server |
| VLAN | 10 — Admin IT |
| IP | 192.168.10.10/28 |
| RAM | 1 Go |
| Équipier | Mohamed |
| Rôle | Point d'entrée SSH/RDP vers l'infrastructure |
| Services | SSH (22) |
| Accès | Via VPN OpenVPN uniquement · Utilisateur : admin_jump |
| Ports ouverts | 22 (SSH) — restreint aux admins VPN |

---

### ML-SRV-JUMP-02 · Jumpbox secondaire
| Champ | Valeur |
|-------|--------|
| OS | Ubuntu 22.04 Server |
| VLAN | 10 — Admin IT |
| IP | 192.168.10.11/28 |
| RAM | 1 Go |
| Équipier | Mohamed |
| Rôle | Jumpbox de secours / admin secondaire |
| Services | SSH (22) |

---

### ML-SRV-PASS-01 · Passbolt
| Champ | Valeur |
|-------|--------|
| OS | Ubuntu 22.04 Server |
| VLAN | 10 — Admin IT |
| IP | 192.168.10.12/28 |
| RAM | 1 Go |
| Équipier | Eddy |
| Rôle | Gestionnaire de mots de passe équipe IT |
| Domaine AD | cabinet.local (jointure realm) |
| Services | Passbolt CE · Nginx · MySQL · PHP-FPM |
| Ports ouverts | 443 (HTTPS Passbolt) — restreint VLAN 10 |
| URL | https://192.168.10.12 |

---

### ML-SRV-WEB-01 · Serveur Web
| Champ | Valeur |
|-------|--------|
| OS | Ubuntu 22.04 Server |
| VLAN | 50 — DMZ |
| IP | 192.168.50.2/29 |
| RAM | 2 Go |
| Équipier | Eddy + Cheima |
| Rôle | Site vitrine médical · Base de données patients |
| Services | Nginx · MySQL · phpMyAdmin · PHP-FPM |
| Ports ouverts | 80 (redirect → 443) · 443 (HTTPS) |
| URL | https://192.168.50.2 |
| phpMyAdmin | https://192.168.50.2/phpmyadmin — restreint VLAN 10 |
| TLS | Auto-signé · TLS 1.2/1.3 · Headers OWASP |
| Pages | index · dentiste · généraliste · gynéco · kiné · labo · ophtalmo · pédiatre · podologue |

---

### ML-SRV-FILE-01 · Serveur de fichiers
| Champ | Valeur |
|-------|--------|
| OS | Ubuntu 22.04 Server |
| VLAN | 20 — Serveurs |
| IP | 192.168.20.12/27 |
| RAM | 2 Go |
| Équipier | Cheima |
| Rôle | Partage de fichiers · Droits par rôle AD |
| Services | Samba |
| Ports ouverts | 445 (SMB) — restreint VLANs 30/40 |

---

### ML-SRV-URBACKUP-01 · Serveur de sauvegarde
| Champ | Valeur |
|-------|--------|
| OS | Ubuntu 22.04 Server |
| VLAN | 20 — Serveurs |
| IP | 192.168.20.13/27 |
| RAM | 2 Go |
| Équipier | Cheima |
| Rôle | Sauvegardes automatiques chiffrées |
| Services | UrBackup Server |
| Ports ouverts | 55414 (WebUI) · 55415 (backup) — restreint VLAN 10/20 |

---

### ML-SRV-BACKUP-01 · Stockage de sauvegarde
| Champ | Valeur |
|-------|--------|
| OS | Ubuntu 22.04 Server |
| VLAN | 20 — Serveurs |
| IP | 192.168.20.14/27 |
| RAM | 1 Go |
| Équipier | Cheima |
| Rôle | Repository cible des sauvegardes UrBackup |

---

### ML-SRV-WAZUH-01 · SIEM
| Champ | Valeur |
|-------|--------|
| OS | Ubuntu 22.04 Server |
| VLAN | 70 — Monitoring |
| IP | 192.168.70.3/29 |
| RAM | 4 Go |
| Équipier | Eric + Emilien |
| Rôle | SIEM · Détection d'intrusion · Journalisation |
| Services | Wazuh Manager · Wazuh Dashboard · Elasticsearch |
| Ports ouverts | 1514 (agents) · 1515 · 443 (dashboard) — restreint VLAN 10 |
| Agents | Déployés sur tous les serveurs |

---

### ML-SRV-ZABBIX-01 · Supervision réseau
| Champ | Valeur |
|-------|--------|
| OS | Ubuntu 22.04 Server |
| VLAN | 70 — Monitoring |
| IP | 192.168.70.2/29 |
| RAM | 2 Go |
| Équipier | Emilien |
| Rôle | Supervision réseau · Métriques · Alertes |
| Services | Zabbix Server · Zabbix Frontend · MySQL |
| Ports ouverts | 10051 (agents) · 443 (frontend) — restreint VLAN 10 |

---

## 4. Règles inter-VLANs pfSense

| Source | Destination | Port/Proto | Action | Justification |
|--------|-------------|-----------|--------|---------------|
| VLAN 10 (Admin) | Tous VLANs | Any | ✅ Autorisé | Admins IT accèdent à toute l'infra |
| VLAN 30 (Médecins) | VLAN 20 (Fichiers) | 445 SMB | ✅ Autorisé | Accès dossiers patients |
| VLAN 30 (Médecins) | VLAN 50 (DMZ) | 443 HTTPS | ✅ Autorisé | Accès portail web interne |
| VLAN 40 (Administratif) | VLAN 20 (Fichiers) | 445 SMB | ✅ Autorisé | Accès documents RH |
| VLAN 50 (DMZ) | VLAN 20 (Serveurs) | 3306 MySQL | ✅ Autorisé | Web → BDD patients |
| VLAN 60 (Guest) | Internet | 80/443 | ✅ Autorisé | Patients WiFi internet only |
| VLAN 60 (Guest) | Tous VLANs internes | Any | 🚫 Bloqué | Isolation totale patients |
| VLAN 70 (Monitoring) | Tous VLANs | 1514 | ✅ Autorisé | Collecte logs Wazuh |
| Tous VLANs | VLAN 70 | Any | 🚫 Bloqué | Monitoring isolé |
| WAN | VLAN 50 (DMZ) | 443 | ✅ Autorisé | Site web accessible depuis VPN |
| WAN | Tous VLANs internes | Any | 🚫 Bloqué | Pas d'accès direct depuis internet |

---

## 5. Accès SSH — Procédure jumpbox

L'accès à toute machine de l'infrastructure passe obligatoirement par la jumpbox.  
**Accès direct SSH depuis internet : interdit.**

```
[Admin] → OpenVPN (10.10.100.0/24) → ML-SRV-JUMP-01 (192.168.10.10) → Machine cible
```

**Étapes :**

```bash
# 1. Se connecter au VPN OpenVPN (Google Authenticator requis)
# Client OpenVPN configuré sur le poste admin

# 2. SSH vers la jumpbox
ssh admin_jump@192.168.10.10

# 3. Depuis la jumpbox, SSH vers la machine cible
ssh user@192.168.50.2      # ML-SRV-WEB-01
ssh user@192.168.10.12     # ML-SRV-PASS-01
ssh user@192.168.20.10     # ML-SRV-AD-01 (si besoin)
```

---

## 6. Flux réseau autorisés

```
Médecin (VLAN 30)
    │
    ├──→ VLAN 20 (Fichiers) · port 445 · dossiers patients
    └──→ VLAN 50 (DMZ)     · port 443 · portail web

Administratif (VLAN 40)
    └──→ VLAN 20 (Fichiers) · port 445 · documents RH

Admin IT (VLAN 10)
    └──→ Tous VLANs · accès complet

Patient WiFi (VLAN 60)
    └──→ Internet uniquement · VLANs internes bloqués

Monitoring (VLAN 70)
    └──→ Reçoit les logs de tous les VLANs (agents Wazuh)
```

---

*MediLink — Cabinet Médical fictif · Jedha Bootcamp 2025 · Confidentiel équipe*
