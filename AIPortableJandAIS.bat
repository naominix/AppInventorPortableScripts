REM AppInventor Portable for Windows(64bit)
@echo off
NET SESSION > NUL 2>&1
IF %ERRORLEVEL% == 0 (
    ECHO 管理者として実行中. AppInventorを起動します.
    GOTO START
) ELSE (
    ECHO 管理者として実行していません. AppInventor環境セットアップが起動できません. 右クリックで「管理者として実行」で起動してください >&2
    PAUSE
    EXIT /B 1
)
:START
set JAVA_HOME=%~dp0\jdk1.6.0_37
set STPATH=%PATH%
set PATH=%JAVA_HOME%\bin;%PATH%
assoc .jnlp=JNLPFile
ftype JNLPFile="%JAVA_HOME%\jre\bin\javaws.exe" "%%1"
mklink /D "C:\Program Files\AppInventor" %~dp0\AppInventor
pause
rmdir "C:\Program Files\AppInventor" 
set PATH=%STPATH%
set JAVA_HOME=
ftype JNLPFile=
assoc .jnlp=
