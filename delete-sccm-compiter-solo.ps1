$device = Get-CMDevice -Name "NomDuPC"

if ($device) {

    Remove-CMDevice -InputObject $device -Force

    Write-Host "Supprimé : NomDuPC"

} else {

    Write-Host "Introuvable : NomDuPC"

}