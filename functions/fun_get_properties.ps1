
# function get properties


function Get-Properties {


#    param ( )


    $properties = get-content "$($home)\Documents\ps1\module_version_change\config\properties.ini"

    $tmp = 0


    $propertiesVariables = @(


        [pscustomobject]@{pathToMsCsIni='1'; pathToOraCsIni='2' }

    )


    foreach ($property in $properties) {


        $tmp = $property.IndexOf('=')


        if($property.subString(0, $tmp) -eq 'pathToMsCsIni') {


            $propertiesVariables[0].pathToMsCsIni = $property.subString($tmp + 1)

        }elseif($property.subString(0, $tmp) -eq 'pathToOraCsIni') {


            $propertiesVariables[0].pathToOraCsIni = $property.subString($tmp + 1)

        } # end if    

    }#end foreach


    Clear-Variable -Name "tmp"


    return $propertiesVariables


}# end function

