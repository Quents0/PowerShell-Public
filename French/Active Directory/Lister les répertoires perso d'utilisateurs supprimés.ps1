#Initialisation
Import-Module ActiveDirectory
Write-Host "Liste des répertoires personnels d'utilisateurs supprimés"

#Chemin des répertoires utilisateurs
$Emplacement = "\\SERVEUR\EMPLACEMENT"

#Attribuer la liste des dossiers utilisateurs à une variable
$ListeDossiers = Get-ChildItem -Path $Emplacement | Select-Object Name

#Pour chaque dossier utilisateur dans la liste des dossiers
foreach ($Dossier in $ListeDossiers)
{
	# Initialisation de la variable $account pour chaque ligne
	$Compte = $null

	# Récupération du nom du dossier dans la ligne traitée
	$Rep = $Dossier.Name

	# Vérification de l'existence ou non du compte
	try { $Compte = Get-ADUser $Rep }
	catch {}

	# Si le compte testé ne revois rien et que donc le nom ne correspond pas
	if ($Compte."SamAccountName" -ne $Rep)
	{
		# Le compte n'existe pas dans l'AD
		Write-Host "$Emplacement\$Rep"

        #Supprimer le dossier
        #Remove-Item -Path "$Emplacement\$Rep" -Force        
	}
}