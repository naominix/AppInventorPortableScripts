@echo off
:STARTING
set CURDIR=%~dp0
set JAVA_HOME=%CURDIR%\jdk1.6.0_37_32
set STPATH=%PATH%
set PATH=%JAVA_HOME%\bin;%PATH%
set AIDIR=%CURDIR%\.appinventor
echo %JAVAWS_VM_ARGS%
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
reg add HKCU\Software\Classes\jnlp.for.ai\shell\open\command /t REG_SZ /d "%JAVA_HOME%\jre\bin\javaws.exe -J-Duser.home=%CURDIR% \"%%1\""
reg add HKCU\Software\Classes\.jnlp /t REG_SZ /d "jnlp.for.ai"
pause
:END
set PATH=%STPATH%
set JAVA_HOME=
set JAVAWS_VM_ARGS=
echo JavaWebStartの関連付けを解除します
reg delete HKCU\Software\Classes\.jnlp /f
reg delete HKCU\Software\Classes\jnlp.for.ai /f
IF %AIDIREXIST% == 0 (
    rmdir /S /Q "%AIDIR%"
)
pause
