#

function Save-UpdatedModule {

    param(


        [int] $begin,
        [int] $end,
        [string[]] $contentMagicIni,
        [string] $newModuleName,
        [string] $targetMagicIniPath,
        [bool] $msNotOra
#        [int] $counter

    )


    $contentMagicIni = Get-Content $targetMagicIniPath


# zapisati u magic.ini

    for ( $i = $begin + 1; $i -le $end - 1; $i++ ) {


        if ( $newModuleName.Substring(0, 7) -eq $contentMagicIni[$i].Substring(0, 7) ) {

            if ( ($newModuleName.Substring(0, 5) -eq "DBGPS")  -and !$msNotOra )   {

                
                $newModuleName = "DBGPS = DBGPS_ORA$($newModuleName.Substring(13))"

            } elseif ( ($newModuleName.Substring(0, 7) -eq "DGwinDB")  -and !$msNotOra ) {
            
            
                 $newModuleName = "DGwinDB = DGwinDB_ORA$($newModuleName.Substring(17))"               
            
            }# end if


            $contentMagicIni[$i] = $newModuleName.Trim()

        } # end if
        
    } # end for loop


    Set-Content $targetMagicIniPath $contentMagicIni

} # end function


