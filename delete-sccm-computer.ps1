param (
    [Parameter(Mandatory = $true)]
    [string]$ComputerName
)

# Set your site code here (e.g. PRI, L01...)
$SiteCode = "YOUR_SITE_CODE"

try {
    Write-Host "🔍 Searching for computer '$ComputerName' in SCCM..."
    $resource = Get-WmiObject -Namespace "root\SMS\site_$SiteCode" -Query "SELECT * FROM SMS_R_System WHERE Name = '$ComputerName'"
    
    if ($resource) {
        $resource | ForEach-Object {
            Remove-WmiObject -InputObject $_
            Write-Host "✅ Successfully deleted '$ComputerName' from SCCM."
        }
    } else {
        Write-Host "⚠️ No matching computer found in SCCM for '$ComputerName'."
    }
} catch {
    Write-Host "❌ Error occurred: $_"
}