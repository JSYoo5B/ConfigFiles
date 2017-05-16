Get-AppxPackage *Zune* | Remove-AppxPackage
Get-AppxPackage *OneNote* | Remove-AppxPackage
Get-AppxPackage *Xbox* | Remove-AppxPackage
Get-AppxPackage *Commm* | Remove-AppxPackage
Get-AppxPackage *People* | Remove-AppxPackage
Get-AppxPackage *Messaging* | Remove-AppxPackage
Get-AppxPackage *FeedbackHub* | Remove-AppxPackage
Get-AppxPackage *comm* | Remove-AppxPackage

taskkill /f /im OneDrive.exe
cd C:\Windows\SysWOW64
.\OneDriveSetup.exe /uninstall