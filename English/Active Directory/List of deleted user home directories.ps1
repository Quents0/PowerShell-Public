Import-Module ActiveDirectory
Write-Host "List of deleted user home directories"

#Path home directories
$Path = "\\SERVER\PATH"

#Folders list to variable
$FoldersList = Get-ChildItem -Path $Path | Select-Object Name

foreach ($Folder in $FoldersList)
{
	#Initalization of the variable for each line
	$Account = $null

	#Get folder name for each line
	$Fold = $Folder.Name

	#Check the name account in AD
	try { $Account = Get-ADUser $Fold }
	catch {}

	#If SamAccountName not equal folder name
	if ($Account."SamAccountName" -ne $Fold)
	{
		#The account does not exist in AD
		Write-Host "$Path\$Fold"

        #Remove Folder
        #Remove-Item -Path "$Path\$Fold" -Force        
	}
}