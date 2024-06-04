#

. "$($home)\Documents\ps1\module_version_change\functions\fun_set_module_version.ps1"
. "$($home)\Documents\ps1\module_version_change\functions\fun_save_updated_module.ps1"
. "$($home)\Documents\ps1\module_version_change\functions\fun_get_properties.ps1"



[int] $begin = 0
[int] $end = 0
[int] $i = 0
[int] $beginModuleName = 0


[string] $moduleName = ""
[string] $versionSuffix = ""
[string] $moduleNeedToChange = ""
[string] $newModuleName = ""
[string] $fragmentModuleName = ""
[string] $moduleName = ""


$aContentMagicIni = @()

###################################################################################################################

$properties = Get-Properties


# C:\Users\palig\Documents\ps1\module_version_change\ini\CS\MS
$contentMagicIniMs = Get-Content "$($home)$($properties[0].pathToMsCsIni)"

$contentMagicIniOra = Get-Content "$($home)$($properties[0].pathToOraCsIni)"


$beginMs = $contentMagicIniMs.IndexOf(";CSMODULESBEGIN")

$endMs = $contentMagicIniMs.IndexOf(";CSMODULESEND")


$beginOra = $contentMagicIniOra.IndexOf(";CSMODULESBEGIN")

$endOra = $contentMagicIniOra.IndexOf(";CSMODULESEND")

#####################################################################################################################


# begin of the do loop

do {


    Clear-Variable -Name "fragmentModuleName"
    Clear-Variable -Name "versionSuffix"
    Clear-Variable -Name "contentMagicIniMs"
    Clear-Variable -Name "contentMagicIniOra"
    Clear-Variable -Name "beginModuleName"
    Clear-Variable -Name "moduleName"
    Clear-Variable -Name "aContentMagicIni"

######################################################################################################################

    $contentMagicIniMs = Get-Content "$($home)$($properties[0].pathToMsCsIni)"

    $contentMagicIniOra = Get-Content "$($home)$($properties[0].pathToOraCsIni)"

#####################################################################################################################

    echo "`n"

    Write-Host "---------------------------------------------------------------------------------------------------------------------"  -ForegroundColor Gray


    echo "Za izlaz ukucajte `"exit`" i pritisnite [enter]"


    $fragmentModuleName = Read-Host -Prompt "Unesite prva dva slova modula, osim, ako je DGwinDB, onda `"dgd`" [FK]" 

    Write-Host "---------------------------------------------------------------------------------------------------------------------"  -ForegroundColor Gray


    $fragmentModuleName = $fragmentModuleName.Replace(' ', '')

    $fragmentModuleName = $fragmentModuleName.Trim()


    if ( $fragmentModuleName -eq "exit") {

        exit

    } # end if


    if ( $fragmentModuleName.length -eq 0 ) {

        continue

    } # end if


    # pronaći željeni modul


    for ( $i = $beginMs + 1; $i -le $endMs - 1; $i++ ) {


        if ( ($fragmentModuleName.length -eq 2) -and ( $fragmentModuleName.substring(0, 2) -eq  $contentMagicIniMs[$i].substring(0, 2) ) -and ( $contentMagicIniMs[$i].substring(0, 7) -ne "DGwinDB" )) {


            echo "`n"

            Write-Host "Trenutna verzija modula: $($contentMagicIniMs[$i])" -BackgroundColor Blue -ForegroundColor White

            $moduleNeedToChange = $contentMagicIniMs[$i].Trim()

        } elseif ( ($fragmentModuleName.length -eq 3) -and ($fragmentModuleName.substring(0, 3) -eq "dgd") ) {
    
    
            if( "DGwinDB" -eq $contentMagicIniMs[$i].Substring(0, 7) ) {


                echo "`n"

                Write-Host "Trenutna verzija modula: $($contentMagicIniMs[$i])" -BackgroundColor Blue -ForegroundColor White

                $moduleNeedToChange = $contentMagicIniMs[$i].Trim()  

            } # end if
    
        }# end if

    } # end for loop


    # Unos sufiksa verzije modula

    echo "`n"

    Write-Host "---------------------------------------------------------------------------------------------------------------------"  -ForegroundColor Gray

    echo "Za izlaz ukucajte `"exit`" i pritisnite [enter]"

    $versionSuffix = Read-Host -Prompt "Unesite sufiks verzije (npr. `"12a`" - bit će 62012a)."

    Write-Host "---------------------------------------------------------------------------------------------------------------------"  -ForegroundColor Gray


    $versionSuffix = $versionSuffix.Replace(' ', '')

    $versionSuffix = $versionSuffix.Trim()


    if ( $versionSuffix -eq "exit" ) {

  
        exit

    } # end if


    if ( $versionSuffix.length -eq 0 ) {


        continue

    }


    $newModuleName = Set-ModuleVersion -addedSuffix $versionSuffix  -moduleToChange $moduleNeedToChange

    $newModuleName = $newModuleName | Out-String


    $beginModuleName = $newModuleName.IndexOf("=")

    $moduleName = $newModuleName.Substring($beginModuleName + 1).Trim()


    $newModuleName = $newModuleName.Trim()


    echo "`n"

    Write-Host "Nova vrijednost: $($newModuleName)." -BackgroundColor Blue -ForegroundColor White

# priprema za zapisivanje:
########################################################################################################################################################   "$($home)\Documents\ps1\module_version_change\ini\CS\Ora\magic.ini"

    $aContentMagicIni += @(

        
        [pscustomobject]@{begin = $beginMs; end = $endMs; contentMagicIni = $contentMagicIniMs; newModuleName = $newModuleName; targetMagicIniPath = "$($home)$($properties[0].pathToMsCsIni)"; msNotOra = $true }

    ) # end array


    $aContentMagicIni += @(

        
        [pscustomobject]@{begin = $beginOra; end = $endOra; contentMagicIni = $contentMagicIniOra; newModuleName = $newModuleName; targetMagicIniPath = "$($home)$($properties[0].pathToOraCsIni)"; msNotOra = $false }

    ) # end array

########################################################################################################################################################


# zapisivanje u magic.ini

########################################################################################################################################################

    foreach ( $item in $aContentMagicIni )  {


        Save-UpdatedModule -begin $item.begin -end $item.end -contentMagicIni $item.contentMagicIni -newModuleName $item.newModuleName -targetMagicIniPath $item.targetMagicIniPath -msNotOra $item.msNotOra    # -counter $i

    } # end foreach loop

########################################################################################################################################################

} while ( $true ) # end while loop


