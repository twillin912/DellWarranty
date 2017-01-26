#Get public and private function definition files.
$Public  = Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -Recurse -ErrorAction SilentlyContinue
$Private = Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -Recurse -ErrorAction SilentlyContinue
If ( $Public ) {$AllFunctions += $Public}
If ( $Private ) {$AllFunctions += $Private}

#Dot source the files
foreach ( $Import in $AllFunctions ) {
    try {
        . $Import.Fullname
    }
    catch {
        Write-Error -Message "Failed to import function $($Import.Fullname): $_"
    }
}

# Export only the functions in the Public folder.
Export-ModuleMember -Function $Public.Basename
