# Registre des activités de traitement — Cabinet Médical MediLink

> **Article 30 du Règlement Général sur la Protection des Données (RGPD)**  
> Jedha Bootcamp 2025 — Projet Final  
> Responsable du traitement : Cabinet Médical MediLink (fictif)  
> Dernière mise à jour : J4 · 26 mars 2026

---

## Informations générales

| Champ | Valeur |
|-------|--------|
| Organisme | Cabinet Médical MediLink (structure fictive) |
| Responsable du traitement | Directeur du cabinet |
| Délégué à la Protection des Données (DPO) | Équipe IT — Eddy (projet fictif) |
| Contact | support@cabinet.local |
| Base légale principale | Art. 6 et Art. 9 RGPD — Données de santé |

---

## Traitement 1 — Dossiers médicaux patients

| Champ | Détail |
|-------|--------|
| **Finalité** | Suivi médical et administratif des patients du cabinet |
| **Base légale** | Art. 9.2.h RGPD — Médecine préventive, diagnostic médical, soins |
| **Catégories de données** | Nom · Prénom · Date de naissance · Numéro de sécurité sociale · Données de santé (diagnostics, ordonnances, antécédents) |
| **Personnes concernées** | Patients du cabinet médical |
| **Destinataires** | Médecins du cabinet (selon spécialité) · Infirmiers (accès restreint) |
| **Transferts hors UE** | Aucun |
| **Durée de conservation** | 20 ans après le dernier acte médical (Art. R. 1112-7 Code de la santé publique) |
| **Mesures de sécurité** | Chiffrement en transit TLS 1.3 · Accès restreint par rôle AD (VLAN 30) · Authentification obligatoire · Journalisation des accès Wazuh · Sauvegarde chiffrée UrBackup |
| **Stockage** | ML-SRV-FILE-01 (VLAN 20) + ML-SRV-WEB-01 base MySQL (VLAN 50) |
| **Risques identifiés** | Accès non autorisé · Fuite de données · Ransomware |
| **Mesures de réduction** | Segmentation VLAN · Jumpbox obligatoire · Sauvegardes quotidiennes chiffrées |

---

## Traitement 2 — Gestion des comptes utilisateurs et accès réseau

