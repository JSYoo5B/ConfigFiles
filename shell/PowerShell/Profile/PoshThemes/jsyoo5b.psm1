#requires -Version 2 -Modules posh-git

function Write-Theme {
    param(
        [bool]
        $lastCommandFailed,
        [string]
        $with
    )
    $failCode = $LASTEXITCODE
    $consoleWidth = $Host.UI.RawUI.WindowSize.Width

    # START FIRST LINE (┌00:45:55
    Write-Prompt -Object ([char]::ConvertFromUtf32(0x250C)) -foregroundColor $sl.Colors.PromptForegroundColor
    $firstLine = "L"
    # Show current system time
    $timeStamp = Get-Date -Format "HH:mm:ss"
    $timeColor = $sl.Colors.SuccessColor
    If ($lastCommandFailed) {   # When the last command was failed, color changes into red
        $timeColor = $sl.Colors.FailureColor
    }
    Write-Prompt -Object "$timeStamp " -foregroundColor $timeColor
    $firstLine += "$($timeStamp) "
    # Show last error reason when it has
    If ($lastCommandFailed) {
        # TODO: more helpful exit code
        Write-Prompt -Object "[$failCode] " -foregroundColor $sl.Colors.FailureColor
        $firstLine += "[$($failCode)] "
    }
    # Show current path
    $pwd = [string](Get-Location)
    $remainLength = $consoleWidth - $firstLine.Length
    If ($pwd.Length -gt $remainLength) {  # Trim path to fit console width
        $trimPrefix = "..."
        if ($IsWindows -or $ENV:OS) {
            $driveLetter = (Get-Location).Drive.Name
            $trimPrefix = "$($driveLetter):\..."
        }
        $trimPosition = $pwd.Length - $remainLength + $trimPrefix.Length
        $trimPwd = $pwd.substring($trimPosition)
        $pwd = "$($trimPrefix)$($trimPwd)"
    }
    Write-Prompt -Object "$pwd" -ForegroundColor $sl.Colors.PathColor

    # START SECOND LINE
    Set-Newline
    Write-Prompt -Object ([char]::ConvertFromUtf32(0x2514)) -foregroundColor $sl.Colors.PromptForegroundColor
    # Show <USER> @ <COMPUTER>
    Write-Prompt -Object "$($sl.CurrentUser)" -foregroundColor $sl.Colors.UsernameForegroundColor
    Write-Prompt -Object "@" -foregroundColor $sl.Colors.PromptForegroundColor
    Write-Prompt -Object "$($sl.CurrentHostname)" -foregroundColor $sl.Colors.ComputerForegroundColor
    Write-Prompt -Object ":PS " -foregroundColor $sl.Colors.PromptForegroundColor
    # Show Prompt indicator (may changed for Admin)
    $promptIndicator = $sl.PromptSymbols.PromptNormalIndicator
    $promptColor = $sl.Colors.PromptNormalColor
    If (Test-Administrator) {
        $promptIndicator = $sl.PromptSymbols.PromptAdminIndicator
        $promptColor = $sl.Colors.PromptAdminColor
    }
    Write-Prompt -Object "$promptIndicator" -foregroundColor $promptColor
    Write-Prompt -Object ' ' -foregroundColor $sl.Colors.PromptForegroundColor

    if ($with) {
        Write-Prompt -Object "$($sl.PromptSymbols.SegmentForwardSymbol) $($sl.PromptSymbols.SegmentBackwardSymbol)" -ForegroundColor $sl.Colors.PromptSymbolColor
        Write-Prompt -Object "$($with.ToUpper())" -ForegroundColor $sl.Colors.WithForegroundColor
    }

    # Show VCS status on the right side
    $status = Get-VCSStatus
    if ($status) {
        $vcsInfo = Get-VcsInfo -status ($status)
        $info = $vcsInfo.VcInfo
        # Store current cursor position for restore
        $cursorPos = $Host.UI.RawUI.CursorPosition
        Set-CursorForRightBlockWrite $info.length
        Write-Prompt -Object "$info" -foregroundColor $sl.Colors.GitForegroundColor
        $Host.UI.RawUI.CursorPosition = $cursorPos
    }
}

$sl = $global:ThemeSettings #local settings
$sl.PromptSymbols.PromptNormalIndicator = ">"
$sl.PromptSymbols.PromptAdminIndicator = ([char]::ConvertFromUtf32(0x25B6))
$sl.PromptSymbols.PathSeparator = '\'
$sl.Colors.PromptForegroundColor = [ConsoleColor]::White
$sl.Colors.SuccessColor = [ConsoleColor]::Green
$sl.Colors.FailureColor = [ConsoleColor]::Red
$sl.Colors.PathColor = [ConsoleColor]::Blue
$sl.Colors.UsernameForegroundColor = [ConsoleColor]::Magenta
$sl.Colors.ComputerForegroundColor = [ConsoleColor]::Yellow
$sl.Colors.PromptNormalColor = [ConsoleColor]::White
$sl.Colors.PromptAdminColor = [ConsoleColor]::Red
$sl.Colors.GitForegroundColor = [ConsoleColor]::Green
