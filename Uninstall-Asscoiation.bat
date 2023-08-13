::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAnk
::fBw5plQjdG8=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSjk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCmDJFeN5kE9LFZMGlC+CWWzCKYI6eT3osuUsU4SXeMrcYDVl6zYdK4W8kCE
::YB416Ek+ZW8=
::
::
::978f952a14a936cc963da21a135fa983
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
