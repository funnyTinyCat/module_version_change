#

. "$($home)\Documents\ps1\module_version_change\functions\fun_module_version_check_character.ps1"
. "$($home)\Documents\ps1\module_version_change\functions\fun_divide_character_number.ps1"


function Set-ModuleVersion {

    param(


        [string] $addedSuffix,
        [string] $moduleToChange

    )

 
    [string] $flag = ""
    [string] $endVersion = ""
    [string] $version = ""
    [string] $reversedModuleToChangeNoExtensionNoChar = ""


    if ($addedSuffix -match "[a-z]" ) {


        $flag = "k"


        if ($addedSuffix -match "[0-9]" ) {


            $flag = "kb"

        } # end if

    } elseif ( $addedSuffix -match "[0-9]" ) {
    

        $flag = "b"


        if ($addedSuffix -match "[a-z]" ) {


            $flag = "kb"

        } # end if
    
    
    } # end if




    if ($flag -eq "k") {



        $reversedModuleToChange = $moduleToChange[-1.. -$moduleToChange.Length] -join('')


        if ($reversedModuleToChange.Length) {

            $extension = $reversedModuleToChange.Substring(0, 4)

        } else {
        
            exit

        } #end if


        $reversedModuleToChangeNoExtension = ($reversedModuleToChange.Substring(4)).Trim()


        $endVersion = $reversedModuleToChangeNoExtension.IndexOf("_")


        $version = $reversedModuleToChangeNoExtension.Substring(0, $endVersion)


        # ako modul koji se mijenja ima slova:

        if ( $version -match "[a-z]" ) {


            $reversedModuleToChangeNoExtensionNoChar = Check-VersionCharacter -reversedModuleToChangeNoExtension $reversedModuleToChangeNoExtension

            $reversedModuleToChangeNoExtensionNoChar = $reversedModuleToChangeNoExtensionNoChar | Out-String

            $reversedModuleToChangeNoExtensionNoChar = $reversedModuleToChangeNoExtensionNoChar.Trim()


        } else {
        
        
            $reversedModuleToChangeNoExtensionNoChar = $reversedModuleToChangeNoExtension

            $reversedModuleToChangeNoExtensionNoChar = $reversedModuleToChangeNoExtensionNoChar.Trim()
        
        } # end if


        $reversedAddedSuffix = $addedSuffix[-1.. -$addedSuffix.Length] -join('')


        $newReversedModuleVersion = "$($extension.Trim())$($reversedAddedSuffix.trim())$($reversedModuleToChangeNoExtensionNoChar.Trim())"


        $newModuleVersion = $newReversedModuleVersion[-1.. -$newReversedModuleVersion.Length] -join('')


    } elseif ( $flag -eq "b" ) {


        $reversedModuleToChange = $moduleToChange[-1.. -$moduleToChange.Length] -join('')

         
        if ($reversedModuleToChange.Length) {


            $extension = $reversedModuleToChange.Substring(0, 4)

        } else {
        
            exit
        
        } # end if


        $reversedModuleToChangeNoExtension = $reversedModuleToChange.Substring(4)


        $endVersion = $reversedModuleToChangeNoExtension.IndexOf("_")


        $version = $reversedModuleToChangeNoExtension.Substring(0, $endVersion)


        # ako modul koji se mijenja ima slova:

        if ( $version -match "[a-z]") {

            # provjeriti ovu varijablu, gdje se kreira?
            $reversedModuleToChangeNoExtensionNoChar = Check-VersionCharacter -reversedModuleToChangeNoExtension $reversedModuleToChangeNoExtension

            $reversedModuleToChangeNoExtensionNoChar = $reversedModuleToChangeNoExtensionNoChar | Out-String

            $reversedModuleToChangeNoExtensionNoChar = $reversedModuleToChangeNoExtensionNoChar.Trim()


        } else {
        
        
            $reversedModuleToChangeNoExtensionNoChar = $reversedModuleToChangeNoExtension

            $reversedModuleToChangeNoExtensionNoChar = $reversedModuleToChangeNoExtensionNoChar.Trim()

        }# end if


        $reversedAddedSuffix = $addedSuffix[-1..-$addedSuffix.Length] -join('')


        $subtractedModuleVersion = ($reversedModuleToChangeNoExtensionNoChar.Trim()).Substring($reversedAddedSuffix.Length)


        $newReversedModuleVersion = "$($extension.Trim())$($reversedAddedSuffix.Trim())$($subtractedModuleVersion.Trim())"


        $newModuleVersion = $newReversedModuleVersion[-1..-$newReversedModuleVersion.Length] -join('')


    } elseif ( $flag -eq "kb" ) {



        $reversedModuleToChange = $moduleToChange[-1..-$moduleToChange.Length] -join('')

        
        if ($reversedModuleToChange.Length) {


            $extension = $reversedModuleToChange.Substring(0, 4)

        } else {


            exit 

        } # end if


        $reversedModuleToChangeNoExtension = $reversedModuleToChange.Substring(4)


        $endVersion = $reversedMOduleToChangeNoExtension.IndexOf("_")


        $version = $reversedModuleToChangeNoExtension.Substring(0, $endVersion)


        if ( $version -match "[a-z]" ) {


            $reversedModuleToChangeNoExtensionNoChar = Check-VersionCharacter -reversedModuleToChangeNoExtension $reversedModuleToChangeNoExtension

            $reversedModuleToChangeNoExtensionNoChar = $reversedModuleToChangeNoExtensionNoChar | Out-String

            $reversedModuleToChangeNoExtensionNoChar = $reversedModuleToChangeNoExtensionNoChar.Trim()

        } else {
        
        
            $reversedModuleToChangeNoExtensionNoChar = $reversedModuleToChangeNoExtension

            $reversedModuleToChangeNoExtensionNoChar = $reversedModuleToChangeNoExtensionNoChar.Trim()


        } # end if


        $reversedAddedSuffix = $addedSuffix[-1..-$addedSuffix.Length] -join('')


        $characterNumberArr = Divide-CharacterNumber -characterNumber $reversedAddedSuffix


        $subtractedModuleVersion = $reversedModuleToChangeNoExtensionNoChar.Substring($characterNumberArr.number.Length)


        $newReversedModuleVersion = "$($extension)$($reversedAddedSuffix)$($subtractedModuleVersion)"


        $newModuleVersion = $newReversedModuleVersion[-1..-$newReversedModuleVersion.Length] -join('')


    } # end if


    return $newModuleVersion


} # end function

