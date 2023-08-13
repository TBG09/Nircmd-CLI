@echo off
setlocal

:: Specify the extension and registry key path
set "extension=.ncms"
set "registryKey=HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.ncms"

:: Delete the registry key for the file extension association
reg delete "%registryKey%" /f

:: Remove the association from the system file association cache
assoc %extension%=

:: Remove the application as the default handler for the file type
ftype %extension%=

endlocal
