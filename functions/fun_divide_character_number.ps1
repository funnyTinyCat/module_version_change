#

function Divide-CharacterNumber {

    param(

        
        [string] $characterNumber

    )


    [string] $newCharacter = ""
    [string] $newNumber = ""

    [string[]] $newCharacterArr
    [string[]] $newNumberArr
    [string[]] $resultArr


    $newCharacterNumberArr = $characterNumber.ToCharArray()

    
    foreach( $item in $newCharacterNumberArr ) {


        if ( $item -match "[0-9]" ) {


            $newNumberArr += $item

        } # end if


        if ( $item -match "[a-z]" ) {


            $newCharacterArr += $item

        } # end if

    } # end foreach loop


    if ($newNumberArr.length) {


        $newNumber = $newNumberArr.toString()

    } # end if


    if ($newCharacterArr.Length ) {


        $newCharacter = $newCharacterArr.toString()

    } # end if

    $aCharacterNumber += @(

        
        [pscustomobject]@{character = "$($newCharacter)"; number = "$($newNumber)"}

    ) # end array


    return $aCharacterNumber

} # end function

