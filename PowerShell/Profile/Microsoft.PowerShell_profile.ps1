# Enable oh-my-posh when it is installed
If ((Get-Module -list posh-git) -and (Get-Module -list oh-my-posh)) {
    Import-Module posh-git
    Import-Module oh-my-posh

    $preferThemeName = "jsyoo5b"
    $backupThemeName = "DarkBlood"

    $themeName = (Get-Theme) |
        Where-Object { $_.Name.ToLower().Equals($preferThemeName.ToLower()); } |
        Select-Object -Unique -ExpandProperty Name
    If (!$themeName) {
        $themeName = $backupThemeName;
    }
    Set-Theme $themeName
}

# OS specific settings
If ($IsWindows -or $ENV:OS) {   # Windows
    # Alias vi to vim when it is installed and executable by PATH
    If (Get-Command "vim" -ErrorAction SilentlyContinue) {
        Set-Alias vi vim
    }
    Else {
        $Error.Remove($error[0])
    }
}
