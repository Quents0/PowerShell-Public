Import-Module ActiveDirectory
$Export = Get-ADComputer -Filter * | Select -Property Name | Out-File -FilePath C:\temp\ListeAD.txt -Append