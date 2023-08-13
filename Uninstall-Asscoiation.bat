@echo off
setlocal

set "extension=.ncms"
set "exePath=F:\nircmd-x64\nircmd-CLI.exe"

:: Remove file extension association
reg delete HKCU\Software\Classes\%extension% /f
reg delete HKCU\Software\Classes\.%extension% /f

:: Update system file association cache
assoc %extension%=

:: Remove association from file types
for /f "delims=" %%i in ('ftype %extension%') do (
    set "ftypeLine=%%i"
    if not "!ftypeLine:%exePath%=!"=="!ftypeLine!" (
        ftype %extension%=
    )
)

endlocal