| Champ | Détail |
|-------|--------|
| **Finalité** | Authentification du personnel · Contrôle d'accès aux ressources du cabinet |
| **Base légale** | Art. 6.1.f RGPD — Intérêt légitime (sécurité du système d'information) |
| **Catégories de données** | Identifiants (login AD) · Mots de passe hashés · Groupes AD · Journaux de connexion · Adresses IP |
| **Personnes concernées** | Personnel du cabinet (médecins, infirmiers, administratifs, IT) |
| **Destinataires** | Administrateurs IT uniquement (VLAN 10) |
| **Transferts hors UE** | Aucun |
| **Durée de conservation** | Durée du contrat de travail + 6 mois après départ |
| **Mesures de sécurité** | Active Directory avec GPO · Passbolt gestionnaire MDP · MFA OpenVPN · Jumpbox SSH/RDP · Wazuh journalisation · Politique de mots de passe forts (GPO) |
| **Stockage** | ML-SRV-AD-01 / AD-02 (VLAN 20) · ML-SRV-PASS-01 (VLAN 10) |
| **Risques identifiés** | Compromission de compte · Élévation de privilèges · Accès non autorisé |
| **Mesures de réduction** | MFA obligatoire · Principe du moindre privilège · Revue des accès périodique |

---

## Traitement 3 — Journaux de sécurité (SIEM Wazuh)

| Champ | Détail |
|-------|--------|
| **Finalité** | Détection des incidents de sécurité · Traçabilité des accès · Conformité RGPD Art. 32 |
| **Base légale** | Art. 6.1.c RGPD — Obligation légale (Art. 32 RGPD — sécurité des traitements) |
| **Catégories de données** | Adresses IP · Actions système (connexions, modifications, suppressions) · Timestamps · Identifiants utilisateurs · Alertes de sécurité |
| **Personnes concernées** | Tout utilisateur du système d'information du cabinet |
| **Destinataires** | Administrateurs IT (VLAN 10) uniquement |
| **Transferts hors UE** | Aucun |
| **Durée de conservation** | 1 an (recommandation CNIL — journaux de sécurité) |
| **Mesures de sécurité** | VLAN 70 isolé · Accès restreint aux admins IT · Wazuh Dashboard protégé par authentification · Intégrité des logs garantie |
| **Stockage** | ML-SRV-WAZUH-01 (VLAN 70) |
| **Risques identifiés** | Altération des journaux · Accès non autorisé aux logs · Volume excessif de données |
| **Mesures de réduction** | Isolation VLAN 70 · Rotation automatique des logs · Alertes en temps réel |

---

## Traitement 4 — Sauvegardes des données

| Champ | Détail |
|-------|--------|
| **Finalité** | Continuité de service · Restauration après incident · Conformité RGPD Art. 32 |
| **Base légale** | Art. 6.1.c RGPD — Obligation légale (Art. 32 RGPD — intégrité et disponibilité) |
| **Catégories de données** | Copies des dossiers patients · Configurations système · Données administratives |
| **Personnes concernées** | Patients · Personnel du cabinet |
| **Destinataires** | Administrateurs IT uniquement |
| **Transferts hors UE** | Aucun |
| **Durée de conservation** | Alignée sur la durée de conservation des données sources (20 ans pour dossiers médicaux) |
| **Mesures de sécurité** | Chiffrement des sauvegardes UrBackup · Stockage isolé VLAN 20 · Accès restreint · Tests de restauration réguliers |
| **Stockage** | ML-SRV-URBACKUP-01 + ML-SRV-BACKUP-01 (VLAN 20) |
| **Risques identifiés** | Corruption des sauvegardes · Accès non autorisé · Perte de données |
| **Mesures de réduction** | Vérification d'intégrité automatique · Double stockage · Tests de restauration |

---

## Traitement 5 — Site vitrine et portail interne web

| Champ | Détail |
|-------|--------|
| **Finalité** | Accès au portail interne du cabinet pour le personnel médico-administratif |
| **Base légale** | Art. 6.1.f RGPD — Intérêt légitime (fonctionnement du cabinet) |
| **Catégories de données** | Logs d'accès HTTP · Adresses IP · Sessions utilisateurs |
| **Personnes concernées** | Personnel du cabinet accédant au portail |
| **Destinataires** | Administrateurs IT |
| **Transferts hors UE** | Aucun |
| **Durée de conservation** | 30 jours (logs Nginx) |
| **Mesures de sécurité** | HTTPS TLS 1.3 · Headers OWASP (HSTS, CSP, X-Frame-Options) · Accès restreint réseau interne · server_tokens off · Certificat TLS |
| **Stockage** | ML-SRV-WEB-01 (VLAN 50 DMZ) |
| **Risques identifiés** | Injection SQL · XSS · Accès non autorisé depuis internet |
| **Mesures de réduction** | Headers de sécurité OWASP · Isolation DMZ · phpMyAdmin restreint VLAN 10 |

---

## Synthèse des mesures de sécurité globales

| Mesure | Détail | Machines concernées |
|--------|--------|---------------------|
| Chiffrement en transit | TLS 1.2/1.3 sur tous les services exposés | ML-SRV-WEB-01 · ML-SRV-PASS-01 |
| Chiffrement des sauvegardes | UrBackup chiffrement natif | ML-SRV-URBACKUP-01 |
| Contrôle d'accès par rôle | Active Directory + GPO | ML-SRV-AD-01/02 |
| Authentification forte | MFA OpenVPN (Google Authenticator) | ML-NET-FW-01 |
| Accès admin sécurisé | Jumpbox SSH/RDP obligatoire | ML-SRV-JUMP-01/02 |
| Gestionnaire de mots de passe | Passbolt CE | ML-SRV-PASS-01 |
| Détection d'intrusion | Wazuh SIEM + agents sur tous serveurs | ML-SRV-WAZUH-01 |
| Supervision réseau | Zabbix | ML-SRV-ZABBIX-01 |
| Segmentation réseau | 9 VLANs isolés par pfSense | ML-NET-FW-01 |
| Journalisation | Logs Nginx + Wazuh + AD | Tous serveurs |

---

## Droits des personnes concernées

Conformément au RGPD, les patients et le personnel du cabinet disposent des droits suivants :

- **Droit d'accès** (Art. 15) — accès à leurs données personnelles
- **Droit de rectification** (Art. 16) — correction des données inexactes
- **Droit à l'effacement** (Art. 17) — sous réserve des obligations légales de conservation
- **Droit à la portabilité** (Art. 20) — export des données dans un format lisible
- **Droit d'opposition** (Art. 21) — opposition au traitement pour motif légitime

**Contact pour exercer ces droits :** support@cabinet.local

---

## Références réglementaires

| Référence | Description |
|-----------|-------------|
| RGPD Art. 9 | Traitement des données de santé — catégories particulières |
| RGPD Art. 30 | Registre des activités de traitement |
| RGPD Art. 32 | Sécurité du traitement |
| Code de la santé publique Art. R.1112-7 | Conservation des dossiers médicaux — 20 ans |
| CNIL — Recommandations | Durée de conservation des journaux de sécurité — 1 an |

---

*MediLink — Cabinet Médical fictif · Jedha Bootcamp 2025 · Confidentiel équipe*
