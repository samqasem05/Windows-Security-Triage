$AllProcess = get-process | select-object name, id 

$layout = foreach($proc in $AllProcess){

$getthewin32 = Get-CimInstance win32_process -filter "Processid = $($proc.id)"

$parntid = $getthewin32.ParentProcessId

$parentname = (get-process -id $parntid -ErrorAction SilentlyContinue).Name
   
if($parentname -like "cmd*" -or $parentname -like "powershell*"){

    write-host "CMD or Powershell Parent Process $($parentname)" -ForegroundColor Red

    Get-NetTCPConnection -State Listen | Where-Object {$_.OwningProcess -eq $($proc.id)} | select-object Name, remoteaddress, state, remoteport, owningprocess

    
} else { 

    write-host "Normal PROCESS--------[$($proc.Name)] and normal PARENT-------- [$($parentname)]" -ForegroundColor Green

    }

[PSCustomObject]@{

        ProcessID = $proc.id
        ProcessName = $proc.name
        Parentid = $parntid
        ParentName = $parentname
        
        }

}

$layout | Out-GridView
