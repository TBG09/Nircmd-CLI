@echo off
setlocal

set "extension=.ncms"
:: change that path if needed
set "exePath=F:\nircmd-x64\nircmd-CLI.exe"
set "description=Nircmd script"

:: Add file extension association
reg add HKCU\Software\Classes\%extension% /ve /d "%description%" /f
reg add HKCU\Software\Classes\%extension%\DefaultIcon /ve /d "%exePath%,0" /f
reg add HKCU\Software\Classes\%extension%\Shell\Open\Command /ve /d "\"%exePath%\" \"%%1\"" /f

:: Update system file association cache
assoc %extension%=%extension%
ftype %extension%=%exePath% "%%1"

endlocal
