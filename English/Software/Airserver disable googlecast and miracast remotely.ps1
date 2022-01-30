#On récupère la liste des PC
$PCList = Get-Content -Path \\SERVER\c$\temp\PClist.txt #Syntax : "PCname"

#Log PC offline 
New-Item -Path C:\PCoff.log -ItemType File -Force

foreach ($PC in $ListePC)
{
    #Test the connection to the PC
    $Ping = Test-Connection -ComputerName $PC -Quiet -Count 1

    #If ping = true
    if ($Ping -eq "True")
    {
        Write-Host $PC " : Online."
        & "\\$PC\c$\Program Files\App Dynamic\AirServer\AirServerConsole.exe" disable googlecast
        & "\\$PC\c$\Program Files\App Dynamic\AirServer\AirServerConsole.exe" disable miracast
    }

    #If ping = false
    else
    {
        Write-Host $PC " : Offline."

        #Write to log file
        $DateLog = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        $Log = $DateLog + " Offline : " + $PC | Out-File -FilePath   C:\PCoff.log -Append


    }

}