# 

function Find-CurrentModule {

    param(


        [int] $begin,
        [int] $end,
        
        [string] $fragmentModuleName,
        [string[]] $contentMagicIni

    )

   
    if ($fragmentModuleName.length -gt 0) {



    } else {
    

        exit 

    } # end if


    # pronaći modul koji želimo mijenjati

    for ( $i = $begin + 1; $i -le $end -1; $i++ ) {


        if ( ( ( $fragmentModuleName.substring(0, 2) -eq  $contentMagicIni[$i].substring(0, 2) ) -and ( $contentMagicIni[$i].substring(0, 7) -ne "DGwinDB" )) -and ( (( ($fragmentModuleName.Length -eq 3) -or ( $fragmentModuleName.Length -eq 2 )) -and ($fragmentModuleName -ne "dgd")) -and ( $fragmentModuleName.substring(0, 2) -eq  $contentMagicIni[$i].substring(0, 2) ) )   ) {


            $moduleNeedToChange = $contentMagicIni[$i].Trim()

        } elseif ( ($fragmentModuleName.length -eq 3) -and ($fragmentModuleName.substring(0, 3) -eq "dgd") ) {


            if ( "DGwinDB" -eq $contentMagicIni[$i].Substring(0, 7) ) {
                    

                $moduleNeedToChange = $contentMagicIni[$i].Trim()
                    
            } # end if    

        } # end if

    } # end for loop

       
    return $moduleNeedToChange

} # end function 

