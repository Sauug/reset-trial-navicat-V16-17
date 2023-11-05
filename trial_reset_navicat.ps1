$getlang = Read-Host "What is your version and language of Navicat ? [ex: 16XEN]"
$getlang = $getlang.ToUpper()

Write-Host -NoNewline "[~]" -ForegroundColor Cyan
Write-Host " Deleteting Navicat Update key ..."

Remove-Item -Path "HKCU:\Software\PremiumSoft\NavicatPremium\Update" -Force -ErrorAction SilentlyContinue

Write-Host -NoNewline "[~]" -ForegroundColor Cyan
Write-Host " Deleteting Navicat Language key ..."

Remove-Item -Path "HKCU:\Software\PremiumSoft\NavicatPremium\Registration$getlang" -Force -ErrorAction SilentlyContinue

Write-Host -NoNewline "[~]" -ForegroundColor Cyan
Write-Host " Deleteting Navicat CLSID classes key ..."

$clsids = Get-ChildItem -Path 'HKCU:\Software\Classes\CLSID' | ForEach-Object { $_.PSChildName }

foreach ($clsid in $clsids) {
    $clsidPath = "HKCU:\Software\Classes\CLSID\$clsid"   
    $infoPath = Join-Path $clsidPath 'Info'
    $shellFolderPath = Join-Path $clsidPath 'ShellFolder'


    if (Test-Path $infoPath) {
        
        Remove-Item -Path $infoPath -Force -Recurse
    }

    if (Test-Path $shellFolderPath) {
        Remove-Item -Path $clsidPath -Force -Recurse
    }
}

Write-Host -NoNewline "[+]" -ForegroundColor Green
Write-Host " Navicat has been reseted ! Have fun !"