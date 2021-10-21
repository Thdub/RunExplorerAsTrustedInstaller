@echo off
%windir%\system32\whoami.exe /USER | find /i "S-1-5-18" 1>nul && ( goto :OK) || ( "%~dp0NSudoLC.exe" -U:T -P:E -Wait -UseCurrentConsole "%~dpnx0"&& exit /b )
:OK
Schtasks /query /TN "CreateExplorerShellUnelevatedTask" >nul 2>&1 && Schtasks /delete /TN "CreateExplorerShellUnelevatedTask" /f >nul 2>&1
reg delete "HKCR\AppID\{CDCBCFCA-3CDC-436f-A4E2-0E02075250C2}" /v "RunAs" /f >nul 2>&1
reg add "HKCR\AppID\{CDCBCFCA-3CDC-436f-A4E2-0E02075250C2}" /v "_RunAs_" /t REG_SZ /d "Interactive User" /f >nul 2>&1
c:\Windows\explorer.exe /NOUACCHECK /root,
timeout /t 2 /nobreak >nul 2>&1
reg delete "HKCR\AppID\{CDCBCFCA-3CDC-436f-A4E2-0E02075250C2}" /v "_RunAs_" /f >nul 2>&1
reg add "HKCR\AppID\{CDCBCFCA-3CDC-436f-A4E2-0E02075250C2}" /v "RunAs" /t REG_SZ /d "Interactive User" /f >nul 2>&1
exit /b
