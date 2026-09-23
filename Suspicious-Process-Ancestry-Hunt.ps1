$process = Get-Process | select-object name, id

$layout = foreach($proc in $process){

    $processobj = (Get-CimInstance win32_process -filter "ProcessId = $($proc.Id)").ParentProcessId

    $parentName = (Get-CimInstance win32_process -Filter "ProcessID = $($processobj)").Name


if($parentName -like "powershell*" -or $parentName -like "cmd*"){

    Write-Host "Parent Process $($parentName) Detected" -ForegroundColor Yellow

    } elseif($proc.Name -like "cmd*" -or $proc.Name -like "powershell*"){

        Write-Host "Process $($proc.Name) Detected, Process ID = [$($proc.Id)], Parent Process [$($parentname)]" -ForegroundColor Yellow

        } else { 

            Write-Host "No Powershell Or Cmd Process or Parent Process Detected" -ForegroundColor Green

            }

[PSCustomObject]@{

        ProcessName = $proc.Name

        ProcessId = $proc.Id

        ParentID = $processobj

        ParentName = $parentName

    }

}

$layout
