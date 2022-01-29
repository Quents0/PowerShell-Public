Import-Module ActiveDirectory
$ExporterPC = Get-ADComputer -Filter * | Select -Property Name | Export-Csv C:\temp\AD.csv -NoTypeInformation -Encoding UTF8