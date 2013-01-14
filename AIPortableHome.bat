@echo off
:STARTING
set JAVA_HOME=%~dp0\jdk1.6.0_37_32
set STPATH=%PATH%
set UPPATH=%USERPROFILE%
set PATH=%JAVA_HOME%\bin;%PATH%
set USERPROFILE=%~dp0
set AIDIR=%USERPROFILE%\.appinventor
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
assoc .jnlp=JNLPFile
ftype JNLPFile="%JAVA_HOME%\jre\bin\javaws.exe" "%%1"
pause
:END
set PATH=%STPATH%
set USERPROFILE=%UPPATH%
set JAVA_HOME=
ftype JNLPFile=""
assoc .jnlp=
IF %AIDIREXIST% == 0 (
    rmdir /S /Q "%AIDIR%"
)
