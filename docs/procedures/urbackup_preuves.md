# Preuves configuration UrBackup — MediLink

## Contexte

UrBackup est le système de sauvegarde du projet MediLink.

- ML-SRV-FILE-01 : serveur à sauvegarder  
- ML-SRV-URBACKUP-01 : serveur de sauvegarde  
- ML-SRV-BACKUP-01 : stockage  

---

## 1. Agent UrBackup actif

Commande :
sc query UrBackupClientBackend

Résultat :
Service RUNNING

→ L’agent fonctionne correctement

---

## 2. Vérification des partages

Commande :
net share

Résultat :
- DossiersMedicaux  
- Communs  
- Secretariat  
- AdminIT  

→ Les dossiers sont bien présents

---

## 3. Machine dans le domaine

Commande :
systeminfo | findstr /i "domain"

Résultat :
medilink.local

→ Les droits AD sont appliqués

---

## 4. Connectivité réseau

Commande :
ping 192.168.20.13

Résultat :
Réponse OK

→ Les serveurs communiquent

---

## 5. Port UrBackup

Commande :
Test-NetConnection -ComputerName 192.168.20.13 -Port 55413

Résultat :
TcpTestSucceeded = True

→ Port ouvert

---

## 6. Sauvegarde effectuée

- Type : Full backup  
- Date : 31/03/2026  
- Taille : 4.43 GB  

→ Sauvegarde réussie

---

## 7. Problème identifié

Client offline malgré :
- service OK  
- réseau OK  
- port OK  

Cause probable :
blocage pfSense (réseau)

---

## Conclusion

- Sauvegarde fonctionnelle  
- Données protégées  
- Problème réseau identifié  
