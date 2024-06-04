#

function Check-VersionCharacter {

    param(

        
        [string] $reversedModuleToChangeNoExtension

    )

    
    [int] $endVersion = 0

    [string] $version = ""
    [string] $reversedModuleCleanVersion = ""
    [string] $moduleName = ""
    [string] $newVersion = ""

    [string[]] $newVersionArr


    if (!$reversedModuleToChangeNoExtension.Length) {

 
        exit

    } # end if

    $endVersion = $reversedModuleToChangeNoExtension.IndexOf("_")

    $version = $reversedModuleToChangeNoExtension.Substring(0, $endVersion)

    $moduleName = $reversedModuleTochangeNoExtension.Substring($endVersion).Trim()


    $versionArr = $version.ToCharArray()


    foreach( $item in $versionArr ) {

        if( $item -match "[0-9]" ) {


            $newVersionArr += $item

        } # end if

    } # end foreach


    $newVersionArr = ($newVersionArr.toString()).trim()

    $newVersion = ($newVersionArr).toString()

    $newVersion = $newVersion.Replace(' ', '')


    return "$($newVersion)$($moduleName)"



} # end function

