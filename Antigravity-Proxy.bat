@echo off
setlocal EnableExtensions
title Antigravity Proxy Launcher

rem ==========================================================
rem Antigravity Proxy Launcher
rem Configure a local HTTP or HTTP-compatible mixed proxy.
rem ==========================================================

rem ---- USER SETTINGS ----------------------------------------
set "PROXY_HOST=127.0.0.1"
set "PROXY_PORT=10810"

rem Optional: set the full path to Antigravity.exe if auto-detection fails.
rem Example:
rem set "ANTIGRAVITY_EXE=C:\Users\YourName\AppData\Local\Programs\Antigravity\Antigravity.exe"
set "ANTIGRAVITY_EXE="

rem -----------------------------------------------------------
set "PROXY_URL=http://%PROXY_HOST%:%PROXY_PORT%"

echo.
echo  Antigravity Proxy Launcher
echo  --------------------------
echo  Proxy: %PROXY_URL%
echo.

rem Check whether Antigravity is already running.
rem A running instance will not inherit this launcher's environment.
tasklist /FI "IMAGENAME eq Antigravity.exe" 2>NUL | find /I "Antigravity.exe" >NUL
if not errorlevel 1 (
    echo [!] Antigravity appears to be running already.
    echo     Close all Antigravity windows and background processes,
    echo     then run this launcher again.
    echo.
    pause
    exit /b 1
)

rem Find Antigravity in common installation locations.
if not defined ANTIGRAVITY_EXE if exist "%LOCALAPPDATA%\Programs\Antigravity\Antigravity.exe" (
    set "ANTIGRAVITY_EXE=%LOCALAPPDATA%\Programs\Antigravity\Antigravity.exe"
)

if not defined ANTIGRAVITY_EXE if exist "%ProgramFiles%\Antigravity\Antigravity.exe" (
    set "ANTIGRAVITY_EXE=%ProgramFiles%\Antigravity\Antigravity.exe"
)

if not defined ANTIGRAVITY_EXE if defined ProgramFiles(x86) if exist "%ProgramFiles(x86)%\Antigravity\Antigravity.exe" (
    set "ANTIGRAVITY_EXE=%ProgramFiles(x86)%\Antigravity\Antigravity.exe"
)

if not defined ANTIGRAVITY_EXE (
    echo [!] Antigravity.exe was not found automatically.
    echo     Paste the full path to Antigravity.exe below.
    set /p "ANTIGRAVITY_EXE=Path: "
)

if not exist "%ANTIGRAVITY_EXE%" (
    echo.
    echo [ERROR] The specified Antigravity.exe does not exist.
    echo         Check the path and edit this file if necessary.
    echo.
    pause
    exit /b 1
)

rem Check that the local proxy port is accepting TCP connections.
powershell.exe -NoProfile -Command "$c = New-Object System.Net.Sockets.TcpClient; try { $c.Connect('%PROXY_HOST%', [int]('%PROXY_PORT%')); exit 0 } catch { exit 1 } finally { $c.Dispose() }" >NUL 2>&1
if errorlevel 1 (
    echo [ERROR] Cannot connect to the local proxy at %PROXY_HOST%:%PROXY_PORT%.
    echo.
    echo Start your VPN/proxy application and enable its local HTTP
    echo or HTTP-compatible mixed port. TUN mode is not required.
    echo Then check PROXY_HOST and PROXY_PORT at the top of this file.
    echo.
    pause
    exit /b 1
)

rem Set proxy variables only for this launcher and the app it starts.
rem Use an HTTP URL for HTTP_PROXY and HTTPS_PROXY.
set "HTTP_PROXY=%PROXY_URL%"
set "HTTPS_PROXY=%PROXY_URL%"
set "ALL_PROXY=%PROXY_URL%"
set "http_proxy=%PROXY_URL%"
set "https_proxy=%PROXY_URL%"
set "all_proxy=%PROXY_URL%"
set "NO_PROXY=localhost,127.0.0.1"
set "no_proxy=localhost,127.0.0.1"

echo [OK] Local proxy is reachable.
echo [OK] Starting Antigravity...
echo.

start "" "%ANTIGRAVITY_EXE%"
exit /b 0
