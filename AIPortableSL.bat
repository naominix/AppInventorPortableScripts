@echo off
REM AppInventor Portable for Windows(32bit)
NET SESSION > NUL 2>&1
IF %ERRORLEVEL% == 0 (
    ECHO 管理者として実行中. AppInventor実行環境を設定します.
    GOTO STARTING
) ELSE (
    ECHO 管理者として実行していません. AppInventor環境セットアップが起動できません. 右クリックで「管理者として実行」で起動してください >&2
    PAUSE
    EXIT /B 1
)
:STARTING
set JAVA_HOME=%~dp0\jdk1.6.0_37_32
set STPATH=%PATH%
set PATH=%JAVA_HOME%\bin;%PATH%
set ISXP=1
assoc .jnlp=JNLPFile
ftype JNLPFile="%JAVA_HOME%\jre\bin\javaws.exe" "%%1"
ver|find "XP" > NUL
if %ERRORLEVEL% == 0 (
      set ISXP=0
      GOTO WINXP
)
mklink /D "C:\Program Files\AppInventor" %~dp0\AppInventor
GOTO CONFIG
:WINXP
echo Windows XP
.\linkd.exe "C:\Program Files\AppInventor" %~dp0\AppInventor
:CONFIG
pause
if %ISXP% == 0 GOTO WINXPEND
rmdir "C:\Program Files\AppInventor" 
GOTO END
:WINXPEND
.\linkd.exe "C:\Program Files\AppInventor" /d
:END
set PATH=%STPATH%
set JAVA_HOME=
ftype JNLPFile=""
assoc .jnlp=
