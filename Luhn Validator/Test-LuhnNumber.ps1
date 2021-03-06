﻿# Modified from this script: http://scriptolog.blogspot.com/2008/01/powershell-luhn-validation.html
# Added data type conversions for easier input
# Author: Jesse Nebling (@bashexplode)
# License: BSD 3-Clause

#######################################################
## Returns true if the given array of digits represents
## a valid Luhn number, and false otherwise.

function Test-LuhnNumber($digits){

    if($digits -is [string]){$digits = ([string[]][char[]]$digits) }
    if($digits -is [int64]){$digits = ([int[]](($digits -split '') -ne '')) }
    [int]$sum=0
    [bool]$alt=$false

    for($i = $digits.length - 1; $i -ge 0; $i--){
        if($alt){
            $digits[$i] *= 2
            if($digits[$i] -gt 9) { $digits[$i] -= 9 }
        }

        $sum += $digits[$i]
        $alt = !$alt
    }

    return ($sum % 10) -eq 0
}


#######################################################
## Generates a number that passes the Luhn algorithm

function New-LuhnNumber([int]$length){

    $random = new-object random
    $digits = new-object int[] $length

    for($i = 0; $i -lt $length - 1; $i++){
        $digits[$i] = $random.next(10)
    }

    [int]$sum = 0;
    [bool]$alt = $true

    for($i = $length - 2; $i -ge  0; $i--){

        if($alt){
            [int]$temp = $digits[$i]
            $temp *= 2
            if($temp -gt 9){ $temp -= 9 }
            $sum += $temp
        } else {
            $sum += $digits[$i]
        }

        $alt = !$alt
    }

    [int]$modulo = $sum % 10
    if($modulo -gt 0) { $digits[$length-1] = (10 - $modulo) }

    return $digits
}
