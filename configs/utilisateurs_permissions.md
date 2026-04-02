# Gestion des utilisateurs et permissions (AGDLP)

## Création des groupes globaux (GC)

```powershell
New-ADGroup -Name "GC-Medecins" -GroupScope Global -GroupCategory Security
New-ADGroup -Name "GC-Infirmiers" -GroupScope Global -GroupCategory Security
New-ADGroup -Name "GC-Administratif" -GroupScope Global -GroupCategory Security
New-ADGroup -Name "GC-Comptabilite" -GroupScope Global -GroupCategory Security
New-ADGroup -Name "GC-RH" -GroupScope Global -GroupCategory Security
New-ADGroup -Name "GC-ServicesGeneraux" -GroupScope Global -GroupCategory Security
New-ADGroup -Name "GC-IT" -GroupScope Global -GroupCategory Security

#Ajout des utilisateurs au groupes
Add-ADGroupMember -Identity "GC-Medecins" -Members "User1","User2"
Add-ADGroupMember -Identity "GC-Infirmiers" -Members "User3","User4"

#Création des groupes Domain Local (DL)
New-ADGroup -Name "DL-DossiersMedicaux-RW" -GroupScope DomainLocal -GroupCategory Security
New-ADGroup -Name "DL-DossiersMedicaux-R" -GroupScope DomainLocal -GroupCategory Security
New-ADGroup -Name "DL-Secretariat-RW" -GroupScope DomainLocal -GroupCategory Security
New-ADGroup -Name "DL-Secretariat-R" -GroupScope DomainLocal -GroupCategory Security
New-ADGroup -Name "DL-Commun-RW" -GroupScope DomainLocal -GroupCategory Security
New-ADGroup -Name "DL-Commun-R" -GroupScope DomainLocal -GroupCategory Security
New-ADGroup -Name "DL-AdminIT-FC" -GroupScope DomainLocal -GroupCategory Security


#Liaisons AGDLP
Add-ADGroupMember -Identity "DL-DossiersMedicaux-RW" -Members "GC-Medecins"
Add-ADGroupMember -Identity "DL-DossiersMedicaux-R" -Members "GC-Infirmiers"

Add-ADGroupMember -Identity "DL-Secretariat-RW" -Members "GC-Administratif"
Add-ADGroupMember -Identity "DL-Secretariat-R" -Members "GC-Medecins","GC-Infirmiers"

Add-ADGroupMember -Identity "DL-Commun-RW" -Members "GC-Medecins","GC-Infirmiers","GC-Administratif","GC-Comptabilite","GC-RH","GC-ServicesGeneraux"
Add-ADGroupMember -Identity "DL-Commun-R" -Members "GC-IT"

Add-ADGroupMember -Identity "DL-AdminIT-FC" -Members "GC-IT"
