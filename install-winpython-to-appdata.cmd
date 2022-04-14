@echo off
pushd "%~dp0"

set "INSTALLPATH=%localappdata%\autoactuary\WinPython"

REM Get the location of the Winpython installer
set "PYINSTALLER=%~1"
IF "%PYINSTALLER%" equ "" FOR /F "delims=" %%i IN ('dir /b Winpython64-3.*.exe') DO set "PYINSTALLER=%%i"


if "%PYINSTALLER%" equ "" (
    echo Script requirements
    echo     1. Winpython64-3*.exe must be in same directory as the script
    echo     2. Or installer location must be passed directly: `%~n0 [installer_path]`
    GOTO EOF-PAUSE
)


REM Ensure a clean instalation directory
if exist "%INSTALLPATH%" rmdir /s /q "%INSTALLPATH%"
mkdir "%INSTALLPATH%"


Echo Extract WinPython files to "%INSTALLPATH%"
call "%PYINSTALLER%" -y -o"%INSTALLPATH%"

REM Move files from extracted subdirectory to top-level directory
set "WPy64="
FOR /F "delims=" %%i IN ('dir /b "%INSTALLPATH%\WPy64-*"') DO set "WPy64=%INSTALLPATH%\%%i"
if "%WPy64%" neq "" FOR /F "delims=" %%i IN ('dir /b "%WPy64%\*"') DO move "%WPy64%\%%i" "%INSTALLPATH%\%%i"


:EOF-PAUSE
:EOF-PAUSE
if /i "%comspec% /c %~0 " equ "%cmdcmdline:"=%" pause