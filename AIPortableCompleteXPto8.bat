@echo off
:STARTING
echo AppInventor実行環境セットアップ
set CURDIR=%~dp0
set JAVA_HOME=%CURDIR%\jdk1.6.0_37_32
set STPATH=%PATH%
set PATH=%JAVA_HOME%\bin;%PATH%
set AIDIR=%CURDIR%\.appinventor
set AIDIREXIST=0
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
echo JavaWebStartの関連付けを行います
reg add HKCU\Software\Classes\jnlp4ai\shell\open\command /ve /t REG_SZ /d "%JAVA_HOME%\jre\bin\javaws.exe -J-Duser.home=%CURDIR% \"%%1\""
reg add HKCU\Software\Classes\.jnlp /ve /t REG_SZ /d "jnlp4ai"
reg add HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jnlp\UserChoice /v ProgId /t REG_SZ /d "jnlp4ai"
pause
:END
set PATH=%STPATH%
set JAVA_HOME=
echo JavaWebStartの関連付けを解除します
reg delete HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.jnlp\UserChoice /f
reg delete HKCU\Software\Classes\.jnlp /f
reg delete HKCU\Software\Classes\jnlp4ai /f
IF %AIDIREXIST% == 0 (
    rmdir /S /Q "%AIDIR%"
)
echo AppInventor実行環境設定を解除します
pause
