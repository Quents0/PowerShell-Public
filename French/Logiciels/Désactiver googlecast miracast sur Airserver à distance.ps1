#On récupère la liste des PC
$ListePC = Get-Content -Path \\SERVEUR\c$\temp\ListePC.txt #On part du principe que chaque ligne sera sous la syntaxe "NomDuPC"

#Création d'un fichier log
New-Item -Path C:\PCoff.log -ItemType File -Force

#Pour chaque PC de la liste
foreach ($PC in $ListePC)
{
    #Tester la connexion au PC pour éviter les erreurs inutiles
    $Ping = Test-Connection -ComputerName $PC -Quiet -Count 1

    #Si le ping renvoie "Vrai"
    if ($Ping -eq "True")
    {
        #Informer à l'écran
        Write-Host $PC " : Joignable sur le réseau."
        & "\\$PC\c$\Program Files\App Dynamic\AirServer\AirServerConsole.exe" disable googlecast
        & "\\$PC\c$\Program Files\App Dynamic\AirServer\AirServerConsole.exe" disable miracast
    }

    #Si le ping renvoie "Faux"
    else
    {
        #Informer à l'écran
        Write-Host $PC " : Echec de la connexion."

        #Écrire dans le fichier log
        $DateLog = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
        $Log = $DateLog + " Echec de la connexion : " + $PC | Out-File -FilePath   C:\PCoff.log -Append


    }

}