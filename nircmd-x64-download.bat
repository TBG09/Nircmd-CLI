@echo off

set "downloadURL=https://www.nirsoft.net/utils/nircmd-x64.zip"
set "zipFileName=nircmd-x64.zip"

echo Downloading %zipFileName%...
powershell -command "Invoke-WebRequest -Uri '%downloadURL%' -OutFile '%zipFileName%'"

echo Extracting %zipFileName%...
powershell -command "Expand-Archive -Path '%zipFileName%' -DestinationPath ."

echo Cleaning up...
del %zipFileName%

echo Done!
pause
