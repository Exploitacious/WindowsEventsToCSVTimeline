
:: Quickly and quietly run both scripts to gather and parse logs
:: Download and run the scripts directly from GitHub
:: Created by: Alex Ivantsov & PieSecurity (https://github.com/piesecurity)

@echo off

:: Checking for Administrator elevation.

        openfiles>nul 2>&1

        if %errorlevel% EQU 0 goto :Download

        echo.
        echo.
        echo.
        echo.
        echo.
        echo.    You are not running as Administrator.
        echo.    This script cannot do it's job without elevation.
        echo.
        echo.    You need run this tool as Administrator.
        echo.

    exit


:: Download Required Files from https://github.com/Exploitacious/WindowsEventsToCSVTimeline
:Download

    PowerShell -Command "mkdir C:\Temp\GatherLogs -erroraction silentlycontinue"
    
    cd "C:\Temp\GatherLogs"

    PowerShell -executionpolicy bypass -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/Exploitacious/WindowsEventsToCSVTimeline/master/Gather-LogsToTimeLine.ps1', 'Gather-LogsToTimeLine.ps1')"

    PowerShell -executionpolicy bypass -Command "(New-Object Net.WebClient).DownloadFile('https://raw.githubusercontent.com/Exploitacious/WindowsEventsToCSVTimeline/master/Parse-LogsToTimeLine.ps1', 'Parse-LogsToTimeLine.ps1')"



:: Start Running the SYSTEM DEBLOAT scripts
:RunScript

    SET ThisScriptsDirectory=%~dp0
    SET PowerShellScriptPath=%ThisScriptsDirectory%Gather-LogsToTimeLine -output "C:\Temp\GatherLogs"
    PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '%PowerShellScriptPath%'";