 ########################################################################################
#                     Scrpit to AD connectivity and event logs check                   #
########################################################################################

function AD-Check {

    if (!(Test-ComputerSecureChannel -Server "genmab.net" -Verbose)) 
        {
            Write-Host "Connection failed. Reconnect and retry."
        }
    else 
        {
            Write-Host "Connectivity is successful"
        }
}
 
 AD-Check 


 Function Send-Notification {
    Param(
        [Parameter(Mandatory)]
        [string]$M,
 
        [Parameter()]
        [string]$SlackWebhookURI = '<webhook URI>'
    )
 
    Send-SlackMessage -Uri $SlackWebhookURI -Text $Message
}


#$a | FT -AutoSize | Out-File C:\temp\logs\logs.txt


#GROUP POLICY RELATED LOGS

    $Filter = @{
           LogName = 'System','Security','Application'
           ID = 1030, 1068, 1130, 1129, 1002, 1006, 1058, 1053, 1097, 4016, 5016
           StartTime =  Get-Date -Date '05/08/2023 00:00:00'
           EndTime = Get-Date -Date '05/10/2023 00:00:00'
    }
    Get-WinEvent -FilterHashtable $Filter | Select-Object LogName,TimeCreated,LevelDisplayName,ID,Message
    
    #Get-WinEvent -FilterHashtable $Filter | Select-Object LogName,TimeCreated,LevelDisplayName,ID,Message | Out-File C:\temp\logs\logs.txt


 #AD AND DOMAIN DISJOIN RELATED LOGS

    $Filter = @{
           LogName = 'System','Security','Application'
           ID = 8464, 8477, 8418, 1908, 8333, 8589, 8446, 8240, 8451, 1256, 1396, 1722, 1753, 8606,1388, 1988, 2042, 1925, 2087, 2088, 4707, 1068
           StartTime =  Get-Date -Date '05/08/2023 00:00:00'
           EndTime = Get-Date -Date '05/10/2023 00:00:00'
    }
    Get-WinEvent -FilterHashtable $Filter | Select-Object LevelDisplayName,LogName,TimeCreated,ID,Message
    
    #Get-WinEvent -FilterHashtable $Filter | Select-Object LevelDisplayName,LogName,TimeCreated,ID,Message | Out-File C:\temp\logs\logs.txt






 
