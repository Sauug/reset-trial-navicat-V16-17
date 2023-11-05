https://github.com/Sauug/reset-trial-navicat-16.x/assets/36141434/98c38b08-aa6d-47fa-a056-505454eda0b7

***Tested on 16.2.10 version.***

# reset-trial-navicat-16.x

- Launch trial_reset_navicat.ps1 in administrator

# You can automate this task
- Launch task scheduler 
- Action -> Create Basic Task
- Name it
- Take the task all weekly and select your day
- Select start a program
- In "Program / script" set **%windir%\System32\WindowsPowerShell\v1.0\powershell.exe** and in "Add arguments (optional)" set **-WindowStyle Hidden -File "PATH_WHERE_IS_YOUR_SCRIPT"**
- Finish and right-click on your task, then properties, in "General" check "Run with maximum permissions"
- Modify the script :
      - comment lines 1 and 2
      - modify the line 12 : "Remove-Item -Path "HKCU:\Software\PremiumSoft\NavicatPremium\Registration<YOUR_LANGUAGE>" -Force -ErrorAction SilentlyContinue" (to take it : Ordinateur\HKEY_CURRENT_USER\SOFTWARE\PremiumSoft\NavicatPremium)

The script look like this :

```powerhsell

#$getlang = Read-Host "What is your version and language of Navicat ? [ex: 16XEN]"
#$getlang = $getlang.ToUpper()

Write-Host -NoNewline "[~]" -ForegroundColor Cyan
Write-Host " Deleteting Navicat Update key ..."

Remove-Item -Path "HKCU:\Software\PremiumSoft\NavicatPremium\Update" -Force -ErrorAction SilentlyContinue

Write-Host -NoNewline "[~]" -ForegroundColor Cyan
Write-Host " Deleteting Navicat Language key ..."

Remove-Item -Path "HKCU:\Software\PremiumSoft\NavicatPremium\Registration16XFR" -Force -ErrorAction SilentlyContinue

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

```




