
function Log-Entry {
    <# 
        .SYNOPSIS
        Generates a sub-directory to serve as a worklog entry in a given 
        worklog directory.
        
        .DESCRIPTION    
        Log-Entry is a function that creates a date prefixed folder as a log 
        entry into the directory associated with the work type.
            
        .
        .PARAMETER EntryName
        the name you want for the log entry sub-directory
        
        .PARAMETER EntryPath
        the path to the worklog directory. This is either a directory path, or 
        a shortcut term such as 'work'
        
        .EXAMPLE
        PS> Log-Entry MyWorkLogEntry Work
        creates a directory named $WorkLogPath\YYYY-MM-DD MyWorkLogEntry
    #>
    
    <#Parameters#>
    [CmdletBinding()]
    param(
        $EntryName,
        $EntryPath
    )
    <#DefaultVaulues#>
    $trainingLogPath = "$env:USERPROFILE\Documents\Training_Log"
    $workLogPath = "$env:USERPROFILE\Documents\Work_Log"
    $PlcLogPath = "$env:USERPROFILE\Documents\PLC_Log"
    $defaultPath = $workLogPath
    <#Array of Values#>
    $shortcuts = @{
        "Work"     = $workLogPath; 
        "Training" = $trainingLogPath;
        "Train"    = $trainingLogPath
        "PLC"      = $PlcLogPath
    }
    <#TimeStamp#>
    $dateStamp = "$(get-date -f yyyy-MM-dd)"      
    <#Process#>
    <#1. handle the first argument for the name of the log entry [EntryName]#>
    if ($null -eq $EntryName) {
        Write-Host "Please provide a name for the log entry"
        Write-Host " You can type `"LogEntry.ps1 --help`" for help"
        exit
    }
    else {
        $nameOfEntry = "$($EntryName)"
    }

    <#2. handle the second argument for the path to the log entry [EntryPath]#>
    if ($null -eq $EntryPath) {
        $logPath = $defaultPath
    }
    else {
        <# if not null, check for a shortcut#>
        Switch ($EntryPath) {
            "Work" { $logPath = $workLogPath }
            "Train" { $logPath = $trainingLogPath }
            "Training" { $logPath = $trainingLogPath }
            "PLC" { $logPath = $PlcLogPath }
            default { $logPath = $EntryPath }
        }
    }

    <#3. Normalize the path by trimming spaces and ending \#>
    $logPath = $logPath.Trim()
    $logPath = $logPath.TrimEnd("\")
    Write-Host "logpath = $logPath"

    <#4. confirm the logpath is valid#>
    if (Test-Path $logPath -PathType Container) {
        $logEntry = ($logPath.Trim() + "\".Trim() + $dateStamp.Trim() + " " + $nameOfEntry.Trim())
        New-Item -ItemType Directory -Force -Path $logEntry
        Write-Host "$logEntry has been created"
    }
    else {
        Write-Host "$logPath is not a valid directory"
        Write-Host "Please provide a valid directory for the log entry"
        Write-Host " or leave it blank for the default entry"
        Write-Host " You can type `"LogEntry.ps1 --help`" for help"
        exit
    }
    <# Provide Help#>   


}
