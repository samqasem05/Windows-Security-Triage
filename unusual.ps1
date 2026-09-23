write-host "This scrit will find any malisous services or exes found in unuslau paths, like Temp and Appdata" -ForegroundColor red

$services = Get-CimInstance -ClassName win32_service 

$user = read-host "would u like to begin"

foreach($service in $services){

$name = $service.Name

$path = $service.PathName

if($user -eq "yes"){


    $layout = [PSCustomObject]@{


    ServiceName = $service.Name

    Servicepath = $service.PathName

    }

}

}
$layout | convertto-json