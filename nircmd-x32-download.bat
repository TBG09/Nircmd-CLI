@echo off

set "downloadURL=https://www.nirsoft.net/utils/nircmd.zip"
set "zipFileName=nircmd.zip"

echo Downloading %zipFileName%...
powershell -command "Invoke-WebRequest -Uri '%downloadURL%' -OutFile '%zipFileName%'"

echo Extracting %zipFileName%...
powershell -command "Expand-Archive -Path '%zipFileName%' -DestinationPath ."

echo Cleaning up...
del %zipFileName%

echo Done!
pause
