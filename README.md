# SCCM-MECM-DELETE-PCS

PowerShell script to delete a computer device from Microsoft Endpoint Configuration Manager (MECM/SCCM).

## 📋 Description
This script automates the removal of devices from SCCM using WMI (Windows Management Instrumentation) queries.

Useful for cleaning up old or duplicate devices in the SCCM database.

## 🧠 Requirements

- SCCM PowerShell module (run the script from the MECM server or console).
- Administrative rights on MECM/SCCM.
- PowerShell 5.1 or later.

## 🚀 Usage

```powershell
.\delete-sccm-computer.ps1 -ComputerName "DEVICE-NAME"
```

## 🛠 Example command used:

```powershell
$resource = Get-WmiObject -Namespace "root\SMS\site_<YourSiteCode>" -Query "SELECT * FROM SMS_R_System WHERE Name = 'DEVICE-NAME'"
$resource | ForEach-Object {
    Remove-WmiObject -InputObject $_
}
```

✅ Replace `<YourSiteCode>` with your actual SCCM site code (e.g., "PRI", "L01", etc.).

## 🛡️ Safety
This script includes error handling and will skip if the device is not found.  
You can add logging for audit purposes.

---

📁 GitHub Repository: [SCCM-MECM-DELETE-PCS](https://github.com/KuKaRaCHa-gg/SCCM-MECM-DELETE-PCS)
```

---

### 📜 `delete-sccm-computer.ps1`
```powershell
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
```

