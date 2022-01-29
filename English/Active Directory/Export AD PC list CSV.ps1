Import-Module ActiveDirectory
$Export = Get-ADComputer -Filter * | Select -Property Name | Export-Csv C:\temp\AD.csv -NoTypeInformation -Encoding UTF8