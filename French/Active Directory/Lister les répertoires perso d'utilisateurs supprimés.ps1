Import-Module ActiveDirectory
Write-Host "Liste des répertoires d'utilisateurs absents"

#Chemin des répertoires utilisateurs
$Path = "\\SERVEUR\EMPLACEMENT"

#Attribuer la liste des dossiers à une variable
$Liste_dossiers = Get-ChildItem -Path $Path | Select-Object Name

foreach ($dossier in $Liste_dossiers)
{
	# Initialisation de la variable $account pour chaque ligne
	$account = $null

	# Récupération du nom du dossier dans la ligne traitée
	$rep = $dossier.Name

	# Vérification de l'existence ou non du compte
	try { $account = Get-ADUser $rep }
	catch {}

	# Teste si le compte existe et qu'il est égal au nom du dossier
	if ($account."SamAccountName" -ne $rep)
	{
		# Le compte n'existe pas dans l'AD
		Write-Host "$Path\$rep"
	}
}
