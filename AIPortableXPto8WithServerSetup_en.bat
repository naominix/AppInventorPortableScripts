@echo off
REM App Inventor Portable Batch File for Windows
REM non-Admin / USB UserHome Version
REM Author : naominix
:STARTING
REM launch the Personal Server->1 / not launch Personal Server->0
set SERVER=1
REM get "Drive letter"+"Current PATH" on USB Stick
set CURDIR=%~dp0
IF NOT "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
    echo "JAVA_HOME on USB Stick : JDK(32bit)"
    set JAVA_HOME=%CURDIR%\jdk1.7.0_13_32
) ELSE (
    echo "JAVA_HOME on USB Stick : JDK(64bit)"
    set JAVA_HOME=%CURDIR%\jdk1.7.0_13
)
REM save th environment variable "PATH"
set STPATH=%PATH%
REM add JDK PATH on USB Stick
set PATH=%JAVA_HOME%\bin;%PATH%
REM .appinventor directory on USB Stick
set AIDIR=%CURDIR%\.appinventor
set AIDIREXIST=0
echo **************************************
echo AppInventor Portable Environment Setup
echo **************************************
IF EXIST "%AIDIR%" (
    set AIDIREXIST=1
)
IF %AIDIREXIST% == 1 (
    GOTO CONFIG
) ELSE (
    mkdir "%AIDIR%"
    echo.%~dp0AppInventor\commands-for-Appinventor>> "%AIDIR%\appinventordirectorycache"
)
:CONFIG
echo *************************************
echo JavaWebStart JNLP File Setting
echo *************************************
echo check jnlp_auto_file registry key
echo *************************************
reg query HKCU\Software\Classes\jnlp_auto_file /s
IF %ERRORLEVEL% == 0 (
    echo export jnlp_auto_file registry key
    reg export HKCU\Software\Classes\jnlp_auto_file %CURDIR%\jnlp_auto_file_BkUp.reg
)
echo change jnlp_auto_file key for AppInventor Portable
reg add HKCU\Software\Classes\jnlp_auto_file\shell\open\command /ve /t REG_SZ /d "%JAVA_HOME%\jre\bin\javaws.exe -J-Duser.home=%CURDIR% \"%%1\"" /f
echo *************************************
echo check .jnlp registry key
echo *************************************
reg query HKCU\Software\Classes\.jnlp /s
IF %ERRORLEVEL% == 0 (
    echo export Classes\.jnlp registry key
    reg export HKCU\Software\Classes\.jnlp %CURDIR%\jnlp_ext_BkUp.reg
) ELSE (
    echo change Classes\.jnlp registry key for AppInventor Portable
    reg add HKCU\Software\Classes\.jnlp /ve /t REG_SZ /d "jnlp_auto_file"
)
echo *************************************
echo check .jnlp\UserChoise registry key
echo *************************************
reg query HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jnlp\UserChoice /s
IF %ERRORLEVEL% == 0 (
    echo export FileExts\.jnlp registry key
    reg export HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jnlp %CURDIR%\jnlp_userchoice_BkUp.reg
    echo use the FileExts\.jnlp\UserChoice registry key default setting
) ELSE (
    echo change FileExts\.jnlp registry key for AppInventor Portable
    reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jnlp\UserChoice /v ProgId /t REG_SZ /d "jnlp_auto_file"
)
IF %SERVER% == 1 (
    echo **************************************************
    echo  launch Personal Server
    echo      App Inventor Front Server Starting...
    echo **************************************************
    start /MIN %~dp0\AI4A\AppEngine\startAI.cmd
    echo **************************************************
    echo      Build Server Starting...
    echo **************************************************
    IF NOT "%PROCESSOR_ARCHITECTURE%" == "AMD64" (
        start /MIN %~dp0\AI4A\BuildServer\launch-buildserver32.cmd
    ) ELSE (
        start /MIN %~dp0\AI4A\BuildServer\launch-buildserver.cmd
    )
)
echo **************************************************
echo  Complete App Inventor Portable Settings now.
echo                         Let's enjoy App Inventing!
echo         Hit any key to default settings
echo **************************************************
pause
:END
set PATH=%STPATH%
set JAVA_HOME=
IF EXIST %CURDIR%\jnlp_userchoice_BkUp.reg (
    echo Delete FileExts\.jnlp backup data.
    REM reg import %CURDIR%\jnlp_userchoice_BkUp.reg
    del %CURDIR%\jnlp_userchoice_BkUp.reg
) ELSE (
    echo .jnlp\UserChoice registry key to default setting
    reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jnlp\UserChoice /f
)
IF EXIST %CURDIR%\jnlp_ext_BkUp.reg (
    echo Delete .jnlp backup data.
    REM reg import %CURDIR%\jnlp_ext_BkUp.reg
    del %CURDIR%\jnlp_ext_BkUp.reg
) ELSE (
    echo .jnlp registry key to default setting
    reg delete HKCU\Software\Classes\.jnlp /f
)
IF EXIST %CURDIR%\jnlp_auto_file_BkUp.reg (
    echo import jnlp_auto_file registry key from backup data.
    reg import %CURDIR%\jnlp_auto_file_BkUp.reg
    del %CURDIR%\jnlp_auto_file_BkUp.reg
) ELSE (
    echo jnlp_auto_file registry key to default setting
    reg delete HKCU\Software\Classes\jnlp_auto_file /f
)
echo ***************************************
echo Disabled JavaWebStart JNLP File Setting
echo ***************************************
IF %AIDIREXIST% == 0 (
    rmdir /S /Q "%AIDIR%"
)
taskkill /f /im adb.exe
echo **************************************************
echo Disabled App Inventor Portable Runtime Environment
echo **************************************************
pause
